import 'package:app_core/app_core.dart';
import 'package:habit_repository/habit_repository.dart';

part 'habit_heat_map_state.dart';

class HabitHeatMapCubit extends Cubit<HabitHeatMapState> {
  /// Creates a new instance of [PostCubit].
  /// Requires a [HabitRepository] to handle data operations.
  HabitHeatMapCubit({
    required HabitRepository habitRepository,
  })  : _habitRepository = habitRepository,
        super(const HabitHeatMapState.initial());

  final HabitRepository _habitRepository;

  Future<void> initHeatMap() async {
    emit(state.fromLoading());
    try {
      final firstLaunch = await _habitRepository.getFirstLaunchDate();
      emit(state.fromFirstLaunchLoaded(firstLaunch: firstLaunch));
    } on HabitFailure catch (failure) {
      emit(state.fromFailure(failure));
    }
  }

  void updateHabits(List<Habit> updatedHabits) {
    final dataset = _buildHeatMap(updatedHabits);
    emit(state.fromLoadedDataSet(dataset: dataset));
  }

  Map<DateTime, int> _buildHeatMap(List<Habit> habits) {
    Map<DateTime, int> dataset = {};
    for (var habit in habits) {
      for (var date in habit.completedDays) {
        final normalizedDate = DateTime(date.year, date.month, date.day);
        dataset[normalizedDate] = dataset.containsKey(normalizedDate)
            ? dataset[normalizedDate]! + 1
            : 1;
      }
    }
    return dataset;
  }
}
