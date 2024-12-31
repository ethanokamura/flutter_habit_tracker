import 'package:app_ui/app_ui.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habit_tracker/features/habits/habit_progress/view/habit_progress_tile.dart';

class HabitProgressList extends StatelessWidget {
  const HabitProgressList({
    required this.habits,
    super.key,
  });
  final List<Habit> habits;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: defaultPadding),
      separatorBuilder: (context, index) => const VerticalSpacer(),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: habits.length,
      // habit tiles
      itemBuilder: (context, index) {
        final currentHabit = habits[index];
        return HabitProgressTile(
          habit: currentHabit,
          totalDays: getTotalDays(currentHabit.completedDays.first),
        );
      },
    );
  }
}

int getTotalDays(DateTime? startDate) {
  if (startDate == null) return 1;
  final now = DateTime.now();

  // Ensure we only compare dates without time
  final today = DateTime(now.year, now.month, now.day);
  final targetDate = DateTime(
    startDate.year,
    startDate.month,
    startDate.day,
  );

  // Calculate the difference
  final difference = today.difference(targetDate).inDays;

  return difference + 1;
}
