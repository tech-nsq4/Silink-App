import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/di/injection.dart';
import 'package:Silink/core/services/deep_link_service.dart';
import 'package:Silink/core/storage/local_storage.dart';
import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/app_constants.dart';
import 'package:Silink/core/utils/app_overlay.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/custom_loading_widget.dart';
import 'package:Silink/features/employee_invitation/data/models/invitation_details_model.dart';
import 'package:Silink/features/employee_invitation/logic/employee_invitation_cubit.dart';
import 'package:Silink/features/employee_invitation/presentation/widgets/invitation_accept_sheet.dart';
import 'package:Silink/features/employee_invitation/presentation/widgets/invitation_company_card.dart';
import 'package:Silink/features/employee_invitation/presentation/widgets/invitation_employee_card.dart';
import 'package:Silink/features/employee_invitation/presentation/widgets/invitation_error_view.dart';
import 'package:Silink/features/employee_invitation/presentation/widgets/invitation_hero.dart';
import 'package:Silink/features/employee_invitation/presentation/widgets/invitation_reveal.dart';
import 'package:Silink/features/employee_invitation/presentation/widgets/invitation_status_banner.dart';
import 'package:Silink/features/profile/logic/profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeInvitationScreen extends StatefulWidget {
  const EmployeeInvitationScreen({super.key, required this.inviteToken});

  final String inviteToken;

  @override
  State<EmployeeInvitationScreen> createState() =>
      _EmployeeInvitationScreenState();
}

class _EmployeeInvitationScreenState extends State<EmployeeInvitationScreen> {
  late final EmployeeInvitationCubit _cubit = getIt<EmployeeInvitationCubit>()
    ..load(widget.inviteToken);

  @override
  void dispose() {
    DeepLinkService.clearHandled();
    _cubit.close();
    super.dispose();
  }

  InvitationDetailsModel? _detailsOf(EmployeeInvitationState state) =>
      switch (state) {
        EmployeeInvitationLoaded(:final details) => details,
        EmployeeInvitationSubmitting(:final details) => details,
        _ => null,
      };

  Future<void> _onState(
    BuildContext context,
    EmployeeInvitationState state,
  ) async {
    if (state is! EmployeeInvitationAccepted) return;
    AppOverlay.showSuccess(LocaleKeys.invitation_welcome.tr());
    await context.read<ProfileCubit>().getProfile();
    if (!context.mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(kHomeRoute, (_) => false);
  }

  void _cancel() {
    final route =
        getIt<LocalStorage>().isLoggedIn ? kHomeRoute : Routes.onBoardingScreen;
    Navigator.of(context).pushNamedAndRemoveUntil(route, (_) => false);
  }

  Future<void> _backToLogin() async {
    await getIt<LocalStorage>().clearAll();
    kUserModel = null;
    if (!mounted) return;
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.loginScreen, (_) => false);
  }

  void _openSheet(InvitationDetailsModel details) {
    InvitationAcceptSheet.show(
      context,
      cubit: _cubit,
      employee: details.employee,
    );
  }

  Widget _content(InvitationDetailsModel details) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 24.h),
      child: Column(
        children: [
          InvitationReveal(
            delayMs: 100,
            child: InvitationStatusBanner(details: details),
          ),
          14.height,
          InvitationReveal(
            delayMs: 220,
            child: InvitationCompanyCard(company: details.company),
          ),
          14.height,
          InvitationReveal(
            delayMs: 340,
            child: InvitationEmployeeCard(employee: details.employee),
          ),
        ],
      ),
    );
  }

  Widget _body(EmployeeInvitationState state) {
    final details = _detailsOf(state);
    if (details != null) return _content(details);
    if (state is EmployeeInvitationError) {
      return InvitationErrorView(
        message: state.message,
        onRetry: _cubit.retry,
        onBack: _backToLogin,
      );
    }
    return Center(
      child: CustomLoadingWidget(
        color: AppColors.primaryColor.themeColor,
        size: 40,
      ),
    );
  }

  Widget _bottomBar(InvitationDetailsModel details) {
    return InvitationReveal(
      delayMs: 460,
      child: Container(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
        decoration: BoxDecoration(
          color: AppColors.white.themeColor,
          border: Border(
            top: BorderSide(color: AppColors.borderColor.themeColor),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: CustomButton(
                  onTap: _cancel,
                  title: LocaleKeys.invitation_cancel.tr(),
                  isOutlined: true,
                  color: Colors.transparent,
                  borderColor: AppColors.borderColor.themeColor,
                  textColor: AppColors.textPrimaryColor.themeColor,
                  height: 52,
                  radius: 16,
                ),
              ),
              12.width,
              Expanded(
                flex: 3,
                child: CustomButton(
                  onTap: () => _openSheet(details),
                  title: LocaleKeys.invitation_accept.tr(),
                  height: 52,
                  radius: 16,
                  color: AppColors.primaryColor.themeColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeInvitationCubit, EmployeeInvitationState>(
      bloc: _cubit,
      listener: _onState,
      builder: (context, state) {
        final details = _detailsOf(state);
        return Scaffold(
          backgroundColor: AppColors.backgroundColor.themeColor,
          body: Column(
            children: [
              InvitationHero(
                companyName: details?.company.name,
                logoUrl: details?.company.logoUrl,
              ),
              Expanded(child: _body(state)),
              if (details != null && details.isPending) _bottomBar(details),
            ],
          ),
        );
      },
    );
  }
}
