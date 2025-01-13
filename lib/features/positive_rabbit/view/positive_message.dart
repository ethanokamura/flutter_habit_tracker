import 'package:app_ui/app_ui.dart';

class PositiveMessage extends StatelessWidget {
  const PositiveMessage({required this.message, super.key});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: context.theme.accentColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(defaultRadius),
            topRight: Radius.circular(defaultRadius),
            bottomRight: Radius.circular(defaultRadius),
          ),
          elevation: 0,
          child: Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: PrimaryText(text: message, maxLines: 10),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          child: CustomPaint(
            painter: ChatBubbleTailPainter(context: context),
          ),
        ),
      ],
    );
  }
}

class ChatBubbleTailPainter extends CustomPainter {
  ChatBubbleTailPainter({required this.context});
  final BuildContext context;

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint()
      ..color = context.theme.accentColor
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(-10, 20);
    path.lineTo(0, 20);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  Size get size => const Size(10, 20);
}
