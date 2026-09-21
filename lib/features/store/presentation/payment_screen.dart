import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../models/demo_store_data.dart';
import '../models/payment_method.dart';
import '../widgets/order_summary_card.dart';
import '../widgets/payment_method_tile.dart';
import '../widgets/store_action_bar.dart';
import '../widgets/store_section_card.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardCtrl = TextEditingController();
  final _expiryCtrl = TextEditingController();
  final _cvvCtrl = TextEditingController();
  PaymentMethod _selectedMethod = PaymentMethod.creditCard;

  @override
  void dispose() {
    _cardCtrl.dispose();
    _expiryCtrl.dispose();
    _cvvCtrl.dispose();
    super.dispose();
  }

  String? _cardNumberValidator(String? value) {
    final digits = (value ?? '').replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return LocaleKeys.store_error_required.tr();
    return digits.length < 16 ? LocaleKeys.store_error_card_invalid.tr() : null;
  }

  String? _expiryValidator(String? value) {
    final digits = (value ?? '').replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return LocaleKeys.store_error_required.tr();
    if (digits.length < 4) return LocaleKeys.store_error_expiry_invalid.tr();
    final month = int.tryParse(digits.substring(0, 2)) ?? 0;
    return month < 1 || month > 12
        ? LocaleKeys.store_error_expiry_invalid.tr()
        : null;
  }

  String? _cvvValidator(String? value) {
    final digits = (value ?? '').replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return LocaleKeys.store_error_required.tr();
    return digits.length < 3 ? LocaleKeys.store_error_cvv_invalid.tr() : null;
  }

  Future<void> _confirm() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    NavigationService.pushReplacement(Routes.orderSuccessScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(title: LocaleKeys.store_payment_title.tr()),
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: 19.paddingHorizontal + 16.paddingVert,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OrderSummaryCard(
                      subtotal: DemoStoreData.subtotal,
                      shipping: DemoStoreData.shipping,
                      total: DemoStoreData.total,
                    ),
                    12.height,
                    Builder(
                      builder: (context) {
                        final isCard =
                            _selectedMethod == PaymentMethod.creditCard;

                        return StoreSectionCard(
                          title: LocaleKeys.store_payment_method.tr(),
                          child: Column(
                            children: [
                              PaymentMethodTile(
                                method: PaymentMethod.creditCard,
                                icon: Icons.credit_card_rounded,
                                isSelected: isCard,
                                onTap: () => setState(
                                  () => _selectedMethod =
                                      PaymentMethod.creditCard,
                                ),
                              ),
                              8.height,
                              PaymentMethodTile(
                                method: PaymentMethod.cashOnDelivery,
                                icon: Icons.payments_outlined,
                                isSelected: !isCard,
                                onTap: () => setState(
                                  () => _selectedMethod =
                                      PaymentMethod.cashOnDelivery,
                                ),
                              ),
                              if (isCard) ...[
                                16.height,
                                CustomTextField(
                                  hint: LocaleKeys.store_card_number.tr(),
                                  controller: _cardCtrl,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(16),
                                  ],
                                  validator: _cardNumberValidator,
                                  prefixIcon: Icon(
                                    Icons.credit_card,
                                    size: 20.sp,
                                    color:
                                        AppColors.textSecondaryColor.themeColor,
                                  ),
                                ),
                                10.height,
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        hint: LocaleKeys.store_expiry_date.tr(),
                                        controller: _expiryCtrl,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(4),
                                        ],
                                        validator: _expiryValidator,
                                      ),
                                    ),
                                    10.width,
                                    Expanded(
                                      child: CustomTextField(
                                        hint: LocaleKeys.store_cvv.tr(),
                                        controller: _cvvCtrl,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(4),
                                        ],
                                        validator: _cvvValidator,
                                      ),
                                    ),
                                  ],
                                ),
                                12.height,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.lock_outline_rounded,
                                      size: 14.sp,
                                      color: AppColors.mint.themeColor,
                                    ),
                                    6.width,
                                    Flexible(
                                      child: AppText(
                                        LocaleKeys.store_secure_payment_note
                                            .tr(),
                                        fontSize: 10.5.sp,
                                        color: AppColors
                                            .textSecondaryColor.themeColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: StoreActionBar(
        title: LocaleKeys.store_confirm_order.tr(),
        onTap: _confirm,
      ),
    );
  }
}
