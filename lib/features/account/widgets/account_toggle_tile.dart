import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';

class AccountToggleTile extends StatefulWidget {
  const AccountToggleTile({
    super.key,
    required this.title,
    this.subtitle,
    this.enabledSubtitle,
    this.disabledSubtitle,
    this.leading,
    this.initiallyEnabled = false,
    this.onChanged,
  });

  final String title;
  final String? subtitle;

  final String? enabledSubtitle;

  final String? disabledSubtitle;
  final Widget? leading;
  final bool initiallyEnabled;
  final ValueChanged<bool>? onChanged;

  @override
  State<AccountToggleTile> createState() => _AccountToggleTileState();
}

class _AccountToggleTileState extends State<AccountToggleTile> {
  late bool _enabled = widget.initiallyEnabled;

  @override
  Widget build(BuildContext context) {
    final subtitle = _enabled
        ? (widget.enabledSubtitle ?? widget.subtitle)
        : (widget.disabledSubtitle ?? widget.subtitle);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          if (widget.leading != null) ...[
            widget.leading!,
            12.width,
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  widget.title,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                if (subtitle != null) ...[
                  2.height,
                  AppText(
                    subtitle,
                    fontSize: 12.sp,
                    color: AppColors.textSecondaryColor.themeColor,
                  ),
                ],
              ],
            ),
          ),
          8.width,
          Transform.scale(
            scale: 0.85,
            child: Switch(
              value: _enabled,
              activeTrackColor: AppColors.mint.themeColor,
              thumbColor: WidgetStatePropertyAll(AppColors.white.themeColor),
              inactiveThumbColor: AppColors.white.themeColor,
              inactiveTrackColor: Color(0xFFcbd5e1),
              trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
              onChanged: (value) {
                setState(() => _enabled = value);
                widget.onChanged?.call(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
