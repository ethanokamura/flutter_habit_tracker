import 'package:app_ui/app_ui.dart';
import 'package:habit_tracker/l10n/l10n.dart';

class EditHabitBox extends StatelessWidget {
  const EditHabitBox({
    required this.controller,
    required this.onSave,
    required this.onCancel,
    super.key,
  });
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: customTextFormField(
        context: context,
        label: context.l10n.editHabitName,
        controller: controller,
        maxLength: 128,
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        SizedBox(
          width: 100,
          child: SurfaceButton(text: context.l10n.cancel, onTap: onCancel),
        ),
        SizedBox(
          width: 100,
          child: ActionButton(text: context.l10n.save, onTap: onSave),
        ),
      ],
    );
  }
}
