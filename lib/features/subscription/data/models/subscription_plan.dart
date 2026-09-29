import 'package:equatable/equatable.dart';

enum SubscriptionPeriod { monthly, yearly }

extension SubscriptionPeriodX on SubscriptionPeriod {
  String get value => switch (this) {
        SubscriptionPeriod.monthly => 'monthly',
        SubscriptionPeriod.yearly => 'yearly',
      };

  static SubscriptionPeriod fromValue(String? value) =>
      SubscriptionPeriod.values.firstWhere(
        (period) => period.value == value,
        orElse: () => SubscriptionPeriod.monthly,
      );
}

class SubscriptionPlan extends Equatable {
  final String id;
  final String name;
  final String nameEn;
  final double price;
  final SubscriptionPeriod period;
  final int maxMembers;
  final int maxCards;
  final List<String> features;

  const SubscriptionPlan({
    required this.id,
    required this.name,
    required this.price,
    this.nameEn = '',
    this.period = SubscriptionPeriod.monthly,
    this.maxMembers = 0,
    this.maxCards = 0,
    this.features = const [],
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      nameEn: json['nameEn'] as String? ?? '',
      price: double.tryParse(json['price']?.toString() ?? '') ?? 0,
      period: SubscriptionPeriodX.fromValue(json['period'] as String?),
      maxMembers: int.tryParse(json['maxMembers']?.toString() ?? '') ?? 0,
      maxCards: int.tryParse(json['maxCards']?.toString() ?? '') ?? 0,
      features: (json['features'] as List?)
              ?.whereType<String>()
              .toList(growable: false) ??
          const [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'nameEn': nameEn,
        'price': price.toStringAsFixed(2),
        'period': period.value,
        'maxMembers': maxMembers,
        'maxCards': maxCards,
        'features': features,
      };

  String localizedName(String languageCode) =>
      languageCode == 'en' && nameEn.trim().isNotEmpty ? nameEn : name;

  bool get isYearly => period == SubscriptionPeriod.yearly;

  @override
  List<Object?> get props =>
      [id, name, nameEn, price, period, maxMembers, maxCards, features];
}
