part of 'checkout_cubit.dart';

enum CheckoutStatus { idle, submitting, success, failure }

class CheckoutState extends Equatable {
  final ShippingAddress address;
  final PaymentMethod paymentMethod;
  final bool saveAddress;
  final CheckoutStatus status;
  final String failureMessage;
  final StoreOrder? order;

  const CheckoutState({
    this.address = const ShippingAddress(),
    this.paymentMethod = PaymentMethod.creditCard,
    this.saveAddress = true,
    this.status = CheckoutStatus.idle,
    this.failureMessage = '',
    this.order,
  });

  bool get isSubmitting => status == CheckoutStatus.submitting;

  CheckoutState copyWith({
    ShippingAddress? address,
    PaymentMethod? paymentMethod,
    bool? saveAddress,
    CheckoutStatus? status,
    String? failureMessage,
    StoreOrder? order,
  }) =>
      CheckoutState(
        address: address ?? this.address,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        saveAddress: saveAddress ?? this.saveAddress,
        status: status ?? this.status,
        failureMessage: failureMessage ?? this.failureMessage,
        order: order ?? this.order,
      );

  @override
  List<Object?> get props =>
      [address, paymentMethod, saveAddress, status, failureMessage, order];
}
