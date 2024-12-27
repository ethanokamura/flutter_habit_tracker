import 'package:app_ui/app_ui.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habit_tracker/features/habits/view/habit_tile.dart';

class HabitList extends StatelessWidget {
  const HabitList({
    required this.habits,
    required this.onChanged,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });
  final List<Habit> habits;
  final void Function(bool?, int?) onChanged;
  final void Function(int?) onEdit;
  final void Function(int?) onDelete;
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
        return HabitTile(
          id: currentHabit.id,
          title: currentHabit.name,
          completed: currentHabit.isCompleted,
          onChanged: (value) => onChanged(value, currentHabit.id),
          onEdit: (context) => onEdit(currentHabit.id),
          onDelete: (context) => onDelete(currentHabit.id),
        );
      },
    );
  }
}
