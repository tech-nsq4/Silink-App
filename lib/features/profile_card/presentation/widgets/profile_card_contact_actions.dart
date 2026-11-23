import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_overlay.dart';
import '../../../../core/utils/helper_methods.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/public_profile/public_profile_data.dart';
import '../../../profile_completion/data/models/catalog_model.dart';
import '../../../profile_completion/presentation/widgets/profile_catalog_item_details.dart';
import '../../data/models/profile_card_lead_request.dart';
import '../../data/models/profile_card_model.dart';
import '../../data/profile_card_contact_saver.dart';
import 'profile_card_share_data_dialog.dart';

class ProfileCardContactActions {
  const ProfileCardContactActions(this.context, this.card);

  final BuildContext context;
  final ProfileCardModel? card;

  PublicProfileActions build({
    VoidCallback? onShare,
    VoidCallback? onClose,
  }) =>
      PublicProfileActions(
        onShare: onShare,
        onClose: onClose,
        onCall: call,
        onEmail: email,
        onSaveContact: saveContact,
        onShareData: shareData,
        onOpenContact: openContact,
        onItemTap: openItem,
        onMainContact: mainContact,
      );

  Future<void> _launch(Future<void> Function() action) async {
    try {
      await action();
    } catch (_) {
      AppOverlay.showError(LocaleKeys.common_somethingWentWrong.tr());
    }
  }

  String get _phone => card?.basic.phone.trim() ?? '';

  String get _email => card?.basic.email.trim() ?? '';

  void call() {
    if (_phone.isEmpty) return;
    _launch(() => HelperMethods.openUri(Uri(scheme: 'tel', path: _phone)));
  }

  void email() {
    if (_email.isEmpty) return;
    _launch(() => HelperMethods.openUri(Uri(scheme: 'mailto', path: _email)));
  }

  void openContact(PublicProfileContact contact) =>
      _launch(() => HelperMethods.openLink(contact.url));

  void mainContact() {
    final whatsapp = card?.whatsapp;
    if (whatsapp != null) {
      _launch(() => HelperMethods.openLink(whatsapp.url));
    } else if (_phone.isNotEmpty) {
      call();
    } else if (_email.isNotEmpty) {
      email();
    } else {
      shareData();
    }
  }

  Future<void> saveContact() async {
    final current = card;
    if (current == null) return;
    try {
      final saved = await const ProfileCardContactSaver().save(current);
      if (saved) AppOverlay.showSuccess(LocaleKeys.publish_contactSaved.tr());
    } catch (_) {
      AppOverlay.showError(LocaleKeys.common_somethingWentWrong.tr());
    }
  }

  void shareData() => ProfileCardShareDataDialog.show(
        context,
        ownerName: card?.basic.fullName.trim() ?? '',
        onSubmit: _submitLead,
      );

  Future<bool> _submitLead(ProfileCardLeadRequest lead) async {
    AppOverlay.showSuccess(LocaleKeys.common_comingSoon.tr());
    return false;
  }

  void openItem(PublicProfileItem item) {
    final product = card?.products.where((p) => p.id == item.id).firstOrNull;
    if (product == null) return;
    openProfileCatalogItemDetails(
      context,
      CatalogItemModel(
        id: product.id,
        kind: product.kind,
        name: product.name,
        description: product.description,
        priceLabel: product.priceLabel,
        price: product.price,
        actionType: product.actionType,
        actionUrl: product.actionUrl,
        imageUrl: product.imageUrl,
      ),
      visible: product.isActive,
    );
  }
}
