import 'package:app_core/app_core.dart';
import 'package:api_client/api_client.dart';
import 'package:habit_repository/habit_repository.dart';

class HabitRepository {
  HabitRepository(Isar isar) : _isar = isar {
    _currentHabits = currentHabitChanges(_isar);
  }

  late final Isar _isar;
  late final ValueStream<List<Habit>> _currentHabits;
  List<Habit> _habitList = [];

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

  // save first date of app startup (for heatmap)
  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await _isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await _isar.writeTxn(() => _isar.appSettings.put(settings));
    }
  }

  // get the first date of app startup (for heatmap)
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await _isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

  // Load the initial habits from Isar
  Future<void> loadInitialHabits() async {
    try {
      // Fetch the habits initially from the database
      final fetchedHabits = await _isar.habits.where().findAll();
      _habitList = fetchedHabits;
    } catch (e) {
      throw HabitFailure.fromGet();
    }
  }

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

  // create habit
  Future<void> addHabit({required String habitName}) async {
    // create habit
    final newHabit = Habit()..name = habitName;

    // save to db
    try {
      await _isar.writeTxn(() => _isar.habits.put(newHabit));
    } catch (e) {
      throw HabitFailure.fromCreate();
    }
  }

  // change completion
  Future<void> updateHabitCompletion({
    required int id,
    required bool completed,
  }) async {
    // find specific habit
    final habit = await _isar.habits.get(id);

    // update completion status
    try {
      if (habit != null) {
        await _isar.writeTxn(() async {
          // if habit is compelete   -> add date
          if (completed && !habit.completedDays.contains(DateTime.now())) {
            final today = DateTime.now();

            // add the current date if it is not already in the list
            habit.completedDays.add(
              DateTime(today.year, today.month, today.day),
            );
          }
          // if habit is incompelete -> remove date
          else {
            habit.completedDays.removeWhere((date) =>
                date.year == DateTime.now().year &&
                date.month == DateTime.now().month &&
                date.day == DateTime.now().day);
          }
          // save updated habits
          await _isar.habits.put(habit);
        });
      }
    } catch (e) {
      throw HabitFailure.fromUpdate();
    }
  }

  // check to see if habit is completed
  Future<bool> isHabitComplete({required int id}) async {
    final habit = await _isar.habits.get(id);
    if (habit == null) return false;
    return habit.isCompleted;
  }

  // change name of habit
  Future<void> updateHabitName({
    required int id,
    required String newName,
  }) async {
    // find the specific habit
    final habit = await _isar.habits.get(id);
    // update habit name
    if (habit == null) return;
    try {
      await _isar.writeTxn(() async {
        // update name
        habit.name = newName;
        // save updated habit back to db
        await _isar.habits.put(habit);
      });
    } catch (e) {
      throw HabitFailure.fromUpdate();
    }
  }

  // delete habit
  Future<void> deleteHabit({required int id}) async {
    // perform delete
    try {
      await _isar.writeTxn(() async {
        await _isar.habits.delete(id);
      });
    } catch (e) {
      throw HabitFailure.fromDelete();
    }
  }
}
