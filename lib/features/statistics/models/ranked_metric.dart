import 'package:equatable/equatable.dart';

class RankedMetric extends Equatable {
  final String label;
  final String value;
  final double percent;

  const RankedMetric({
    required this.label,
    required this.value,
    required this.percent,
  });

  factory RankedMetric.fromJson(Map<String, dynamic> json) => RankedMetric(
        label: json['label'] as String,
        value: json['value'] as String,
        percent: (json['percent'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'label': label,
        'value': value,
        'percent': percent,
      };

  @override
  List<Object?> get props => [label, value, percent];
}
