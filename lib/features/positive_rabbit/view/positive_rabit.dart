import 'package:app_ui/app_ui.dart';
import 'package:habit_tracker/features/positive_rabbit/view/positive_message.dart';
import 'package:habit_tracker/l10n/l10n.dart';

class PositiveRabit extends StatelessWidget {
  const PositiveRabit({
    required this.size,
    required this.id,
    super.key,
  });
  final double size;
  final int id;
  @override
  Widget build(BuildContext context) {
    final message = showRandomMessage(context, id);
    return Row(
      children: [
        HabitRabbit(size: 96),
        Expanded(child: PositiveMessage(message: message)),
      ],
    );
  }
}

String showRandomMessage(BuildContext context, int id) {
  final messages = context.l10n.positiveReinforcement.split('|');
  final randomMessage = messages[id];
  return randomMessage;
}
