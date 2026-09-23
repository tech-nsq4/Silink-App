import 'package:Silink/core/utils/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';

/// حالة العميل في قائمة العملاء المحتملين.
enum ClientStatus {
  all,
  newClient,
  important,
  contacted,
  qualified,
  converted,
  lost,
  notImportant,
}

enum ClientSource { qr, nfc }

class ClientModel {
  const ClientModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.status,
    required this.source,
    this.role,
    this.company,
    this.email,
    this.message,
    this.submitDateLabel,
    this.submitTimeLabel,
    this.tags = const [],
    this.hoursAgo,
    this.daysAgo,
  });

  final String id;
  final String name;
  final String phone;
  final String? role;
  final String? company;
  final String? email;
  final String? message;
  final String? submitDateLabel;
  final String? submitTimeLabel;
  final List<String> tags;
  final ClientStatus status;
  final ClientSource source;
  final int? hoursAgo;
  final int? daysAgo;

  String get timeLabel {
    if (hoursAgo != null) {
      return LocaleKeys.clients_hoursAgo.tr(args: ['$hoursAgo']);
    }
    return LocaleKeys.clients_daysAgo.tr(args: ['$daysAgo']);
  }

  String get sourceLabel =>
      source == ClientSource.nfc ? 'NFC' : LocaleKeys.clients_sourceQr.tr();
}

extension ClientStatusX on ClientStatus {
  String get statusLabel {
    switch (this) {
      case ClientStatus.all:
        return LocaleKeys.clients_filterAll.tr();
      case ClientStatus.newClient:
        return LocaleKeys.clients_filterNew.tr();
      case ClientStatus.important:
        return LocaleKeys.clients_statusImportant.tr();
      case ClientStatus.contacted:
        return LocaleKeys.clients_filterContacted.tr();
      case ClientStatus.qualified:
        return LocaleKeys.clients_filterQualified.tr();
      case ClientStatus.converted:
        return LocaleKeys.clients_filterConverted.tr();
      case ClientStatus.lost:
        return LocaleKeys.clients_statusLost.tr();
      case ClientStatus.notImportant:
        return LocaleKeys.clients_statusNotImportant.tr();
    }
  }
}

/// تصنيفات العميل الثابتة المعروضة في شاشة تفاصيل العميل.
enum ClientTag {
  important,
  urgent,
  vip,
  potentialConversion,
  currentClient,
  returned,
  followUp,
  offerSubmitted,
}

extension ClientTagX on ClientTag {
  String get tagLabel {
    switch (this) {
      case ClientTag.important:
        return LocaleKeys.clients_tagImportant.tr();
      case ClientTag.urgent:
        return LocaleKeys.clients_tagUrgent.tr();
      case ClientTag.vip:
        return LocaleKeys.clients_tagVip.tr();
      case ClientTag.potentialConversion:
        return LocaleKeys.clients_tagPotentialConversion.tr();
      case ClientTag.currentClient:
        return LocaleKeys.clients_tagCurrentClient.tr();
      case ClientTag.returned:
        return LocaleKeys.clients_tagReturned.tr();
      case ClientTag.followUp:
        return LocaleKeys.clients_tagFollowUp.tr();
      case ClientTag.offerSubmitted:
        return LocaleKeys.clients_tagOfferSubmitted.tr();
    }
  }
}
