import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habit_tracker/features/heatmap/cubit/habit_heat_map_cubit.dart';
import 'package:habit_tracker/features/heatmap/view/hm_month.dart';
import 'package:habit_tracker/l10n/l10n.dart';

class MonthView extends StatelessWidget {
  const MonthView({
    required this.habits,
    required this.year,
    required this.month,
    super.key,
  });
  final List<Habit> habits;
  final int year;
  final int month;
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
          context.read<HabitHeatMapCubit>().updateHabits(habits);
          final dataset = state.dataset;
          return MonthlyHeatMap(
            datasets: dataset,
            year: year,
            month: month,
          );
        },
      ),
    );
  }
}

Widget _loadingWidget() {
  return const Center(child: CircularProgressIndicator());
}

Widget _errorWidget(String message) {
  return Center(child: TitleText(text: message));
}
