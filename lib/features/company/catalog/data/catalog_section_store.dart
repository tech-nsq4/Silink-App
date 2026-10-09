import '../../../../core/storage/local_storage.dart';

class CatalogSectionStore {
  CatalogSectionStore({required LocalStorage storage}) : _storage = storage;

  static const String _key = 'catalog_item_sections';

  final LocalStorage _storage;

  Map<String, String> all() => {
        for (final entry in (_storage.read<Map>(_key) ?? const {}).entries)
          entry.key.toString(): entry.value.toString(),
      };

  Future<void> save(String itemId, String section) {
    final sections = all();
    if (section.trim().isEmpty) {
      sections.remove(itemId);
    } else {
      sections[itemId] = section.trim();
    }
    return _storage.write(_key, sections);
  }

  Future<void> remove(String itemId) => save(itemId, '');
}
