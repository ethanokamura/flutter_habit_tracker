import 'package:app_ui/app_ui.dart';

class PositiveMessage extends StatelessWidget {
  const PositiveMessage({required this.message, super.key});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.colorScheme.surface,
      borderRadius: defaultBorderRadius,
      elevation: defaultElevation,
      child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: PrimaryText(text: message, maxLines: 10),
      ),
    );
  }
}
