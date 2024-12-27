// dart packages
import 'package:flutter/material.dart';

// defines custom colors for the app
abstract class CustomColors {
  // universal accent
  static const Color accent = Color(0xffb6a9f1);

  // coloring colors:
  static const List<Color> heatmapColors = [
    Color(0xffc7bdf2),
    Color(0xffbfb3f2),
    Color(0xffb6a9f1),
    Color(0xffa89be0),
    Color(0xff9d8ede),
  ];

  // dark mode
  static const Color darkBackground = Color(0xff10141a);
  static const Color darkSurface = Color(0xff151b24);
  static const Color darkPrimary = Color(0xff1d2530);
  static const Color darkTextColor = Color(0xffe1e6f0);
  static const Color darkSubtextColor = Color(0xff969eb0);
  static const Color darkHintTextColor = Color(0xff666e7d);
  static const Color inverseDarkTextColor = Color(0xff151b24);

  // light mode
  static const Color lightBackground = Color(0xffffffff);
  static const Color lightSurface = Color(0xfff3f5f6);
  static const Color lightPrimary = Color(0xffe5e8ea);
  static const Color lightTextColor = Color(0xff1a1a1a);
  static const Color lightSubtextColor = Color(0xff7e8286);
  static const Color lightHintTextColor = Color(0xff8f8f8f);
  static const Color inverseLightTextColor = Color(0xff151b24);
}
