import 'package:app_ui/app_ui.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habit_tracker/features/habits/habit_progress/view/habit_progress_tile.dart';

class HabitProgressList extends StatelessWidget {
  const HabitProgressList({
    required this.habits,
    required this.totalDays,
    super.key,
  });
  final List<Habit> habits;
  final int totalDays;
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
          totalDays: totalDays,
        );
      },
    );
  }
}
