import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_constants.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/app_text_field.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:Silink/features/company/data/models/company_public_page_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PublishScreen extends StatefulWidget {
  const PublishScreen({super.key});

  @override
  State<PublishScreen> createState() => _PublishScreenState();
}

class _PublishScreenState extends State<PublishScreen> {
  bool _published = false;
  bool _publishing = false;
  final _company = CompanyPublicPageData.sample;
  late final TextEditingController _slugCtrl = TextEditingController(
    text: _company.slug,
  );

  String get _pagePath =>
      '${AppConstants.companyPageHost}${_slugCtrl.text.trim()}';

  String get _link => 'https://$_pagePath';

  @override
  void dispose() {
    _slugCtrl.dispose();
    super.dispose();
  }

  Future<void> _publish() async {
    if (_slugCtrl.text.trim().isEmpty) return;
    setState(() => _publishing = true);
    await Future<void>.delayed(const Duration(milliseconds: 1300));
    if (!mounted) return;
    setState(() {
      _publishing = false;
      _published = true;
    });
  }

  void _copyLink() {
    Clipboard.setData(ClipboardData(text: _link));
    AppOverlay.showSuccess(LocaleKeys.publish_linkCopied.tr());
  }

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.companyBrand.themeColor;
    final companyInitial = _company.name.trim().isEmpty
        ? 'S'
        : _company.name.trim()[0].toUpperCase();
    final companySubtitle = [
      if (_company.industry?.trim().isNotEmpty == true)
        _company.industry!.trim(),
      if (_company.city?.trim().isNotEmpty == true) _company.city!.trim(),
    ].join(' · ');
    return Scaffold(
      backgroundColor: AppColors.backgroundColor.themeColor,
      body: Column(
        children: [
          ScreenHeaderBar(
            title: _published
                ? LocaleKeys.company_published_title.tr()
                : LocaleKeys.company_publish_title.tr(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_published) ...[
                    Container(
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: AppColors.cardColor.themeColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppColors.borderColor.themeColor,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40.w,
                                height: 40.w,
                                decoration: BoxDecoration(
                                  color: accent,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check_rounded,
                                  size: 22.sp,
                                  color: Colors.white,
                                ),
                              ),
                              12.width,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      LocaleKeys.company_page_published.tr(),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700,
                                      color: accent,
                                    ),
                                    2.height,
                                    AppText(
                                      LocaleKeys.company_page_available.tr(),
                                      fontSize: 12.sp,
                                      color: AppColors
                                          .textSecondaryColor.themeColor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          12.height,
                          Container(
                            padding: EdgeInsetsDirectional.only(
                              start: 12.w,
                              end: 6.w,
                              top: 6.h,
                              bottom: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.cardColor.themeColor,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.borderColor.themeColor,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: AppText(
                                    _pagePath,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        AppColors.textPrimaryColor.themeColor,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                CustomButton(
                                  onTap: _copyLink,
                                  title: LocaleKeys.company_copy.tr(),
                                  color: accent,
                                  width: 54,
                                  height: 34,
                                  radius: 10,
                                  fontSize: 11,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    16.height,
                  ],
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.cardColor.themeColor,
                      borderRadius: BorderRadius.circular(16.r),
                      border:
                          Border.all(color: AppColors.borderColor.themeColor),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        Container(
                          height: 48.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                accent.withValues(alpha: 0.7),
                                accent,
                              ],
                              begin: AlignmentDirectional.topStart,
                              end: AlignmentDirectional.bottomEnd,
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0, -24.h),
                          child: Column(
                            children: [
                              Container(
                                width: 48.w,
                                height: 48.w,
                                decoration: BoxDecoration(
                                  color: accent,
                                  borderRadius: BorderRadius.circular(14.r),
                                  border: Border.all(
                                    color: AppColors.cardColor.themeColor,
                                    width: 3,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: AppText(
                                  companyInitial,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(0, -6.h),
                                child: Column(
                                  children: [
                                    AppText(
                                      _company.name,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    2.height,
                                    AppText(
                                      companySubtitle,
                                      fontSize: 12.sp,
                                      color: AppColors
                                          .textSecondaryColor.themeColor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  16.height,
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: AppColors.cardColor.themeColor,
                      borderRadius: BorderRadius.circular(16.r),
                      border:
                          Border.all(color: AppColors.borderColor.themeColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          LocaleKeys.company_what_includes.tr(),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        10.height,
                        _bullet(LocaleKeys.company_includes_company.tr()),
                        _bullet(
                          LocaleKeys.company_includes_catalog.tr(args: ['2']),
                        ),
                        _bullet(
                          LocaleKeys.company_includes_team.tr(args: ['3']),
                        ),
                        _bullet(LocaleKeys.company_includes_contact.tr()),
                      ],
                    ),
                  ),
                  16.height,
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: AppColors.cardColor.themeColor,
                      borderRadius: BorderRadius.circular(16.r),
                      border:
                          Border.all(color: AppColors.borderColor.themeColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          LocaleKeys.company_page_link.tr(),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        10.height,
                        Container(
                          padding: EdgeInsetsDirectional.only(start: 12.w),
                          decoration: BoxDecoration(
                            color: AppColors.fieldFill,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.borderColor.themeColor,
                            ),
                          ),
                          child: Row(
                            children: [
                              AppText(
                                AppConstants.companyPageHost,
                                fontSize: 12.sp,
                                color: AppColors.textSecondaryColor.themeColor,
                              ),
                              Expanded(
                                child: CustomTextField(
                                  hint: _company.slug,
                                  controller: _slugCtrl,
                                  enabled: !_published,
                                  readOnly: _published,
                                  filled: false,
                                  bordered: false,
                                  borderRadius: 0,
                                  contentPadding: EdgeInsetsDirectional.only(
                                    start: 4.w,
                                    top: 14.h,
                                    bottom: 14.h,
                                  ),
                                  textStyle: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        AppColors.textPrimaryColor.themeColor,
                                  ),
                                  onChanged: (_) => setState(() {}),
                                ),
                              ),
                            ],
                          ),
                        ),
                        8.height,
                        AppText(
                          LocaleKeys.company_link_hint_public.tr(),
                          fontSize: 11.5.sp,
                          color: AppColors.textSecondaryColor.themeColor,
                        ),
                      ],
                    ),
                  ),
                  20.height,
                  if (_published) ...[
                    CustomButton(
                      onTap: () =>
                          NavigationService.push(Routes.companyPublicPage),
                      color: accent,
                      height: 48,
                      radius: 12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.visibility_rounded,
                            size: 17.sp,
                            color: Colors.white,
                          ),
                          8.width,
                          AppText(
                            LocaleKeys.company_view_public_page.tr(),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ] else
                    CustomButton(
                      onTap: _publish,
                      color: accent,
                      height: 48,
                      radius: 12,
                      loading: _publishing,
                      title: _publishing
                          ? LocaleKeys.company_publishing.tr()
                          : LocaleKeys.company_publish_page.tr(),
                      fontSize: 15,
                    ),
                  24.height,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.circle,
            size: 4.sp,
            color: AppColors.textSecondaryColor.themeColor,
          ),
          10.width,
          Expanded(
            child: AppText(
              text,
              fontSize: 12.5.sp,
              color: AppColors.textSecondaryColor.themeColor,
            ),
          ),
        ],
      ),
    );
  }
}
