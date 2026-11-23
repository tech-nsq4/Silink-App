import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/extensions/extensions.dart';
import '../../../../../../core/utils/locale_keys.dart';
import '../../../../../card_studio/data/models/studio_contact.dart';
import '../../../../../card_studio/presentation/widgets/studio_labels.dart';
import 'workspace_review_channel_tile.dart';
import 'workspace_review_empty.dart';
import 'workspace_review_link_chip.dart';
import 'workspace_review_section.dart';

class WorkspaceReviewChannels extends StatelessWidget {
  const WorkspaceReviewChannels({
    super.key,
    required this.channels,
    required this.links,
    required this.onEdit,
  });

  final List<StudioContact> channels;
  final List<StudioContact> links;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final shownChannels = channels.where((c) => c.isShown).toList();
    final shownLinks = links.where((l) => l.isShown).toList();
    return WorkspaceReviewSection(
      title: LocaleKeys.companyWorkspace_reviewChannels.tr(),
      onEdit: onEdit,
      child: shownChannels.isEmpty && shownLinks.isEmpty
          ? WorkspaceReviewEmpty(
              text: LocaleKeys.companyWorkspace_reviewEmptyChannels.tr(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (shownChannels.isNotEmpty)
                  Wrap(
                    spacing: 6.w,
                    runSpacing: 14.h,
                    children: [
                      for (final (index, channel) in shownChannels.indexed)
                        WorkspaceReviewChannelTile(
                          type: channel.type,
                          label: StudioLabels.contact(channel.type),
                          index: index,
                        ),
                    ],
                  ),
                if (shownChannels.isNotEmpty && shownLinks.isNotEmpty)
                  16.height,
                if (shownLinks.isNotEmpty)
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      for (final link in shownLinks)
                        WorkspaceReviewLinkChip(
                          label: StudioLabels.contact(link.type),
                        ),
                    ],
                  ),
              ],
            ),
    );
  }
}
