import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../logic/checkout_cubit.dart';
import 'widgets/order_success_card.dart';
import 'widgets/order_summary_card.dart';
import 'widgets/store_action_bar.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  void _copyNumber(String number) {
    Clipboard.setData(ClipboardData(text: number));
    AppOverlay.showSuccess(LocaleKeys.store_order_copied.tr());
  }

  void _continueShopping() =>
      NavigationService.pushNamedAndRemoveUntil(Routes.storeScreen);

  void _backToHome() =>
      NavigationService.pushNamedAndRemoveUntil(Routes.layoutScreen);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        final order = state.order;

        return Scaffold(
          body: Column(
            children: [
              ScreenHeaderBar(title: LocaleKeys.store_order_confirmed.tr()),
              Expanded(
                child: order == null
                    ? const SizedBox.shrink()
                    : SingleChildScrollView(
                        padding: 19.paddingHorizontal + 16.paddingVert,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Container(
                                width: 72.w,
                                height: 72.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.mintSoft.themeColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check_rounded,
                                  size: 36.sp,
                                  color: AppColors.mint.themeColor,
                                ),
                              ),
                            ),
                            12.height,
                            AppText(
                              LocaleKeys.store_order_confirmed.tr(),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              textAlign: TextAlign.center,
                            ),
                            6.height,
                            AppText(
                              LocaleKeys.store_order_confirmed_hint.tr(),
                              fontSize: 12.5.sp,
                              color: AppColors.textSecondaryColor.themeColor,
                              textAlign: TextAlign.center,
                            ),
                            16.height,
                            OrderSuccessCard(
                              order: order,
                              onCopyNumber: () => _copyNumber(order.number),
                            ),
                            12.height,
                            OrderSummaryCard(
                              subtotal: order.subtotal,
                              shipping: order.shipping,
                              total: order.total,
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
          bottomNavigationBar: StoreActionBar(
            title: LocaleKeys.store_continue_shopping.tr(),
            onTap: _continueShopping,
            secondaryTitle: LocaleKeys.store_back_to_home.tr(),
            onSecondaryTap: _backToHome,
          ),
        );
      },
    );
  }
}
