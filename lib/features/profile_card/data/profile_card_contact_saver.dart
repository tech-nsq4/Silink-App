import 'package:flutter_contacts/flutter_contacts.dart';

import 'models/profile_card_model.dart';

class ProfileCardContactSaver {
  const ProfileCardContactSaver();

  Contact toContact(ProfileCardModel card) {
    final basic = card.basic;
    final fullName = basic.fullName.trim();
    final phone = basic.phone.trim();
    final whatsapp = card.whatsapp?.value.trim() ?? '';
    final company = basic.company.trim();
    final jobTitle = basic.jobTitle.trim();
    final urls = <String>{
      ...card.socialChannels.map((channel) => channel.url),
      ...card.visibleLinks.map((link) => link.url),
    };

    return Contact(
      displayName: fullName,
      name: Name(first: fullName),
      phones: [
        if (phone.isNotEmpty) Phone(number: phone, isPrimary: true),
        if (whatsapp.isNotEmpty && whatsapp != phone) Phone(number: whatsapp),
      ],
      emails: [
        if (basic.email.trim().isNotEmpty)
          Email(address: basic.email.trim(), isPrimary: true),
      ],
      addresses: [
        if (basic.address.trim().isNotEmpty)
          Address(formatted: basic.address.trim()),
      ],
      organizations: [
        if (company.isNotEmpty || jobTitle.isNotEmpty)
          Organization(
            name: company.isEmpty ? null : company,
            jobTitle: jobTitle.isEmpty ? null : jobTitle,
          ),
      ],
      websites: [for (final url in urls) Website(url: url)],
    );
  }

  Future<bool> save(ProfileCardModel card) async {
    final createdId =
        await FlutterContacts.native.showCreator(contact: toContact(card));
    return createdId != null;
  }
}
