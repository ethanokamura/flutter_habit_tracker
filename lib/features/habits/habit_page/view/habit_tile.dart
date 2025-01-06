import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habit_tracker/features/habits/cubit/habit_cubit.dart';
import 'package:habit_tracker/l10n/l10n.dart';
import 'package:user_repository/user_repository.dart';

class HabitTile extends StatelessWidget {
  const HabitTile({
    required this.id,
    required this.title,
    required this.completed,
    required this.onChanged,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final int id;
  final String title;
  final bool completed;
  final void Function(bool?) onChanged;
  final void Function(BuildContext) onEdit;
  final void Function(BuildContext) onDelete;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          HorizontalSpacer(),
          // edit
          SlidableAction(
            onPressed: onEdit,
            icon: AppIcons.edit,
            backgroundColor: context.theme.colorScheme.primary,
            borderRadius: defaultBorderRadius,
          ),
          HorizontalSpacer(),
          // delete
          SlidableAction(
            onPressed: onDelete,
            icon: AppIcons.delete,
            backgroundColor: Colors.red,
            borderRadius: defaultBorderRadius,
          ),
        ],
      ),
      child: BlocProvider(
        create: (_) => HabitCubit(
          habitRepository: context.read<HabitRepository>(),
          userRepository: context.read<UserRepository>(),
        )..checkHabitCompletion(id: id),
        child: BlocBuilder<HabitCubit, HabitState>(
          builder: (context, state) {
            if (state.isLoading) {
              return HabitTileButton(
                completed: false,
                onTap: null,
                text: title,
                icon: AppIcons.notChecked,
              );
            }
            if (state.isLoaded) {
              return HabitTileButton(
                completed: state.completed,
                onTap: () =>
                    context.read<HabitCubit>().toggleCompletion(id: id),
                text: title,
                icon: state.completed ? AppIcons.checked : AppIcons.notChecked,
              );
            }
            return HabitTileButton(
              completed: false,
              onTap: null,
              text: context.l10n.failureToLoad,
              icon: AppIcons.notChecked,
            );
          },
        ),
      ),
    );
  }
}
