import '../../../../core/utils/locale_keys.dart';

enum OrderStatus {
  placed,
  processing,
  shipped,
  delivered,
  cancelled,
  unknown;

  static OrderStatus fromValue(String? value) => OrderStatus.values.firstWhere(
        (status) => status.name == value,
        orElse: () => OrderStatus.unknown,
      );
}

extension OrderStatusX on OrderStatus {
  String get labelKey => switch (this) {
        OrderStatus.placed => LocaleKeys.orders_status_placed,
        OrderStatus.processing => LocaleKeys.orders_status_processing,
        OrderStatus.shipped => LocaleKeys.orders_status_shipped,
        OrderStatus.delivered => LocaleKeys.orders_status_delivered,
        OrderStatus.cancelled => LocaleKeys.orders_status_cancelled,
        OrderStatus.unknown => '',
      };
}
