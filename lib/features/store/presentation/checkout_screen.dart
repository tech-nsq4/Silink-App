import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/convert_helper.dart';
import '../../../core/utils/helper_methods.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../data/models/shipping_address.dart';
import '../logic/cart_cubit.dart';
import '../logic/checkout_cubit.dart';
import '../logic/store_cubit.dart';
import 'widgets/store_action_bar.dart';
import 'widgets/store_section_card.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _addressCtrl;
  late final TextEditingController _cityCtrl;
  late final TextEditingController _districtCtrl;
  late final TextEditingController _streetCtrl;
  late final TextEditingController _detailsCtrl;

  @override
  void initState() {
    super.initState();
    final address = context.read<CheckoutCubit>().state.address;
    _nameCtrl = TextEditingController(text: address.fullName);
    _phoneCtrl = TextEditingController(text: address.phone);
    _addressCtrl = TextEditingController(text: address.address);
    _cityCtrl = TextEditingController(text: address.city);
    _districtCtrl = TextEditingController(text: address.district);
    _streetCtrl = TextEditingController(text: address.street);
    _detailsCtrl = TextEditingController(text: address.details);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<StoreCubit>().loadProducts();
    });
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _cityCtrl.dispose();
    _districtCtrl.dispose();
    _streetCtrl.dispose();
    _detailsCtrl.dispose();
    super.dispose();
  }

  String? _requiredValidator(String? value) =>
      (value == null || value.trim().isEmpty)
          ? LocaleKeys.store_error_required.tr()
          : null;

  String? _phoneValidator(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return LocaleKeys.store_error_required.tr();
    final digits = trimmed.replaceAll(RegExp(r'[^0-9]'), '');
    return digits.length < 9 ? LocaleKeys.store_error_phone_invalid.tr() : null;
  }

  Future<void> _openLocation() async {
    final query = [
      _addressCtrl.text,
      _streetCtrl.text,
      _districtCtrl.text,
      _cityCtrl.text,
    ].where((value) => value.trim().isNotEmpty).join(' ');

    if (query.trim().isEmpty) {
      AppOverlay.showError(LocaleKeys.store_error_required.tr());
      return;
    }

    try {
      await HelperMethods.openLink(
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(query)}',
      );
    } catch (_) {
      AppOverlay.showError(LocaleKeys.common_somethingWentWrong.tr());
    }
  }

  void _continue() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.read<CheckoutCubit>().setAddress(
          ShippingAddress(
            fullName: _nameCtrl.text.trim(),
            phone: _phoneCtrl.text.trim(),
            address: _addressCtrl.text.trim(),
            city: _cityCtrl.text.trim(),
            district: _districtCtrl.text.trim(),
            street: _streetCtrl.text.trim(),
            details: _detailsCtrl.text.trim(),
          ),
        );

    NavigationService.push(Routes.paymentScreen);
  }

  @override
  Widget build(BuildContext context) {
    final currency = LocaleKeys.store_currency.tr();

    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(title: LocaleKeys.store_checkout_title.tr()),
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: 19.paddingHorizontal + 16.paddingVert,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    StoreSectionCard(
                      title: LocaleKeys.store_shipping_address.tr(),
                      child: Column(
                        children: [
                          CustomTextField(
                            hint: LocaleKeys.store_full_name.tr(),
                            controller: _nameCtrl,
                            validator: _requiredValidator,
                          ),
                          10.height,
                          CustomTextField(
                            hint: LocaleKeys.store_phone_number.tr(),
                            controller: _phoneCtrl,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9+\s]'),
                              ),
                            ],
                            validator: _phoneValidator,
                            prefixIcon: Icon(
                              Icons.phone_outlined,
                              size: 20.sp,
                              color: AppColors.textSecondaryColor.themeColor,
                            ),
                          ),
                          10.height,
                          CustomTextField(
                            hint: LocaleKeys.store_address.tr(),
                            controller: _addressCtrl,
                            validator: _requiredValidator,
                            suffixIcon: _locationButton(),
                          ),
                          10.height,
                          CustomTextField(
                            hint: LocaleKeys.store_city.tr(),
                            controller: _cityCtrl,
                            validator: _requiredValidator,
                          ),
                          10.height,
                          CustomTextField(
                            hint: LocaleKeys.store_district.tr(),
                            controller: _districtCtrl,
                          ),
                          10.height,
                          CustomTextField(
                            hint: LocaleKeys.store_street.tr(),
                            controller: _streetCtrl,
                          ),
                          10.height,
                          CustomTextField(
                            hint: LocaleKeys.store_extra_details.tr(),
                            controller: _detailsCtrl,
                            maxLines: 3,
                          ),
                          12.height,
                          Divider(
                            height: 1,
                            color: AppColors.borderColor.themeColor,
                          ),
                          6.height,
                          BlocBuilder<CheckoutCubit, CheckoutState>(
                            builder: (context, state) => Row(
                              children: [
                                Expanded(
                                  child: AppText(
                                    LocaleKeys.store_save_address.tr(),
                                    fontSize: 12.5.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Switch(
                                  value: state.saveAddress,
                                  onChanged: context
                                      .read<CheckoutCubit>()
                                      .setSaveAddress,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    12.height,
                    AppText(
                      LocaleKeys.store_delivery_note.tr(
                        namedArgs: {
                          'days': LocaleKeys.store_delivery_days.tr(),
                          'shipping':
                              '${ConvertHelper.formatPrice(AppConstants.defaultShippingCost)} $currency',
                          'free':
                              '${ConvertHelper.formatPrice(AppConstants.defaultFreeShippingThreshold)} $currency',
                        },
                      ),
                      fontSize: 11.sp,
                      color: AppColors.textSecondaryColor.themeColor,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) => StoreActionBar(
          title: '${LocaleKeys.store_continue_to_payment.tr()} · '
              '${ConvertHelper.formatPrice(state.total)} $currency',
          onTap: _continue,
        ),
      ),
    );
  }

  Widget _locationButton() {
    return Padding(
      padding: 8.paddingEnd,
      child: InkWell(
        onTap: _openLocation,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.mintSoft.themeColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.my_location_rounded,
                size: 14.sp,
                color: AppColors.mint.themeColor,
              ),
              4.width,
              AppText(
                LocaleKeys.store_location.tr(),
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.mint.themeColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
