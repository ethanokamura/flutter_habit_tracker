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

Icon appBarIconStyle(BuildContext context, IconData icon, {double size = 24}) {
  return Icon(
    icon,
    color: context.theme.textColor,
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

class AppIcons {
  // buttons
  static const IconData delete = FontAwesomeIcons.trash;
  static const IconData edit = FontAwesomeIcons.pencil;
  static const IconData logOut = FontAwesomeIcons.arrowRightFromBracket;
  static const IconData settings = FontAwesomeIcons.ellipsis;

  // toggles
  static const IconData checked = FontAwesomeIcons.solidSquareCheck;
  static const IconData notChecked = FontAwesomeIcons.square;
  static const IconData lightMode = FontAwesomeIcons.sun;
  static const IconData darkMode = FontAwesomeIcons.moon;

  // pages
  static const IconData create = FontAwesomeIcons.plus;
}
