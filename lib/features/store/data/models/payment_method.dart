import '../../../../core/utils/locale_keys.dart';

enum PaymentMethod { creditCard, cashOnDelivery }

extension PaymentMethodX on PaymentMethod {
  String get value => switch (this) {
        PaymentMethod.creditCard => 'credit_card',
        PaymentMethod.cashOnDelivery => 'cash_on_delivery',
      };

  String get labelKey => switch (this) {
        PaymentMethod.creditCard => LocaleKeys.store_credit_card,
        PaymentMethod.cashOnDelivery => LocaleKeys.store_cash_on_delivery,
      };

  static PaymentMethod fromString(String value) => switch (value) {
        'cash_on_delivery' => PaymentMethod.cashOnDelivery,
        _ => PaymentMethod.creditCard,
      };
}
