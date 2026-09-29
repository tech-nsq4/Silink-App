import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/di/injection.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/convert_helper.dart';
import '../../../core/utils/custom_text_field_phone/custom_text_field_phone_code.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/bottom_action_bar.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../../cart/logic/cart_cubit.dart';
import '../data/models/city_model.dart';
import '../data/models/shipping_address.dart';
import '../logic/cities_cubit.dart';
import 'widgets/checkout_order_brief_card.dart';
import 'widgets/delivery_address_form.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _districtCtrl = TextEditingController();
  final _streetCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  late final CitiesCubit _citiesCubit = getIt<CitiesCubit>()..getCities();
  String _phoneCountryCode = '+966';
  CityModel? _selectedCity;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _citiesCubit.close();
    _districtCtrl.dispose();
    _streetCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  String? _requiredValidator(String? value) =>
      (value == null || value.trim().isEmpty)
          ? LocaleKeys.store_error_required.tr()
          : null;

  void _onPhoneChanged(PhoneNumber phone) =>
      _phoneCountryCode = phone.countryCode;

  String get _fullPhoneNumber {
    final number = _phoneCtrl.text
        .replaceAll(RegExp(r'\D'), '')
        .replaceFirst(RegExp(r'^0+'), '');
    return '$_phoneCountryCode$number';
  }

  void _continueToPayment() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    NavigationService.push(
      Routes.paymentScreen,
      arguments: {
        'address': ShippingAddress(
          fullName: _nameCtrl.text.trim(),
          phone: _fullPhoneNumber,
          city: _selectedCity,
          district: _districtCtrl.text.trim(),
          street: _streetCtrl.text.trim(),
          notes: _notesCtrl.text.trim(),
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, cart) {
        return Scaffold(
          body: Column(
            children: [
              ScreenHeaderBar(title: LocaleKeys.store_checkout_title.tr()),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BlocBuilder<CitiesCubit, CitiesState>(
                          bloc: _citiesCubit,
                          builder: (context, citiesState) {
                            final cities = citiesState is CitiesSuccess
                                ? citiesState.cities
                                : const <CityModel>[];

                            return DeliveryAddressForm(
                              nameController: _nameCtrl,
                              phoneController: _phoneCtrl,
                              cities: cities,
                              selectedCity: _selectedCity,
                              onCityChanged: (city) =>
                                  setState(() => _selectedCity = city),
                              onRetryCities: _citiesCubit.getCities,
                              citiesLoading: citiesState is CitiesInitial ||
                                  citiesState is CitiesLoading,
                              citiesError: citiesState is CitiesError,
                              streetController: _streetCtrl,
                              notesController: _notesCtrl,
                              requiredValidator: _requiredValidator,
                              onPhoneChanged: _onPhoneChanged,
                              districtController: _districtCtrl,
                            );
                          },
                        ),
                        14.height,
                        CheckoutOrderBriefCard(
                          itemsCount: cart.itemsCount,
                          total: cart.total,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomActionBar(
            title: '${LocaleKeys.store_continue_to_payment.tr()} · '
                '${ConvertHelper.formatPrice(cart.total)} '
                '${LocaleKeys.store_currency.tr()}',
            enabled: !cart.isEmpty,
            onTap: _continueToPayment,
          ),
        );
      },
    );
  }
}
