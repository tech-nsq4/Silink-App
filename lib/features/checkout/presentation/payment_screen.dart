import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/routes.dart';
import '../../../core/di/injection.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/convert_helper.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/bottom_action_bar.dart';
import '../../../core/widgets/screen_header_bar.dart';
import '../../cart/logic/cart_cubit.dart';
import '../data/models/payment_method.dart';
import '../data/models/shipping_address.dart';
import '../logic/checkout_cubit.dart';
import 'widgets/payment_card_form.dart';
import 'widgets/payment_method_tile.dart';
import 'widgets/payment_total_card.dart';
import 'widgets/secure_payment_note.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.address});

  final ShippingAddress address;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final CheckoutCubit _cubit = getIt<CheckoutCubit>();
  final _cardCtrl = TextEditingController();
  final _expiryCtrl = TextEditingController();
  final _cvvCtrl = TextEditingController();
  PaymentMethod _method = PaymentMethod.creditCard;

  @override
  void dispose() {
    _cubit.close();
    _cardCtrl.dispose();
    _expiryCtrl.dispose();
    _cvvCtrl.dispose();
    super.dispose();
  }

  bool get _isCardValid {
    final cardDigits = _cardCtrl.text.replaceAll(RegExp(r'\D'), '');
    final expiryDigits = _expiryCtrl.text.replaceAll(RegExp(r'\D'), '');
    final cvvDigits = _cvvCtrl.text.replaceAll(RegExp(r'\D'), '');
    if (cardDigits.length != 16 || expiryDigits.length != 4) return false;
    final month = int.tryParse(expiryDigits.substring(0, 2)) ?? 0;
    return month >= 1 && month <= 12 && cvvDigits.length >= 3;
  }

  bool get _canConfirm => !_method.requiresCardDetails || _isCardValid;

  void _confirm(CartState cart) {
    FocusScope.of(context).unfocus();
    _cubit.placeOrder(
      address: widget.address,
      paymentMethod: _method,
      items: cart.items,
      subtotal: cart.subtotal,
      shipping: cart.shipping,
    );
  }

  void _onCheckoutStateChanged(BuildContext context, CheckoutState state) {
    if (state is! CheckoutSuccess) return;
    context.read<CartCubit>().clear();
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.orderSuccessScreen,
      (route) => route.settings.name == Routes.storeScreen || route.isFirst,
      arguments: {'order': state.order},
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartCubit>().state;

    return BlocConsumer<CheckoutCubit, CheckoutState>(
      bloc: _cubit,
      listener: _onCheckoutStateChanged,
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              ScreenHeaderBar(title: LocaleKeys.store_payment_title.tr()),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PaymentTotalCard(total: cart.total),
                      18.height,
                      AppText(
                        LocaleKeys.store_payment_method.tr(),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
                      ),
                      10.height,
                      for (final method in PaymentMethod.values) ...[
                        PaymentMethodTile(
                          method: method,
                          isSelected: method == _method,
                          onTap: () => setState(() => _method = method),
                        ),
                        10.height,
                      ],
                      if (_method.requiresCardDetails) ...[
                        6.height,
                        PaymentCardForm(
                          cardNumberController: _cardCtrl,
                          expiryController: _expiryCtrl,
                          cvvController: _cvvCtrl,
                          onChanged: (_) => setState(() {}),
                        ),
                      ],
                      14.height,
                      const SecurePaymentNote(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomActionBar(
            title: '${LocaleKeys.store_confirm_payment.tr()} · '
                '${ConvertHelper.formatPrice(cart.total)} '
                '${LocaleKeys.store_currency.tr()}',
            enabled: _canConfirm && !cart.isEmpty,
            loading: state is CheckoutLoading,
            onTap: () => _confirm(cart),
          ),
        );
      },
    );
  }
}
