import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/routes.dart';
import '../../../core/di/injection.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/convert_helper.dart';
import '../../../core/utils/custom_text_field_phone/custom_text_field_phone_code.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/flow_page_title.dart';
import '../../../core/widgets/flow_stepper.dart';
import '../../../core/widgets/flow_top_bar.dart';
import '../../../core/widgets/gradient_action_button.dart';
import '../../cart/logic/cart_cubit.dart';
import '../../cart/presentation/widgets/cart_empty_view.dart';
import '../data/models/city_model.dart';
import '../data/models/payment_method.dart';
import '../data/models/shipping_address.dart';
import '../logic/checkout_cubit.dart';
import '../logic/cities_cubit.dart';
import 'widgets/checkout_section_card.dart';
import 'widgets/flow/order_cart_item_card.dart';
import 'widgets/flow/order_free_delivery_bar.dart';
import 'widgets/flow/order_link_button.dart';
import 'widgets/flow/order_select_field.dart';
import 'widgets/flow/order_summary_card.dart';
import 'widgets/flow/order_total_card.dart';
import 'widgets/labeled_text_field.dart';
import 'widgets/payment_card_form.dart';
import 'widgets/payment_method_tile.dart';
import 'widgets/secure_payment_note.dart';

class OrderFlowScreen extends StatefulWidget {
  const OrderFlowScreen({super.key, this.initialStep = 0});

  final int initialStep;

  @override
  State<OrderFlowScreen> createState() => _OrderFlowScreenState();
}

class _OrderFlowScreenState extends State<OrderFlowScreen> {
  static const int cartStep = 0;
  static const int deliveryStep = 1;
  static const int paymentStep = 2;

  late final CheckoutCubit _checkoutCubit = getIt<CheckoutCubit>();
  late final CitiesCubit _citiesCubit = getIt<CitiesCubit>()..getCities();
  late final _nameCtrl = TextEditingController(text: kUserModel?.fullName);
  final _phoneCtrl = TextEditingController();
  final _districtCtrl = TextEditingController();
  final _streetCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  final _cardCtrl = TextEditingController();
  final _expiryCtrl = TextEditingController();
  final _cvvCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  late int _step = widget.initialStep;
  bool _addressStage = false;
  String _phoneCountryCode = '+966';
  CityModel? _city;
  PaymentMethod _method = PaymentMethod.creditCard;

  List<String> get _stepLabels => [
        LocaleKeys.orderFlow_stepCart.tr(),
        LocaleKeys.orderFlow_stepDelivery.tr(),
        LocaleKeys.orderFlow_stepPayment.tr(),
      ];

  @override
  void dispose() {
    for (final controller in [
      _nameCtrl,
      _phoneCtrl,
      _districtCtrl,
      _streetCtrl,
      _notesCtrl,
      _cardCtrl,
      _expiryCtrl,
      _cvvCtrl,
    ]) {
      controller.dispose();
    }
    _scrollCtrl.dispose();
    _checkoutCubit.close();
    _citiesCubit.close();
    super.dispose();
  }

  String get _fullPhone {
    final number = _phoneCtrl.text
        .replaceAll(RegExp(r'\D'), '')
        .replaceFirst(RegExp(r'^0+'), '');
    return '$_phoneCountryCode$number';
  }

  ShippingAddress get _address => ShippingAddress(
        fullName: _nameCtrl.text.trim(),
        phone: _fullPhone,
        city: _city,
        district: _districtCtrl.text.trim(),
        street: _streetCtrl.text.trim(),
        notes: _notesCtrl.text.trim(),
      );

  bool get _isCardValid {
    final card = _cardCtrl.text.replaceAll(RegExp(r'\D'), '');
    final expiry = _expiryCtrl.text.replaceAll(RegExp(r'\D'), '');
    final cvv = _cvvCtrl.text.replaceAll(RegExp(r'\D'), '');
    if (card.length != 16 || expiry.length != 4) return false;
    final month = int.tryParse(expiry.substring(0, 2)) ?? 0;
    return month >= 1 && month <= 12 && cvv.length >= 3;
  }

  void _move(int step, {bool addressStage = false}) {
    setState(() {
      _step = step;
      _addressStage = addressStage;
    });
    if (_scrollCtrl.hasClients) _scrollCtrl.jumpTo(0);
  }

  bool _requireFilled(List<TextEditingController> controllers) {
    final missing = controllers.any((c) => c.text.trim().isEmpty);
    if (missing) {
      AppOverlay.showError(LocaleKeys.orderFlow_errorRequired.tr());
    }
    return !missing;
  }

  void _next(CartState cart) {
    FocusScope.of(context).unfocus();
    switch (_step) {
      case cartStep:
        _move(deliveryStep);
      case deliveryStep when !_addressStage:
        if (_requireFilled([_nameCtrl, _phoneCtrl])) {
          _move(deliveryStep, addressStage: true);
        }
      case deliveryStep:
        if (_city == null) {
          AppOverlay.showError(LocaleKeys.orderFlow_errorRequired.tr());
          return;
        }
        if (_requireFilled([_districtCtrl, _streetCtrl])) _move(paymentStep);
      default:
        if (_method.requiresCardDetails && !_isCardValid) {
          AppOverlay.showError(LocaleKeys.orderFlow_errorCard.tr());
          return;
        }
        _checkoutCubit.placeOrder(
          address: _address,
          paymentMethod: _method,
          items: cart.items,
          subtotal: cart.subtotal,
          shipping: cart.shipping,
        );
    }
  }

  void _back() {
    if (_step == paymentStep) {
      _move(deliveryStep, addressStage: true);
    } else if (_step == deliveryStep && _addressStage) {
      _move(deliveryStep);
    } else if (_step == deliveryStep) {
      _move(cartStep);
    } else {
      Navigator.of(context).maybePop();
    }
  }

  void _goToStep(int step) {
    if (step < _step) _move(step);
  }

  void _onCheckout(BuildContext context, CheckoutState state) {
    if (state is! CheckoutSuccess) return;
    context.read<CartCubit>().clear();
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.orderSuccessScreen,
      (route) => route.settings.name == Routes.storeScreen || route.isFirst,
      arguments: {'order': state.order},
    );
  }

  String get _headerTitle => switch (_step) {
        cartStep => LocaleKeys.orderFlow_headerCart.tr(),
        deliveryStep => LocaleKeys.orderFlow_headerDelivery.tr(),
        _ => LocaleKeys.orderFlow_headerPayment.tr(),
      };

  String get _nextTitle => switch (_step) {
        cartStep => LocaleKeys.orderFlow_toDelivery.tr(),
        deliveryStep when !_addressStage => LocaleKeys.orderFlow_toAddress.tr(),
        deliveryStep => LocaleKeys.orderFlow_toPayment.tr(),
        _ => LocaleKeys.orderFlow_confirm.tr(),
      };

  Widget _summary(CartState cart) => Padding(
        padding: EdgeInsets.only(top: 16.h),
        child: OrderSummaryCard(
          subtotal: cart.subtotal,
          shipping: cart.shipping,
          total: cart.total,
        ),
      );

  List<Widget> _cartView(CartState cart) {
    final cubit = context.read<CartCubit>();
    return [
      FlowPageTitle(
        eyebrow: LocaleKeys.orderFlow_cartEyebrow.tr(),
        title: LocaleKeys.orderFlow_cartTitle.tr(),
        subtitle:
            LocaleKeys.orderFlow_cartCount.tr(args: ['${cart.itemsCount}']),
      ),
      for (final item in cart.items)
        OrderCartItemCard(
          item: item,
          onQuantityChanged: (quantity) => cubit.updateQuantity(item, quantity),
          onRemove: () => cubit.removeItem(item),
        ),
      OrderFreeDeliveryBar(subtotal: cart.subtotal),
      _summary(cart),
      OrderLinkButton(
        label: LocaleKeys.orderFlow_keepShopping.tr(),
        icon: Icons.add_rounded,
        onTap: () => Navigator.of(context).maybePop(),
      ),
    ];
  }

  List<Widget> _recipientView(CartState cart) => [
        FlowPageTitle(
          eyebrow: LocaleKeys.orderFlow_recipientEyebrow.tr(),
          title: LocaleKeys.orderFlow_recipientTitle.tr(),
          subtitle: LocaleKeys.orderFlow_deliverySubtitle.tr(),
        ),
        CheckoutSectionCard(
          icon: Icons.phone_outlined,
          title: '',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LabeledTextField(
                label: LocaleKeys.orderFlow_recipientName.tr(),
                controller: _nameCtrl,
                required: true,
              ),
              SizedBox(height: 16.h),
              AppText(
                '${LocaleKeys.orderFlow_recipientPhone.tr()} *',
                fontSize: 10.5.sp,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 8.h),
              CustomTextFieldPhoneCode(
                controller: _phoneCtrl,
                initialCountryCode: 'SA',
                isRequired: false,
                borderRadius: 14.r,
                fillColor: AppColors.white.themeColor,
                borderColor: AppColors.studioPanelBorder.themeColor,
                focusedBorderColor: AppColors.accentTeal.themeColor,
                onChanged: (phone) => _phoneCountryCode = phone.countryCode,
              ),
            ],
          ),
        ),
        _summary(cart),
      ];

  List<Widget> _addressView(CartState cart) => [
        FlowPageTitle(
          eyebrow: LocaleKeys.orderFlow_addressEyebrow.tr(),
          title: LocaleKeys.orderFlow_addressTitle.tr(),
          subtitle: LocaleKeys.orderFlow_deliverySubtitle.tr(),
        ),
        CheckoutSectionCard(
          icon: Icons.location_on_outlined,
          title: '',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocBuilder<CitiesCubit, CitiesState>(
                bloc: _citiesCubit,
                builder: (context, state) => OrderSelectField<CityModel>(
                  label: LocaleKeys.orderFlow_city.tr(),
                  hint: LocaleKeys.orderFlow_cityHint.tr(),
                  value: _city,
                  options: state is CitiesSuccess
                      ? state.cities
                      : const <CityModel>[],
                  labelOf: (city) => city.name,
                  loading: state is CitiesInitial || state is CitiesLoading,
                  onRetry: _citiesCubit.getCities,
                  onChanged: (city) => setState(() => _city = city),
                ),
              ),
              SizedBox(height: 16.h),
              LabeledTextField(
                label: LocaleKeys.orderFlow_district.tr(),
                controller: _districtCtrl,
                required: true,
              ),
              SizedBox(height: 16.h),
              LabeledTextField(
                label: LocaleKeys.orderFlow_street.tr(),
                controller: _streetCtrl,
                required: true,
              ),
              SizedBox(height: 16.h),
              LabeledTextField(
                label: LocaleKeys.orderFlow_notes.tr(),
                controller: _notesCtrl,
                maxLines: 2,
              ),
            ],
          ),
        ),
        OrderLinkButton(
          label: LocaleKeys.orderFlow_editRecipient.tr(),
          onTap: () => _move(deliveryStep),
        ),
        _summary(cart),
      ];

  List<Widget> _paymentView(CartState cart) => [
        FlowPageTitle(
          eyebrow: LocaleKeys.orderFlow_paymentEyebrow.tr(),
          title: LocaleKeys.orderFlow_paymentTitle.tr(),
        ),
        OrderTotalCard(total: cart.total),
        SizedBox(height: 20.h),
        AppText(
          LocaleKeys.orderFlow_paymentMethod.tr(),
          fontSize: 12.sp,
          fontWeight: FontWeight.w800,
        ),
        SizedBox(height: 12.h),
        for (final method in PaymentMethod.values) ...[
          PaymentMethodTile(
            method: method,
            isSelected: method == _method,
            onTap: () => setState(() => _method = method),
          ),
          SizedBox(height: 10.h),
        ],
        if (_method.requiresCardDetails) ...[
          SizedBox(height: 6.h),
          PaymentCardForm(
            cardNumberController: _cardCtrl,
            expiryController: _expiryCtrl,
            cvvController: _cvvCtrl,
            onChanged: (_) => setState(() {}),
          ),
        ],
        SizedBox(height: 14.h),
        const SecurePaymentNote(),
      ];

  List<Widget> _stepView(CartState cart) => switch (_step) {
        cartStep => _cartView(cart),
        deliveryStep when !_addressStage => _recipientView(cart),
        deliveryStep => _addressView(cart),
        _ => _paymentView(cart),
      };

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartCubit>().state;
    return BlocConsumer<CheckoutCubit, CheckoutState>(
      bloc: _checkoutCubit,
      listener: _onCheckout,
      builder: (context, checkout) => PopScope(
        canPop: _step == cartStep,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) _back();
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor.themeColor,
          body: Column(
            children: [
              SafeArea(
                bottom: false,
                child: FlowTopBar(
                  eyebrow: LocaleKeys.shop_headerTitle.tr(),
                  title: _headerTitle,
                  onBack: _back,
                ),
              ),
              Expanded(
                child: cart.isEmpty
                    ? const CartEmptyView()
                    : ListView(
                        controller: _scrollCtrl,
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: EdgeInsets.fromLTRB(22.w, 6.h, 22.w, 24.h),
                        children: [
                          FlowStepper(
                            labels: _stepLabels,
                            current: _step,
                            onTap: _goToStep,
                          ),
                          ..._stepView(cart),
                        ],
                      ),
              ),
              if (!cart.isEmpty)
                Container(
                  padding: EdgeInsets.fromLTRB(22.w, 12.h, 22.w, 12.h),
                  decoration: BoxDecoration(
                    color: AppColors.white.themeColor,
                    border: Border(
                      top: BorderSide(
                          color: AppColors.studioStepLine.themeColor),
                    ),
                  ),
                  child: SafeArea(
                    top: false,
                    child: GradientActionButton(
                      title: _nextTitle,
                      trailing: _step == paymentStep
                          ? '${ConvertHelper.formatPrice(cart.total)} ${LocaleKeys.store_currency.tr()}'
                          : null,
                      icon: Icons.arrow_back_rounded,
                      radius: 14,
                      minHeight: 50,
                      loading: checkout is CheckoutLoading,
                      onTap: () => _next(cart),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
