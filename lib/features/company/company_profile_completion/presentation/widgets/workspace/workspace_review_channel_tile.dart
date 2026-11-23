import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/extensions/extensions.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/app_text.dart';
import '../../../../../card_studio/data/models/studio_platform.dart';
import '../../../../../card_studio/presentation/widgets/studio_platform_badge.dart';
import '../../../../../card_studio/presentation/widgets/studio_reveal.dart';

class WorkspaceReviewChannelTile extends StatelessWidget {
  const WorkspaceReviewChannelTile({
    super.key,
    required this.type,
    required this.label,
    required this.index,
  });

  final String type;
  final String label;
  final int index;

  @override
  Widget build(BuildContext context) {
    return StudioReveal(
      delay: Duration(milliseconds: 60 * index),
      offset: 10,
      child: SizedBox(
        width: 62.w,
        child: Column(
          children: [
            StudioPlatformBadge(platform: StudioPlatform.of(type), active: true),
            6.height,
            AppText(
              label,
              fontSize: 8.5.sp,
              fontWeight: FontWeight.w600,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              color: AppColors.textSecondaryColor.themeColor,
            ),
          ],
        ),
      ),
    );
  }
}
