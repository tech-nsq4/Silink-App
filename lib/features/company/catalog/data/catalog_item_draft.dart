import 'dart:io';

import 'package:equatable/equatable.dart';

class CatalogItemDraft extends Equatable {
  const CatalogItemDraft({
    required this.kind,
    required this.name,
    this.description = '',
    this.price = '',
    this.priceLabel = '',
    this.actionType = 'inquire',
    this.actionUrl = '',
    this.section = '',
    this.image,
  });

  final String kind;
  final String name;
  final String description;
  final String price;
  final String priceLabel;
  final String actionType;
  final String actionUrl;
  final String section;
  final File? image;

  @override
  List<Object?> get props => [
        kind,
        name,
        description,
        price,
        priceLabel,
        actionType,
        actionUrl,
        section,
        image,
      ];
}
