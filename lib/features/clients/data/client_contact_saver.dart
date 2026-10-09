import 'package:flutter_contacts/flutter_contacts.dart';

import 'models/client_model.dart';
import 'models/client_request.dart';

class ClientContactSaver {
  const ClientContactSaver();

  Contact toContact(ClientModel client) {
    final name = client.name.trim();
    final mobile = ClientRequest.withCountryCode(client.mobile);
    final whatsapp = ClientRequest.withCountryCode(client.whatsapp);
    final email = client.email.trim();
    return Contact(
      displayName: name,
      name: Name(first: name),
      phones: [
        if (mobile.isNotEmpty) Phone(number: mobile, isPrimary: true),
        if (whatsapp.isNotEmpty && whatsapp != mobile) Phone(number: whatsapp),
      ],
      emails: [if (email.isNotEmpty) Email(address: email, isPrimary: true)],
    );
  }

  Future<bool> save(ClientModel client) async {
    final createdId =
        await FlutterContacts.native.showCreator(contact: toContact(client));
    return createdId != null;
  }
}
