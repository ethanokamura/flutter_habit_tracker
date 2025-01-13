import 'dart:math';

import 'package:app_core/app_core.dart';
import 'package:api_client/api_client.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habit_repository/src/models/habit_completions.dart';
import 'package:habit_repository/src/models/supabase_habit.dart';

class HabitRepository {
  HabitRepository(Isar isar, {SupabaseClient? supabase})
      : _isar = isar,
        _supabase = supabase ?? Supabase.instance.client {
    _currentHabits = currentHabitChanges(_isar);
  }

  late final Isar _isar;
  late final SupabaseClient _supabase;
  late final ValueStream<List<Habit>> _currentHabits;
  List<Habit> _habitList = [];
  DateTime? lastSyncDate;
  final DateTime _today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  int _messageId = 0;
  final int _totalMessages = 30;

  /// Public getter for positive [_messageId]
  int get messageId => _messageId;

  // Stream of habit changes
  Stream<List<Habit>> get watchHabits =>
      _currentHabits.distinct().asBroadcastStream()
        ..listen((habits) {
          if (habits != currentHabits) {
            _habitList = habits;
          }
        });

  // Current habits data
  List<Habit> get currentHabits => _habitList;

  // Listens to auth state changes and returns a stream of the current habits
  ValueStream<List<Habit>> currentHabitChanges(Isar isarClient) =>
      isarClient.habits
          .watchLazy() // Watch for changes
          .asyncMap((_) async => isarClient.habits.where().findAll())
          .handleError((Object e) {
            throw HabitFailure.fromGet();
          })
          .logOnEach('HABITS')
          .shareValue();
}

extension Init on HabitRepository {
  // init repository
  Future<void> init() async {
    try {
      await _loadInitialHabits();
      await _storeLaunchDate();
    } catch (e) {
      throw HabitFailure.fromGet();
    }
  }

  // save first date of app startup (for heatmap)
  Future<void> _storeLaunchDate() async {
    try {
      final existingSettings = await _isar.appSettings.where().findFirst();
      if (existingSettings == null) {
        final settings = AppSettings()
          ..firstLaunchDate = _today
          ..lastLaunchDate = _today;
        await _isar.writeTxn(() => _isar.appSettings.put(settings));
      } else {
        lastSyncDate = existingSettings.lastLaunchDate;
        final settings = AppSettings()..lastLaunchDate = _today;
        await _isar.writeTxn(() => _isar.appSettings.put(settings));
      }
      _messageId = Random().nextInt(_totalMessages);
    } catch (e) {
      throw HabitFailure.fromGet();
    }
  }

  // Load the initial habits from Isar
  Future<void> _loadInitialHabits() async {
    try {
      // Fetch the habits initially from the database
      final fetchedHabits = await _isar.habits.where().findAll();
      _habitList = fetchedHabits;
    } catch (e) {
      throw HabitFailure.fromGet();
    }
  }
}

extension Create on HabitRepository {
  // create habit
  Future<void> addHabit({
    required String name,
    required String userId,
  }) async {
    try {
      // save to Supabase
      final habitId = await _addSupabaseHabit(name: name, userId: userId);
      // save to Isar
      final newHabit = Habit(name, habitId);
      await _isar.writeTxn(() => _isar.habits.put(newHabit));
    } catch (e) {
      throw HabitFailure.fromCreate();
    }
  }
}

extension Read on HabitRepository {
  // get the first date of app startup (for heatmap)
  Future<DateTime> getFirstLaunchDate() async {
    try {
      final settings = await _isar.appSettings.where().findFirst();
      if (settings == null || settings.firstLaunchDate == null) {
        return _today;
      }
      return settings.firstLaunchDate!;
    } catch (e) {
      throw HabitFailure.fromGet();
    }
  }

  // check to see if habit is completed
  Future<bool> isHabitComplete({required int id}) async {
    try {
      final habit = await _isar.habits.get(id);
      if (habit == null) return false;
      return habit.isCompleted;
    } catch (e) {
      throw HabitFailure.fromGet();
    }
  }
}

extension Update on HabitRepository {
  // change completion
  Future<void> updateHabitCompletion({
    required int id,
    required bool completed,
  }) async {
    // find specific habit
    final habit = await _isar.habits.get(id);
    if (habit == null) return;
    // update completion status
    try {
      await _isar.writeTxn(() async {
        // if habit is compelete   -> add date
        if (completed && !habit.completedDays.contains(_today)) {
          // add the current date if it is not already in the list
          habit.completedDays.add(_today);
        }
        // if habit is incompelete -> remove date
        else {
          habit.completedDays.removeWhere((date) => date == _today);
        }
        // save updated habits
        await _isar.habits.put(habit);
      });
    } catch (e) {
      throw HabitFailure.fromUpdate();
    }
  }

  // change name of habit
  Future<void> updateHabitName({
    required int id,
    required String newName,
  }) async {
    // find the specific habit
    final habit = await _isar.habits.get(id);
    if (habit == null) return;

    try {
      // update Supabase
      final data = SupabaseHabit.update(name: newName);
      await _supabase
          .fromHabitsTable()
          .upsert(data)
          .eq(SupabaseHabit.idConverter, habit.supabaseId!);
      // update Isar
      await _isar.writeTxn(() async {
        habit.name = newName;
        await _isar.habits.put(habit);
      });
    } catch (e) {
      throw HabitFailure.fromUpdate();
    }
  }
}

extension Delete on HabitRepository {
  // delete habit
  Future<void> deleteHabit({required int id}) async {
    // perform delete
    try {
      final habit = await _isar.habits.get(id);
      if (habit == null) return;
      final habitId = habit.supabaseId;
      // delete from Supabase
      if (habitId != null) {
        await _supabase
            .fromHabitsTable()
            .delete()
            .eq(SupabaseHabit.idConverter, habitId);
      }
      // delete from Isar
      await _isar.writeTxn(() async {
        await _isar.habits.delete(id);
      });
    } catch (e) {
      throw HabitFailure.fromDelete();
    }
  }
}

extension Sync on HabitRepository {
  Future<void> syncDatabase({required String userId}) async {
    try {
      final existingSettings = await _isar.appSettings.where().findFirst();
      if (existingSettings == null) return;
      final isSynced = existingSettings.synced;
      if (isSynced) return;
      await _syncWithSupabase(userId: userId);
    } catch (e) {
      print(e);
      throw HabitFailure.fromSync();
    }
  }

  Future<void> _syncWithSupabase({required String userId}) async {
    try {
      // get all isar habits
      final habits = await _isar.habits.where().findAll();
      if (habits.isEmpty) return;

      // index through each habit
      for (Habit habit in habits) {
        // add habit
        if (!habit.addedToSupabase) {
          final id = await _addSupabaseHabit(name: habit.name, userId: userId);
          await _isar.writeTxn(() async {
            habit.supabaseId = id;
            habit.addedToSupabase = true;
            await _isar.habits.put(habit);
          });
        }
        // sync completions
        else {
          await _syncHabitCompletions(habit: habit);
        }
      }
      await _markAsSynced();
    } catch (e) {
      print(e);
      throw HabitFailure.fromSync();
    }
  }

  Future<void> _markAsSynced() async {
    try {
      final existingSettings = await _isar.appSettings.where().findFirst();
      if (existingSettings == null) return;
      final settings = existingSettings..synced = true;
      await _isar.writeTxn(() => _isar.appSettings.put(settings));
    } catch (e) {
      print(e);
      throw HabitFailure.fromSync();
    }
  }

  Future<String> _addSupabaseHabit({
    required String name,
    required String userId,
  }) async {
    try {
      // save to Supabase
      final data = SupabaseHabit.insert(userId: userId, name: name);
      final res = await _supabase
          .fromHabitsTable()
          .insert(data)
          .select('id')
          .maybeSingle();
      if (res == null || res['id'] == null) return '';
      return res['id'] as String;
    } catch (e) {
      print(e);
      throw HabitFailure.fromCreate();
    }
  }

  Future<void> _syncHabitCompletions({required Habit habit}) async {
    try {
      final isarCompletedDays = habit.completedDays;
      final supabaseCompletedDays =
          await _fetchSupabaseHabitCompletions(habitId: habit.supabaseId!);
      // add completions in supabase
      for (DateTime completedDay in isarCompletedDays) {
        if (!supabaseCompletedDays.contains(completedDay)) {
          _addSupabaseCompletedDay(
            habitId: habit.supabaseId!,
            completedDay: completedDay,
          );
        }
        // remove unnecessary days
        if (_isLastWeek(completedDay)) {
          habit.completedDays.remove(completedDay);
          await _isar.writeTxn(() => _isar.habits.put(habit));
        }
      }
      // remove completions in supabase
      for (DateTime completedDay in supabaseCompletedDays) {
        if (!isarCompletedDays.contains(completedDay)) {
          _removeSupabaseCompletedDay(
            habitId: habit.supabaseId!,
            completedDay: completedDay,
          );
        }
      }
    } catch (e) {
      print(e);
      throw HabitFailure.fromSync();
    }
  }

  bool _isLastWeek(DateTime date) {
    final startOfWeek = _today.subtract(Duration(days: DateTime.now().weekday));
    print('is last week: ${date.isBefore(startOfWeek)}');
    return date.isBefore(startOfWeek);
  }

  Future<Set<DateTime>> _fetchSupabaseHabitCompletions({
    required String habitId,
  }) async {
    try {
      final habitCompletions = await _supabase
          .fromHabitCompletionsTable()
          .select()
          .eq(HabitCompletions.habitIdConverter, habitId)
          .withConverter(HabitCompletions.converter);
      final days =
          habitCompletions.map((completion) => completion.createdAt!).toSet();
      return days;
    } catch (e) {
      print(e);
      throw HabitFailure.fromGet();
    }
  }

  Future<void> _addSupabaseCompletedDay({
    required String habitId,
    required DateTime completedDay,
  }) async {
    final data = HabitCompletions.insert(
      habitId: habitId,
      createdAt: completedDay,
    );
    try {
      await _supabase.fromHabitCompletionsTable().insert(data);
    } catch (e) {
      print(e);
      throw HabitFailure.fromCreate();
    }
  }

  Future<void> _removeSupabaseCompletedDay({
    required String habitId,
    required DateTime completedDay,
  }) async {
    try {
      await _supabase.fromHabitCompletionsTable().delete().match({
        HabitCompletions.habitIdConverter: habitId,
        HabitCompletions.createdAtConverter: completedDay,
      });
    } catch (e) {
      print(e);
      throw HabitFailure.fromDelete();
    }
  }
}
