import 'package:app_core/app_core.dart';
import 'package:habit_repository/habit_repository.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  /// Constructs AppCubit
  /// Takes in UserRepository instance and sets the initial AppState.
  AppCubit({
    required HabitRepository habitRepository,
  })  : _habitRepository = habitRepository,
        super(_initialState(habitRepository.currentHabits)) {
    _watchHabits();
  }

  final HabitRepository _habitRepository;

  @override
  Future<void> close() async {
    await _unwatchHabits();
    return super.close();
  }

  /// Sets initial auth state for the app
  /// Checks to see the current status of user authetication
  static AppState _initialState(List<Habit>? habits) {
    if (habits == null || habits.isEmpty) {
      return const AppState.empty();
    }
    return AppState.loaded(habits: habits);
  }

  /// Listens to auth changes and updates state accordingly
  void _onHabitsChanged(List<Habit> habits) {
    if (habits.isEmpty && state.isEmpty) return;
    if (habits.isEmpty) {
      emit(const AppState.empty());
    } else {
      emit(AppState.loaded(habits: habits));
    }
  }

  /// Listens to auth failures and updates state accordingly
  void _onHabitsFailed(HabitFailure failure) {
    final currentState = state;
    emit(AppState.failure(failure: failure, habits: currentState.habits));
  }

  late final StreamSubscription<List<Habit>> _habitSubscription;

  // Listens to auth changes
  void _watchHabits() {
    _habitSubscription = _habitRepository.watchHabits
        .handleFailure(_onHabitsFailed)
        .listen(_onHabitsChanged);
  }

  Future<void> _unwatchHabits() {
    return _habitSubscription.cancel();
  }
}
