import '../../../../core/utils/locale_keys.dart';

enum PaymentMethod {
  creditCard,
  applePay,
  cashOnDelivery;

  static PaymentMethod fromValue(String? value) => PaymentMethod.values
      .firstWhere((method) => method.value == value, orElse: () => cashOnDelivery);
}

extension PaymentMethodX on PaymentMethod {
  String get value => switch (this) {
        PaymentMethod.creditCard => 'card',
        PaymentMethod.applePay => 'apple_pay',
        PaymentMethod.cashOnDelivery => 'cash',
      };

  String get labelKey => switch (this) {
        PaymentMethod.creditCard => LocaleKeys.store_credit_card,
        PaymentMethod.applePay => LocaleKeys.store_apple_pay,
        PaymentMethod.cashOnDelivery => LocaleKeys.store_cash_on_delivery,
      };

  bool get requiresCardDetails => this == PaymentMethod.creditCard;
}
