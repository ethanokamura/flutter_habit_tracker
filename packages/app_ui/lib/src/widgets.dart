import 'package:app_ui/src/constants.dart';
import 'package:app_ui/src/theme.dart';
import 'package:app_ui/src/extensions.dart';
import 'package:app_ui/src/text.dart';
import 'package:flutter/material.dart';

/// Custom container widget
/// Requires [child] widget to display inside the container
/// Optional padding using [horizontal] and [vertical]
class DefaultContainer extends StatelessWidget {
  const DefaultContainer({
    required this.child,
    this.accent,
    this.horizontal,
    this.vertical,
    super.key,
  });

  final bool? accent;
  final double? horizontal;
  final double? vertical;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: accent == null || !accent!
          ? context.theme.colorScheme.surface
          : context.theme.accentColor,
      borderRadius: defaultBorderRadius,
      elevation: defaultElevation,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal == null ? 15 : horizontal!,
          vertical: vertical == null ? 10 : vertical!,
        ),
        child: child,
      ),
    );
  }
}

/// Custom container widget
/// Requires [body] content to display inside the page
class CustomPageView extends StatelessWidget {
  const CustomPageView({
    required this.body,
    this.title,
    this.actions,
    this.centerTitle,
    this.floatingActionButton,
    super.key,
  });
  final Widget body;
  final String? title;
  final bool? centerTitle;
  final List<Widget>? actions;
  final FloatingActionButton? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final appBar = title != null || actions != null || centerTitle != null;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar
          ? AppBar(
              centerTitle: centerTitle,
              backgroundColor: Colors.transparent,
              title: title != null ? AppBarText(text: title!) : null,
              actions: actions,
            )
          : null,
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: defaultPadding,
            right: defaultPadding,
            top: appBar ? defaultPadding : 0,
          ),
          child: body,
        ),
      ),
    );
  }
}

/// Customer vertical spacer with default spacing
class VerticalSpacer extends StatelessWidget {
  const VerticalSpacer({this.multiple, super.key});
  final double? multiple;
  @override
  Widget build(BuildContext context) {
    return multiple != null
        ? SizedBox(height: defaultSpacing * multiple!)
        : const SizedBox(height: defaultSpacing);
  }
}

/// Customer horizontal spacer with default spacing
class HorizontalSpacer extends StatelessWidget {
  const HorizontalSpacer({this.multiple, super.key});
  final double? multiple;

  @override
  Widget build(BuildContext context) {
    return multiple != null
        ? SizedBox(width: defaultSpacing * multiple!)
        : const SizedBox(width: defaultSpacing);
  }
}
