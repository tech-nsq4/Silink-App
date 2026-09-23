import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/clients/models/client_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// شارة حالة العميل — بدون [onTap] تُعرض كشارة ثابتة (بدون سهم)،
/// ومع [onTap] تصبح قابلة للنقر لفتح شيت تغيير الحالة.
class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status, this.onTap});

  final ClientStatus status;
  final VoidCallback? onTap;

  ({Color bg, Color text}) get _style {
    switch (status) {
      case ClientStatus.newClient:
        return (bg: const Color(0xFFE8F0FE), text: const Color(0xFF2F6FED));
      case ClientStatus.contacted:
        return (bg: const Color(0xFFFFF7E0), text: const Color(0xFFB8860B));
      case ClientStatus.qualified:
      case ClientStatus.converted:
        return (bg: const Color(0xFFEFFAF3), text: const Color(0xFF17B78F));
      case ClientStatus.important:
        return (
          bg: AppColors.mintSoft.themeColor,
          text: AppColors.mint.themeColor,
        );
      case ClientStatus.lost:
      case ClientStatus.notImportant:
      case ClientStatus.all:
        return (
          bg: AppColors.fieldFill,
          text: AppColors.textSecondaryColor.themeColor,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = _style;
    final pill = Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: style.bg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: AppText(
              status.statusLabel,
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: style.text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (onTap != null) ...[
            4.width,
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 14.sp,
              color: style.text,
            ),
          ],
        ],
      ),
    );

    if (onTap == null) return pill;
    return GestureDetector(onTap: onTap, child: pill);
  }
}
