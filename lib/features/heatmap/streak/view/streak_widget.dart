import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habit_tracker/features/heatmap/cubit/habit_heat_map_cubit.dart';
import 'package:habit_tracker/l10n/l10n.dart';

class StreakWidget extends StatelessWidget {
  const StreakWidget({
    required this.habits,
    super.key,
  });

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
          context.read<HabitHeatMapCubit>().updateHabits(habits);
          final streak = calculateCurrentStreak(state.dataset);
          print(streak);
          return _streakContainer(context, streak);
        },
      ),
    );
  }
}

Widget _loadingWidget() => const Center(child: CircularProgressIndicator());
Widget _errorWidget(String message) => Center(child: TitleText(text: message));

// get the current habit streak!
int calculateCurrentStreak(Map<DateTime, int> datasets) {
  // Normalize dates to ensure only the date part is considered
  final normalizedDatasets = datasets.map((date, value) =>
      MapEntry(DateTime(date.year, date.month, date.day), value));

  // Get the sorted list of dates
  final sortedDates = normalizedDatasets.keys.toList()..sort();

  // Start from today, normalized
  final today = DateTime.now();
  final normalizedToday = DateTime(today.year, today.month, today.day);
  int streak = 0;

  // Check consecutive days
  for (int i = sortedDates.length - 1; i >= 0; i--) {
    final date = sortedDates[i];
    final value = normalizedDatasets[date] ?? 0;

    // Expected date in the streak
    final expectedDate = normalizedToday.subtract(Duration(days: streak));

    if (date == expectedDate && value > 0) {
      streak++; // Increment streak
    } else if (date.isBefore(expectedDate)) {
      break; // Gap found; end streak
    }
  }

  return streak;
}

Widget _streakContainer(BuildContext context, int streak) => streak > 1
    ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const VerticalSpacer(),
          DefaultContainer(child: TitleText(text: context.l10n.streak(streak))),
          const VerticalSpacer(),
        ],
      )
    : SizedBox.shrink();
