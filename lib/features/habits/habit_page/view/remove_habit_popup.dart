import 'package:app_ui/app_ui.dart';
import 'package:habit_tracker/l10n/l10n.dart';

class RemoveHabitPopup extends StatelessWidget {
  const RemoveHabitPopup({
    required this.onDelete,
    required this.onCancel,
    super.key,
  });
  final VoidCallback onDelete;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: PrimaryText(text: context.l10n.confirmDelete, staticSize: true),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        SizedBox(
          width: 100,
          child: DefaultButton(
            onSurface: true,
            text: context.l10n.cancel,
            onTap: onCancel,
          ),
        ),
        SizedBox(
          width: 100,
          child: ActionButton(text: context.l10n.delete, onTap: onDelete),
        ),
      ],
    );
  }
}
