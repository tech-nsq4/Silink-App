import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart' show AppText;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Top navigation bar + thin progress bar used on every onboarding step.
/// [step] is 1-based current step, [totalSteps] is the total (9 in this flow).
class StepHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int step;
  final int totalSteps;
  final VoidCallback? onClose;
  final VoidCallback? onBack;

  const StepHeader({
    super.key,
    required this.title,
    required this.step,
    required this.totalSteps,
    this.onClose,
    this.onBack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(78);

  @override
  Widget build(BuildContext context) {
    final progress = step / totalSteps;

    return SafeArea(
      bottom: false,
      child: Container(
        color: AppColors.white.themeColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: onBack ?? () => Navigator.of(context).maybePop(),
                    borderRadius: BorderRadius.circular(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.chevron_left,
                            size: 18, color: Color(0xFF8A8F98)),
                        AppText(
                          LocaleKeys.app_bar_back.tr(),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondaryColor.themeColor,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        AppText(
                          title,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondaryColor.themeColor,
                        ),
                        const SizedBox(height: 2),
                        AppText(
                          LocaleKeys.app_bar_step.tr(
                            namedArgs: {
                              'step': step.toString(),
                              'totalSteps': totalSteps.toString(),
                            },
                          ),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimaryColor.themeColor,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: onClose ?? () => Navigator.of(context).maybePop(),
                    borderRadius: BorderRadius.circular(20),
                    child:  Padding(
                      padding: EdgeInsets.all(6),
                      child:
                          Icon(Icons.close, size: 20.r, color: AppColors.textSecondaryColor.themeColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 4,
                  backgroundColor: const Color(0xFFf1f5f9),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Color(0xFF2F6FED)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}