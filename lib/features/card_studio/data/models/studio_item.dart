import 'dart:io';

import 'package:equatable/equatable.dart';

class StudioItem extends Equatable {
  const StudioItem({
    required this.localId,
    required this.kind,
    required this.name,
    this.remoteId,
    this.description = '',
    this.price = '',
    this.priceLabel = '',
    this.actionType = defaultActionType,
    this.actionUrl = '',
    this.imageUrl,
    this.imageFile,
    this.visible = true,
  });

  static const String defaultActionType = 'inquire';
  static const List<String> actionTypes = [
    'inquire',
    'order',
    'book',
    'whatsapp',
    'link',
  ];

  final String localId;
  final String? remoteId;
  final String kind;
  final String name;
  final String description;
  final String price;
  final String priceLabel;
  final String actionType;
  final String actionUrl;
  final String? imageUrl;
  final File? imageFile;
  final bool visible;

  bool get isService => kind == 'service';

  StudioItem copyWith({
    String? remoteId,
    String? kind,
    String? name,
    String? description,
    String? price,
    String? priceLabel,
    String? actionType,
    String? actionUrl,
    String? imageUrl,
    File? imageFile,
    bool? visible,
  }) =>
      StudioItem(
        localId: localId,
        remoteId: remoteId ?? this.remoteId,
        kind: kind ?? this.kind,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        priceLabel: priceLabel ?? this.priceLabel,
        actionType: actionType ?? this.actionType,
        actionUrl: actionUrl ?? this.actionUrl,
        imageUrl: imageUrl ?? this.imageUrl,
        imageFile: imageFile ?? this.imageFile,
        visible: visible ?? this.visible,
      );

  @override
  List<Object?> get props => [
        localId,
        remoteId,
        kind,
        name,
        description,
        price,
        priceLabel,
        actionType,
        actionUrl,
        imageUrl,
        imageFile,
        visible,
      ];
}
