import 'package:app_ui/app_ui.dart';

class HabitRabbit extends StatelessWidget {
  const HabitRabbit({required this.size, super.key});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(context.theme.defaultImagePath),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
