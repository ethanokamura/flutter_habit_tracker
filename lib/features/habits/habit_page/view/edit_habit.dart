import 'package:app_ui/app_ui.dart';
import 'package:habit_tracker/l10n/l10n.dart';

class EditHabitBox extends StatefulWidget {
  const EditHabitBox({
    required this.onSave,
    required this.onCancel,
    super.key,
  });
  final ValueChanged<String> onSave;
  final VoidCallback onCancel;

  @override
  State<EditHabitBox> createState() => _EditHabitBoxState();
}

class _EditHabitBoxState extends State<EditHabitBox> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(); // Initialize the controller
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: customTextFormField(
        context: context,
        label: context.l10n.editHabitName,
        controller: _controller,
        maxLength: 128,
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        SizedBox(
          width: 100,
          child: DefaultButton(
            onSurface: true,
            text: context.l10n.cancel,
            onTap: widget.onCancel,
          ),
        ),
        SizedBox(
          width: 100,
          child: ActionButton(
            text: context.l10n.save,
            onTap: () {
              widget.onSave(_controller.text.trim());
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ),
      ],
    );
  }
}
