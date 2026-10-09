import '../../../core/storage/local_storage.dart';
import 'models/client_extras.dart';

class ClientExtrasStore {
  ClientExtrasStore({required LocalStorage storage}) : _storage = storage;

  static const String _followUpsKey = 'client_follow_ups';
  static const String _notesKey = 'client_notes';

  final LocalStorage _storage;

  Map<String, dynamic> _map(String key) =>
      Map<String, dynamic>.from(_storage.read<Map>(key) ?? const {});

  ClientFollowUp? followUp(String clientId) {
    final json = _map(_followUpsKey)[clientId];
    return json is Map
        ? ClientFollowUp.fromJson(Map<String, dynamic>.from(json))
        : null;
  }

  Future<void> saveFollowUp(String clientId, ClientFollowUp? followUp) {
    final all = _map(_followUpsKey);
    if (followUp == null) {
      all.remove(clientId);
    } else {
      all[clientId] = followUp.toJson();
    }
    return _storage.write(_followUpsKey, all);
  }

  int pendingFollowUps(Iterable<String> clientIds) {
    final now = DateTime.now();
    return clientIds
        .map(followUp)
        .whereType<ClientFollowUp>()
        .where((item) => !item.at.isBefore(now))
        .length;
  }

  List<ClientNote> notes(String clientId) {
    final list = _map(_notesKey)[clientId];
    if (list is! List) return const [];
    return list
        .whereType<Map>()
        .map((json) => ClientNote.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  Future<void> addNote(String clientId, ClientNote note) {
    final all = _map(_notesKey);
    all[clientId] = [
      note.toJson(),
      for (final existing in notes(clientId)) existing.toJson(),
    ];
    return _storage.write(_notesKey, all);
  }

  Future<void> removeClient(String clientId) async {
    await saveFollowUp(clientId, null);
    final all = _map(_notesKey)..remove(clientId);
    await _storage.write(_notesKey, all);
  }
}
