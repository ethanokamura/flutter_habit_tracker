import 'package:app_ui/app_ui.dart';

class AppBarText extends StatelessWidget {
  const AppBarText({
    required this.text,
    this.maxLines,
    this.fontSize,
    this.staticSize,
    super.key,
  });
  final String text;
  final int? maxLines;
  final double? fontSize;
  final bool? staticSize;
  @override
  Widget build(BuildContext context) {
    return staticSize != null && staticSize!
        ? Text(
            text.toUpperCase(),
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines ?? 1,
            style: TextStyle(
              color: context.theme.textColor,
              fontSize: fontSize ?? 28,
              fontWeight: FontWeight.bold,
            ),
          )
        : AutoSizeText(
            text.toUpperCase(),
            overflow: TextOverflow.ellipsis,
            maxFontSize: fontSize ?? 28,
            maxLines: maxLines ?? 1,
            style: TextStyle(
              color: context.theme.textColor,
              fontSize: fontSize ?? 28,
              fontWeight: FontWeight.bold,
            ),
          );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({
    required this.text,
    this.maxLines,
    this.fontSize,
    this.staticSize,
    this.alignment,
    super.key,
  });
  final String text;
  final int? maxLines;
  final double? fontSize;
  final bool? staticSize;
  final TextAlign? alignment;
  @override
  Widget build(BuildContext context) {
    return staticSize != null && staticSize!
        ? Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines ?? 1,
            textAlign: alignment,
            style: TextStyle(
              color: context.theme.textColor,
              fontSize: fontSize ?? 20,
              fontWeight: FontWeight.bold,
            ),
          )
        : AutoSizeText(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines ?? 1,
            maxFontSize: fontSize ?? 20,
            textAlign: alignment,
            style: TextStyle(
              color: context.theme.textColor,
              fontSize: fontSize ?? 20,
              fontWeight: FontWeight.bold,
            ),
          );
  }
}

class HabitText extends StatelessWidget {
  const HabitText({
    required this.text,
    required this.completed,
    this.maxLines,
    this.fontSize,
    this.staticSize,
    super.key,
  });
  final String text;
  final bool completed;
  final int? maxLines;
  final double? fontSize;
  final bool? staticSize;
  @override
  Widget build(BuildContext context) {
    return staticSize != null && staticSize!
        ? Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines ?? 1,
            style: TextStyle(
              color: completed
                  ? context.theme.inverseTextColor
                  : context.theme.textColor,
              fontSize: fontSize ?? 20,
              fontWeight: FontWeight.bold,
            ),
          )
        : AutoSizeText(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines ?? 1,
            maxFontSize: fontSize ?? 20,
            style: TextStyle(
              color: completed
                  ? context.theme.inverseTextColor
                  : context.theme.textColor,
              fontSize: fontSize ?? 20,
              fontWeight: FontWeight.bold,
            ),
          );
  }
}

class PrimaryText extends StatelessWidget {
  const PrimaryText({
    required this.text,
    this.maxLines,
    this.fontSize,
    this.inverted,
    this.staticSize,
    this.alignment,
    super.key,
  });
  final String text;
  final int? maxLines;
  final double? fontSize;
  final bool? inverted;
  final bool? staticSize;
  final TextAlign? alignment;
  @override
  Widget build(BuildContext context) {
    return staticSize != null && staticSize!
        ? Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines ?? 1,
            textAlign: alignment,
            style: TextStyle(
              color: inverted == null || !inverted!
                  ? context.theme.textColor
                  : context.theme.inverseTextColor,
              fontSize: fontSize ?? 16,
            ),
          )
        : AutoSizeText(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines ?? 1,
            maxFontSize: fontSize ?? 16,
            textAlign: alignment,
            style: TextStyle(
              color: inverted == null || !inverted!
                  ? context.theme.textColor
                  : context.theme.inverseTextColor,
              fontSize: fontSize ?? 16,
            ),
          );
  }
}

class SecondaryText extends StatelessWidget {
  const SecondaryText({
    required this.text,
    this.alignment,
    this.maxLines,
    this.fontSize,
    this.staticSize,
    super.key,
  });
  final String text;
  final TextAlign? alignment;
  final int? maxLines;
  final double? fontSize;
  final bool? staticSize;
  @override
  Widget build(BuildContext context) {
    return staticSize != null && staticSize!
        ? Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines ?? 1,
            textAlign: alignment,
            style: TextStyle(
              color: context.theme.subtextColor,
              fontSize: fontSize ?? 14,
            ),
          )
        : AutoSizeText(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines ?? 1,
            maxFontSize: fontSize ?? 14,
            textAlign: alignment,
            style: TextStyle(
              color: context.theme.subtextColor,
              fontSize: fontSize ?? 14,
            ),
          );
  }
}

class UserText extends StatelessWidget {
  const UserText({
    required this.text,
    required this.bold,
    this.alignment,
    this.fontSize,
    this.maxLines,
    this.staticSize,
    super.key,
  });
  final String text;
  final bool bold;
  final TextAlign? alignment;
  final int? maxLines;
  final double? fontSize;
  final bool? staticSize;
  @override
  Widget build(BuildContext context) {
    return staticSize != null && staticSize!
        ? Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines ?? 1,
            textAlign: alignment,
            style: TextStyle(
              color: context.theme.accentColor,
              fontSize: fontSize ?? 18,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          )
        : AutoSizeText(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines ?? 1,
            maxFontSize: fontSize ?? 18,
            textAlign: alignment,
            style: TextStyle(
              color: context.theme.accentColor,
              fontSize: fontSize ?? 18,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          );
  }
}

class ButtonText extends StatelessWidget {
  const ButtonText({
    required this.text,
    required this.inverted,
    this.alignment,
    this.maxLines,
    this.fontSize,
    this.staticSize,
    super.key,
  });
  final String text;
  final bool inverted;
  final TextAlign? alignment;
  final int? maxLines;
  final double? fontSize;
  final bool? staticSize;
  @override
  Widget build(BuildContext context) {
    return staticSize != null && staticSize!
        ? Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: alignment,
            style: TextStyle(
              color: inverted
                  ? context.theme.inverseTextColor
                  : context.theme.textColor,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
              fontSize: fontSize ?? 16,
            ),
          )
        : AutoSizeText(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            maxFontSize: fontSize ?? 16,
            textAlign: alignment,
            style: TextStyle(
              color: inverted
                  ? context.theme.inverseTextColor
                  : context.theme.textColor,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
              fontSize: fontSize ?? 16,
            ),
          );
  }
}
