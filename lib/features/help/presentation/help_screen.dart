import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/di/injection.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../../account/widgets/account_menu_tile.dart';
import '../../account/widgets/account_section_card.dart';
import '../../faq/logic/faq_cubit.dart';
import '../../faq/widgets/faq_section.dart';
import '../data/models/contact_message.dart';
import '../logic/contact_cubit.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  /// App version shown at the bottom of the screen (mirrors pubspec.yaml).
  static const String appVersion = '1.0.0';

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  static final RegExp _emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

  late final TextEditingController _subjectController;
  late final TextEditingController _messageController;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final FaqCubit _faqCubit = getIt<FaqCubit>()..getFaqs();
  late final ContactCubit _contactCubit = getIt<ContactCubit>();

  late final bool _askName = (kUserModel?.fullName.trim() ?? '').isEmpty;
  late final bool _askEmail = (kUserModel?.email?.trim() ?? '').isEmpty;

  @override
  void initState() {
    super.initState();
    _subjectController = TextEditingController()..addListener(_rebuild);
    _messageController = TextEditingController()..addListener(_rebuild);
    _nameController = TextEditingController()..addListener(_rebuild);
    _emailController = TextEditingController()..addListener(_rebuild);
  }

  void _rebuild() => setState(() {});

  String get _name =>
      _askName ? _nameController.text.trim() : kUserModel!.fullName.trim();

  String get _email =>
      _askEmail ? _emailController.text.trim() : kUserModel!.email!.trim();

  bool get _canSend =>
      _subjectController.text.trim().isNotEmpty &&
      _messageController.text.trim().isNotEmpty &&
      _name.isNotEmpty &&
      _email.isNotEmpty;

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _faqCubit.close();
    _contactCubit.close();
    super.dispose();
  }

  void _send() {
    FocusScope.of(context).unfocus();
    if (!_emailPattern.hasMatch(_email)) {
      AppOverlay.showError(LocaleKeys.help_emailInvalid.tr());
      return;
    }
    _contactCubit.send(ContactMessage(
      name: _name,
      email: _email,
      phone: kUserModel?.phone ?? '',
      subject: _subjectController.text,
      message: _messageController.text,
    ));
  }

  void _onContactState(BuildContext context, ContactState state) {
    if (state is! ContactSent) return;
    _subjectController.clear();
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(title: LocaleKeys.help_title.tr()),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _faqCubit.refresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FaqSection(cubit: _faqCubit),
                    // ── Contact form ───────────────────────────────────
                    AppText(
                      LocaleKeys.help_contactSection.tr(),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondaryColor.themeColor,
                    ),
                    10.height,
                    AccountSectionCard(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      children: [
                        Column(
                          children: [
                            if (_askName) ...[
                              CustomTextField(
                                controller: _nameController,
                                hint: LocaleKeys.help_nameHint.tr(),
                              ),
                              12.height,
                            ],
                            if (_askEmail) ...[
                              CustomTextField(
                                controller: _emailController,
                                hint: LocaleKeys.help_emailHint.tr(),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              12.height,
                            ],
                            CustomTextField(
                              controller: _subjectController,
                              hint: LocaleKeys.help_subjectHint.tr(),
                            ),
                            12.height,
                            CustomTextField(
                              controller: _messageController,
                              hint: LocaleKeys.help_messageHint.tr(),
                              maxLines: 5,
                            ),
                            14.height,
                            BlocConsumer<ContactCubit, ContactState>(
                              bloc: _contactCubit,
                              listener: _onContactState,
                              builder: (context, state) => CustomButton(
                                onTap: _canSend ? _send : () {},
                                loading: state is ContactSending,
                                title: LocaleKeys.help_send.tr(),
                                color: _canSend
                                    ? null
                                    : AppColors.studioStepLine.themeColor,
                                textColor: _canSend
                                    ? null
                                    : AppColors.white.themeColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    18.height,
                    // // ── Quick links ────────────────────────────────────
                    // AccountSectionCard(
                    //   children: [
                    //     AccountMenuTile(
                    //       icon: AppImages.iconsCard,
                    //       label: LocaleKeys.help_nfcGuide.tr(),
                    //       onTap: _showComingSoon,
                    //     ),
                    //     AccountMenuTile(
                    //       icon: AppImages.iconsInfo,
                    //       label: LocaleKeys.help_reportProblem.tr(),
                    //       onTap: _showComingSoon,
                    //     ),
                    //     AccountMenuTile(
                    //       icon: AppImages.iconsDoc,
                    //       label: LocaleKeys.help_termsOfUse.tr(),
                    //       onTap: _showComingSoon,
                    //     ),
                    //     AccountMenuTile(
                    //       icon: AppImages.iconsPrivacy,
                    //       label: LocaleKeys.help_privacyPolicy.tr(),
                    //       onTap: _showComingSoon,
                    //     ),
                    //   ],
                    // ),
                    24.height,
                    AppText(
                      '${LocaleKeys.help_version.tr()} ${HelpScreen.appVersion}',
                      fontSize: 12,
                      color: AppColors.textSecondaryColor.themeColor,
                      textAlign: TextAlign.center,
                    ),
                    24.height,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
