import 'package:app_ui/app_ui.dart';
import 'package:habit_repository/habit_repository.dart';

class HabitProgressTile extends StatelessWidget {
  const HabitProgressTile({
    required this.habit,
    required this.totalDays,
    super.key,
  });
  final Habit habit;
  final int totalDays;
  @override
  Widget build(BuildContext context) {
    return DefaultContainer(
      accent: habit.completedDays.length / totalDays > .5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TitleText(text: habit.name),
          SecondaryText(
            text: '${habit.completedDays.length}/$totalDays days',
            staticSize: true,
          ),
        ],
      ),
    );
  }
}
