import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/locale_keys.dart';
import '../../data/models/studio_item.dart';
import 'studio_catalog_row.dart';
import 'studio_catalog_toggles.dart';
import 'studio_content_summary.dart';
import 'studio_editor_heading.dart';
import 'studio_empty_block.dart';
import 'studio_subtle_note.dart';

class StudioContentStep extends StatelessWidget {
  const StudioContentStep({
    super.key,
    required this.items,
    required this.servicesEnabled,
    required this.productsEnabled,
    required this.onToggleCatalog,
    required this.busyItemId,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
    required this.onReorder,
  });

  final List<StudioItem> items;
  final bool servicesEnabled;
  final bool productsEnabled;
  final void Function({required bool services, required bool enabled})
      onToggleCatalog;
  final String? busyItemId;
  final VoidCallback onAdd;
  final ValueChanged<StudioItem> onEdit;
  final ValueChanged<StudioItem> onDelete;
  final void Function(int oldIndex, int newIndex) onReorder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StudioEditorHeading(
          title: LocaleKeys.cardStudio_contentTitle.tr(),
          subtitle: LocaleKeys.cardStudio_contentSubtitle.tr(),
        ),
        StudioCatalogToggles(
          servicesEnabled: servicesEnabled,
          productsEnabled: productsEnabled,
          onServicesChanged: (v) => onToggleCatalog(services: true, enabled: v),
          onProductsChanged: (v) =>
              onToggleCatalog(services: false, enabled: v),
        ),
        StudioContentSummary(count: items.length, onAdd: onAdd),
        if (items.isEmpty)
          const StudioEmptyBlock()
        else
          for (final (index, item) in items.indexed)
            StudioCatalogRow(
              key: ValueKey(item.localId),
              item: item,
              busy: busyItemId == item.localId,
              onEdit: () => onEdit(item),
              onDelete: () => onDelete(item),
              onMoveUp: index == 0 ? null : () => onReorder(index, index - 1),
              onMoveDown: index == items.length - 1
                  ? null
                  : () => onReorder(index, index + 1),
            ),
        StudioSubtleNote(text: LocaleKeys.cardStudio_visibleNote.tr()),
      ],
    );
  }
}
