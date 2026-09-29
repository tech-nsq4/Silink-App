import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../widgets/create_new_card_button.dart';

class MyFilesEmptyView extends StatelessWidget {
  const MyFilesEmptyView({super.key, required this.onCreate});

  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: 24.paddingHorizontal,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: AppColors.mint.themeColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.folder_open_rounded,
                size: 34.sp,
                color: AppColors.mint.themeColor,
              ),
            ),
            16.height,
            AppText(
              LocaleKeys.myFiles_emptyTitle.tr(),
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),
            6.height,
            AppText(
              LocaleKeys.myFiles_emptyDesc.tr(),
              fontSize: 13.sp,
              color: AppColors.textSecondaryColor.themeColor,
              textAlign: TextAlign.center,
            ),
            20.height,
            CreateNewCardButton(onTap: onCreate),
          ],
        ),
      ),
    );
  }
}
