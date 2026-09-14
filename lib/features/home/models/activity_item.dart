import 'package:flutter/material.dart';

/// Data for a single row in [RecentActivitySection].
class ActivityItem {
  final String icon;
  final Color iconColor;
  final Color iconBackground;

  /// LocaleKeys entry for the title, expects a `{name}` named arg.
  final String titleKey;
  final String subjectName;
  final int hoursAgo;

  const ActivityItem({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.titleKey,
    required this.subjectName,
    required this.hoursAgo,
  });
}
