import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/router/routes.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/storage/local_storage.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text.dart';
import 'settings_language_option.dart';

class SettingsLanguageSheet extends StatefulWidget {
  const SettingsLanguageSheet({super.key, required this.parentContext});

  final BuildContext parentContext;

  static Future<void> show(BuildContext context) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => SettingsLanguageSheet(parentContext: context),
      );

  @override
  State<SettingsLanguageSheet> createState() => _SettingsLanguageSheetState();
}

class _SettingsLanguageSheetState extends State<SettingsLanguageSheet> {
  late String _selected = widget.parentContext.locale.languageCode;

  Future<void> _confirm() async {
    Navigator.pop(context);
    final parent = widget.parentContext;
    if (_selected == parent.locale.languageCode) return;
    await getIt<LocalStorage>().setLang(_selected);
    if (!parent.mounted) return;
    await parent.setLocale(Locale(_selected));
    if (!parent.mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      parent,
      Routes.splashScreen,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 32.h),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.borderColor.themeColor,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
            16.height,
            AppText(
              LocaleKeys.settings_languageTitle.tr(),
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),
            4.height,
            AppText(
              LocaleKeys.settings_changeLanguageSubtitle.tr(),
              fontSize: 12.sp,
              color: AppColors.textSecondaryColor.themeColor,
              textAlign: TextAlign.center,
            ),
            20.height,
            SettingsLanguageOption(
              code: 'ar',
              label: LocaleKeys.settings_arabic.tr(),
              isSelected: _selected == 'ar',
              onTap: () => setState(() => _selected = 'ar'),
            ),
            12.height,
            SettingsLanguageOption(
              code: 'en',
              label: LocaleKeys.settings_english.tr(),
              isSelected: _selected == 'en',
              onTap: () => setState(() => _selected = 'en'),
            ),
            24.height,
            CustomButton(
              onTap: _confirm,
              title: LocaleKeys.common_confirm.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
