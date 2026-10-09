import 'package:flutter/widgets.dart';

class AppFontScope extends InheritedWidget {
  const AppFontScope({
    super.key,
    required this.fontFamily,
    required super.child,
  });

  final String? fontFamily;

  static String? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppFontScope>()?.fontFamily;

  @override
  bool updateShouldNotify(AppFontScope oldWidget) =>
      oldWidget.fontFamily != fontFamily;
}
