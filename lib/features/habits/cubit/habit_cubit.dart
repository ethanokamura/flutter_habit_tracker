import 'package:app_core/app_core.dart';
import 'package:habit_repository/habit_repository.dart';

part 'habit_state.dart';

class HabitCubit extends Cubit<HabitState> {
  /// Creates a new instance of [PostCubit].
  /// Requires a [HabitRepository] to handle data operations.
  HabitCubit({
    required HabitRepository habitRepository,
  })  : _habitRepository = habitRepository,
        super(HabitState.initial()) {
    _fetchInitialList();
    _watchHabits();
  }

  final HabitRepository _habitRepository;

  /// Stops listening to the current user
  @override
  Future<void> close() async {
    await _unwatchHabits();
    return super.close();
  }

  late final StreamSubscription<List<Habit>> _currentHabitSubscription;

  void _fetchInitialList() {
    emit(state.fromLoading());
    final habits = _habitRepository.currentHabits;
    try {
      emit(state.fromHabitsLoaded(habits: habits));
    } on HabitFailure catch (failure) {
      emit(state.fromFailure(failure));
    }
  }

  /// Listens to the current user by their ID
  void _watchHabits() {
    _currentHabitSubscription =
        _habitRepository.watchHabits.handleFailure().listen(
              (habits) => emit(state.fromHabitsLoaded(habits: habits)),
              onError: (e) => emit(state.fromFailure(e)),
            );
  }

  /// Private helper funciton to cancel the user subscription
  Future<void> _unwatchHabits() async => _currentHabitSubscription.cancel();

  Future<void> checkHabitCompletion({required int id}) async {
    emit(state.fromLoading());
    try {
      final completed = await _habitRepository.isHabitComplete(id: id);
      emit(state.fromActionLoaded(completed: completed));
    } on HabitFailure catch (failure) {
      emit(state.fromFailure(failure));
    }
  }

  Future<void> toggleCompletion({
    required int id,
  }) async {
    emit(state.fromLoading());
    bool completed = !state.completed;
    try {
      await _habitRepository.updateHabitCompletion(
        id: id,
        completed: completed,
      );
      emit(state.fromActionLoaded(completed: completed));
    } on HabitFailure catch (failure) {
      emit(state.fromFailure(failure));
    }
  }

  // create new habit
  Future<void> saveNewHabit({required String name}) async {
    emit(state.fromLoading());
    try {
      await _habitRepository.addHabit(habitName: name);
      emit(state.fromLoaded());
    } on HabitFailure catch (failure) {
      emit(state.fromFailure(failure));
    }
  }

  // update habit
  Future<void> updateExistingHabit({
    required int id,
    required String name,
  }) async {
    emit(state.fromLoading());
    try {
      await _habitRepository.updateHabitName(id: id, newName: name);
      emit(state.fromLoaded());
    } on HabitFailure catch (failure) {
      emit(state.fromFailure(failure));
    }
  }

  // remove habit
  Future<void> removeHabit({required int id}) async {
    emit(state.fromLoading());
    try {
      await _habitRepository.deleteHabit(id: id);
      emit(state.fromLoaded());
    } on HabitFailure catch (failure) {
      emit(state.fromFailure(failure));
    }
  }

  Future<void> getLaunchDate() async {
    emit(state.fromLoading());
    try {
      var launchDate = await _habitRepository.getFirstLaunchDate();
      emit(state.fromLaunchLoaded(launchDate: launchDate));
    } on HabitFailure catch (failure) {
      emit(state.fromFailure(failure));
    }
  }
}
