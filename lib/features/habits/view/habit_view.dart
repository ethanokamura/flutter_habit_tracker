import 'package:app_ui/app_ui.dart';
import 'package:habit_tracker/features/habits/cubit/habit_cubit.dart';
import 'package:habit_tracker/features/habits/habits.dart';
import 'package:habit_tracker/features/habits/view/habit_popup.dart';
import 'package:habit_tracker/features/heatmap/heatmap.dart';
import 'package:habit_tracker/features/settings/settings.dart';
import 'package:habit_tracker/l10n/l10n.dart';

class HabitPageView extends StatefulWidget {
  const HabitPageView({required this.habitCubit, super.key});
  final HabitCubit habitCubit;
  @override
  State<HabitPageView> createState() => _HabitPageViewState();
}

class _HabitPageViewState extends State<HabitPageView> {
  final _habitTextController = TextEditingController();

  // cancel new habit
  void cancelDialogBox() {
    _habitTextController.clear();
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  void dispose() {
    _habitTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageView(
      title: context.l10n.appTitle,
      floatingActionButton: FloatingActionButton(
        onPressed: () async => showDialog(
          context: context,
          builder: (context) {
            return EditHabitBox(
              controller: _habitTextController,
              onSave: () async {
                await widget.habitCubit
                    .saveNewHabit(name: _habitTextController.text.trim());
                if (!context.mounted) return;
                Navigator.of(context, rootNavigator: true).pop();
              },
              onCancel: cancelDialogBox,
            );
          },
        ),
        child: const Icon(AppIcons.create),
      ),
      actions: [
        AppBarButton(
          icon: AppIcons.settings,
          onTap: () => Navigator.push(
            context,
            bottomSlideTransition(SettingsPage()),
          ),
        )
      ],
      body: ListView(
        children: [
          VerticalSpacer(),
          HabitHeatMap(habits: widget.habitCubit.state.habits),
          HabitList(
            habits: widget.habitCubit.state.habits,
            onChanged: (value, id) async =>
                widget.habitCubit.toggleCompletion(id: id!),
            onEdit: (id) async => showDialog(
              context: context,
              builder: (context) {
                return EditHabitBox(
                  controller: _habitTextController,
                  onSave: () async {
                    await widget.habitCubit.updateExistingHabit(
                      id: id!,
                      name: _habitTextController.text.trim(),
                    );
                    if (!context.mounted) return;
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  onCancel: cancelDialogBox,
                );
              },
            ),
            onDelete: (id) async => showDialog(
              context: context,
              builder: (context) {
                return RemoveHabitPopup(
                  onDelete: () async {
                    await widget.habitCubit.removeHabit(id: id!);
                    if (!context.mounted) return;
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  onCancel: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
