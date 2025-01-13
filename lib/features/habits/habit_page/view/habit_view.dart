import 'package:app_core/app_core.dart';
import 'package:app_ui/app_ui.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habit_tracker/features/habits/cubit/habit_cubit.dart';
import 'package:habit_tracker/features/habits/habit_page/view/habit_list.dart';
import 'package:habit_tracker/features/habits/habit_page/view/edit_habit.dart';
import 'package:habit_tracker/features/habits/habit_page/view/remove_habit_popup.dart';
import 'package:habit_tracker/features/heatmap/heatmap.dart';
import 'package:habit_tracker/features/heatmap/streak/streak.dart';
import 'package:habit_tracker/features/positive_rabbit/positive_rabbit.dart';
import 'package:habit_tracker/features/profile/profile.dart';
import 'package:habit_tracker/l10n/l10n.dart';

class HabitPageView extends StatelessWidget {
  const HabitPageView({required this.habitCubit, super.key});
  final HabitCubit habitCubit;
  @override
  Widget build(BuildContext context) {
    void handleExit() => context.popUntil((route) => route.isFirst);
    return CustomPageView(
      title: DateFormatter.formatTimestamp(DateTime.now()),
      centerTitle: false,
      actions: [
        AppBarButton(
          icon: AppIcons.settings,
          onTap: () async => profilePopUp(context),
        )
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: () async => showDialog(
          context: context,
          builder: (context) {
            return EditHabitBox(
              onSave: (value) async => habitCubit.saveNewHabit(name: value),
              onCancel: handleExit,
            );
          },
        ),
        child: const Icon(AppIcons.create),
      ),
      body: ListView(
        children: [
          PositiveRabit(
            size: 96,
            id: context.read<HabitRepository>().messageId,
          ),
          SizedBox(
            height: 60,
            child: WeekView(habits: habitCubit.state.habits),
          ),
          StreakWidget(habits: habitCubit.state.habits),
          const VerticalSpacer(),
          TitleText(text: '${context.l10n.habits}:'),
          const VerticalSpacer(),
          habitCubit.state.habits.isEmpty
              ? Center(child: PrimaryText(text: context.l10n.emptyHabitList))
              : HabitList(
                  habits: habitCubit.state.habits,
                  onChanged: (value, id) async =>
                      habitCubit.toggleCompletion(id: id!),
                  onEdit: (id) async => showDialog(
                    context: context,
                    builder: (context) {
                      return EditHabitBox(
                        onSave: (value) async => habitCubit.updateExistingHabit(
                            id: id!, name: value),
                        onCancel: handleExit,
                      );
                    },
                  ),
                  onDelete: (id) async => showDialog(
                    context: context,
                    builder: (context) {
                      return RemoveHabitPopup(
                        onDelete: () async {
                          await habitCubit.removeHabit(id: id!);
                          handleExit();
                        },
                        onCancel: handleExit,
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
