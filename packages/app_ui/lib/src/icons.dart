import 'package:app_ui/src/extensions.dart';
import 'package:app_ui/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Icon defaultIconStyle(BuildContext context, IconData icon, {double size = 14}) {
  return Icon(
    icon,
    color: context.theme.textColor,
    size: size,
  );
}

Icon appBarIconStyle(BuildContext context, IconData icon, {double size = 18}) {
  return Icon(
    icon,
    color: context.theme.textColor,
    size: size,
  );
}

Icon accentIconStyle(BuildContext context, IconData icon, {double size = 14}) {
  return Icon(
    icon,
    color: context.theme.accentColor,
    size: size,
  );
}

Icon inverseIconStyle(BuildContext context, IconData icon, {double size = 14}) {
  return Icon(
    icon,
    color: context.theme.inverseTextColor,
    size: size,
  );
}

Icon surfaceIconStyle(BuildContext context, IconData icon, {double size = 14}) {
  return Icon(
    icon,
    color: context.theme.textColor,
    size: size,
  );
}

Icon selectionIconStyle(
  BuildContext context,
  IconData icon, {
  double size = 40,
}) {
  return Icon(
    icon,
    color: context.theme.surfaceColor,
    size: size,
  );
}

class AppIcons {
  // buttons
  static const IconData settings = FontAwesomeIcons.gear;
  static const IconData share = FontAwesomeIcons.share;
  static const IconData cancel = FontAwesomeIcons.xmark;
  static const IconData more = FontAwesomeIcons.ellipsis;
  static const IconData delete = FontAwesomeIcons.trash;
  static const IconData edit = FontAwesomeIcons.pencil;
  static const IconData next = FontAwesomeIcons.arrowRight;
  static const IconData back = FontAwesomeIcons.arrowLeft;
  static const IconData images = FontAwesomeIcons.images;
  static const IconData camera = FontAwesomeIcons.camera;

  // toggles
  static const IconData checked = FontAwesomeIcons.solidSquareCheck;
  static const IconData notChecked = FontAwesomeIcons.square;
  static const IconData lightMode = FontAwesomeIcons.sun;
  static const IconData darkMode = FontAwesomeIcons.moon;

  // misc
  static const IconData boards = FontAwesomeIcons.list;

  // pages
  static const IconData home = FontAwesomeIcons.house;
  static const IconData search = FontAwesomeIcons.magnifyingGlass;
  static const IconData create = FontAwesomeIcons.plus;
  static const IconData inbox = FontAwesomeIcons.inbox;
  static const IconData user = FontAwesomeIcons.solidUser;
  static const IconData month = FontAwesomeIcons.solidCalendarDays;
}
