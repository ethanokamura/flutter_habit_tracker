import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habit_tracker/features/heatmap/cubit/habit_heat_map_cubit.dart';
import 'package:habit_tracker/features/heatmap/view/heatmap_view.dart';
import 'package:habit_tracker/l10n/l10n.dart';

class HabitHeatMap extends StatelessWidget {
  const HabitHeatMap({required this.habits, super.key});
  final List<Habit> habits;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HabitHeatMapCubit(
        habitRepository: context.read<HabitRepository>(),
      )..initHeatMap(),
      child: BlocBuilder<HabitHeatMapCubit, HabitHeatMapState>(
        builder: (context, state) {
          if (state.isLoading) {
            return _loadingWidget();
          } else if (state.isFailure) {
            return _errorWidget(context.l10n.failureToLoad);
          }
          final dataset = _buildHeatMap(habits);
          final startDate = state.firstLaunchDate;
          return HabitHeatMapView(startDate: startDate!, datasets: dataset);
        },
      ),
    );
  }
}

Map<DateTime, int> _buildHeatMap(List<Habit> habits) {
  Map<DateTime, int> dataset = {};
  for (var habit in habits) {
    for (var date in habit.completedDays) {
      // normalize date to avoid time discrepencies
      final normalizedDate = DateTime(date.year, date.month, date.day);
      // if date already exists, increment count
      dataset[normalizedDate] = dataset.containsKey(normalizedDate)
          ? dataset[normalizedDate]! + 1
          : 1;
    }
  }
  return dataset;
}

Widget _loadingWidget() {
  return const Center(child: CircularProgressIndicator());
}

Widget _errorWidget(String message) {
  return Center(child: TitleText(text: message));
}
