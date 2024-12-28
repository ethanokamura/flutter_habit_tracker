import 'package:app_ui/app_ui.dart';

/// Default button for the UI
/// Requires [onTap] function to handle the tap event
/// Optionally takes an [icon] and [text] for UI
/// Optional padding using [horizontal] and [vertical]
class DefaultButton extends StatelessWidget {
  const DefaultButton({
    required this.onTap,
    this.onSurface = false,
    this.icon,
    this.text,
    this.vertical,
    this.horizontal,
    super.key,
  });

  final bool onSurface;
  final IconData? icon;
  final String? text;
  final double? vertical;
  final double? horizontal;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: defaultStyle(context, onSurface: onSurface),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal ?? 0,
          vertical: vertical ?? 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) defaultIconStyle(context, icon!),
            if (text != null && icon != null) const SizedBox(width: 10),
            if (text != null)
              ButtonText(
                text: text!,
                inverted: false,
                staticSize: true,
              ),
          ],
        ),
      ),
    );
  }
}

/// Action button for the UI
/// Accent colored background
/// Requires [onTap] function to handle the tap event
/// Optionally takes an [icon] and [text] for UI
/// Optional padding using [horizontal] and [vertical]
class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.onTap,
    this.icon,
    this.text,
    this.vertical,
    this.horizontal,
    super.key,
  });

  final IconData? icon;
  final String? text;
  final double? vertical;
  final double? horizontal;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: accentStyle(context),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal ?? 0,
          vertical: vertical ?? 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) inverseIconStyle(context, icon!),
            if (text != null && icon != null) const SizedBox(width: 10),
            if (text != null)
              ButtonText(
                text: text!,
                inverted: onTap != null,
                staticSize: true,
              ),
          ],
        ),
      ),
    );
  }
}

/// Check box for board selection
/// Requires [isSelected] to display different icons
class CheckBox extends StatelessWidget {
  const CheckBox({
    required this.isSelected,
    super.key,
  });
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? accentIconStyle(context, AppIcons.checked, size: 22)
        : defaultIconStyle(context, AppIcons.notChecked, size: 22);
  }
}

/// Button for bottom modals
/// Requires [onTap] function to handle the tap event
/// Requires an [icon] and [label] for UI
class BottomModalButton extends StatelessWidget {
  const BottomModalButton({
    required this.icon,
    required this.label,
    required this.onTap,
    super.key,
  });
  final IconData icon;
  final String label;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onTap,
          style: defaultStyle(context, onSurface: true),
          icon: defaultIconStyle(context, icon, size: 30),
        ),
        const VerticalSpacer(),
        PrimaryText(text: label),
      ],
    );
  }
}

/// Icon button for the app bar
/// Requires [onTap] function to handle the tap event
/// Requires an [icon] for UI
class AppBarButton extends StatelessWidget {
  const AppBarButton({
    required this.icon,
    required this.onTap,
    super.key,
  });
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: appBarIconStyle(context, icon),
    );
  }
}

/// Default button for the UI
/// Requires [onTap] function to handle the tap event
/// Optionally takes an [icon] and [text] for UI
/// Optional padding using [horizontal] and [vertical]
class ThemeButton extends StatelessWidget {
  const ThemeButton({
    required this.onTap,
    this.icon,
    this.text,
    this.vertical,
    this.horizontal,
    super.key,
  });

  final IconData? icon;
  final String? text;
  final double? vertical;
  final double? horizontal;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (text != null)
              ButtonText(
                text: text!,
                inverted: false,
                staticSize: true,
              ),
            if (text != null && icon != null) const HorizontalSpacer(),
            if (icon != null) defaultIconStyle(context, icon!),
          ],
        ),
      ),
    );
  }
}

/// Default button for the UI
/// Requires [onTap] function to handle the tap event
/// Optionally takes an [icon] and [text] for UI
/// Optional padding using [horizontal] and [vertical]
class HabitTileButton extends StatelessWidget {
  const HabitTileButton({
    required this.onTap,
    required this.completed,
    this.icon,
    this.text,
    this.vertical,
    this.horizontal,
    super.key,
  });

  final bool completed;
  final IconData? icon;
  final String? text;
  final double? vertical;
  final double? horizontal;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: completed ? accentStyle(context) : defaultStyle(context),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal ?? 10,
          vertical: vertical ?? 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (icon != null)
              completed
                  ? inverseIconStyle(context, icon!, size: 18)
                  : defaultIconStyle(context, icon!, size: 18),
            if (text != null && icon != null) const SizedBox(width: 10),
            if (text != null)
              HabitText(
                text: text!,
                completed: completed,
                staticSize: true,
              ),
          ],
        ),
      ),
    );
  }
}
