import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/features/profile_completion/models/profile_completion_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/channel_badge.dart';
import 'widgets/edit_field_sheet.dart';
import 'widgets/toggle_field_row.dart';

class ContactLinksStep extends StatefulWidget {
  const ContactLinksStep({super.key, required this.data});

  final ProfileCompletionData data;

  @override
  State<ContactLinksStep> createState() => _ContactLinksStepState();
}

class _ContactLinksStepState extends State<ContactLinksStep> {
  static const _order = ContactLinkType.values;

  String _titleFor(ContactLinkType type) {
    switch (type) {
      case ContactLinkType.website:
        return LocaleKeys.links_website.tr();
      case ContactLinkType.portfolio:
        return LocaleKeys.links_portfolio.tr();
      case ContactLinkType.booking:
        return LocaleKeys.links_booking.tr();
      case ContactLinkType.quote:
        return LocaleKeys.links_quote.tr();
      case ContactLinkType.brochure:
        return LocaleKeys.links_brochure.tr();
      case ContactLinkType.customLink:
        return LocaleKeys.links_customLink.tr();
    }
  }

  String _hintFor(ContactLinkType type) {
    switch (type) {
      case ContactLinkType.website:
        return LocaleKeys.links_websiteHint.tr();
      case ContactLinkType.portfolio:
        return LocaleKeys.links_portfolioHint.tr();
      case ContactLinkType.booking:
        return LocaleKeys.links_bookingHint.tr();
      case ContactLinkType.quote:
        return LocaleKeys.links_quoteHint.tr();
      case ContactLinkType.brochure:
        return LocaleKeys.links_brochureHint.tr();
      case ContactLinkType.customLink:
        return LocaleKeys.links_customLinkHint.tr();
    }
  }

  IconData _iconFor(ContactLinkType type) {
    switch (type) {
      case ContactLinkType.website:
        return Icons.language;
      case ContactLinkType.portfolio:
        return Icons.grid_view_outlined;
      case ContactLinkType.booking:
        return Icons.calendar_today_outlined;
      case ContactLinkType.quote:
        return Icons.description_outlined;
      case ContactLinkType.brochure:
        return Icons.file_download_outlined;
      case ContactLinkType.customLink:
        return Icons.link;
    }
  }

  Future<void> _edit(ContactLinkType type) async {
    final field = widget.data.links[type]!;
    final result = await showEditFieldSheet(
      context,
      title: _titleFor(type),
      hint: _hintFor(type),
      initialValue: field.value,
    );
    if (result == null) return;
    setState(() {
      field.value = result;
      if (result.isNotEmpty) field.enabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            LocaleKeys.links_title.tr(),
            fontSize: 20.sp,
            fontWeight: FontWeight.w800,
          ),
          4.height,
          AppText(
            LocaleKeys.links_subtitle.tr(),
            fontSize: 14.sp,
          ),
          16.height,
          for (final type in _order) ...[
            ToggleFieldRow(
              title: _titleFor(type),
              hint: _hintFor(type),
              value: widget.data.links[type]!.value,
              enabled: widget.data.links[type]!.enabled,
              badge: LinkBadge(icon: _iconFor(type)),
              onToggle: (v) =>
                  setState(() => widget.data.links[type]!.enabled = v),
              onEditTap: () => _edit(type),
            ),
            10.height,
          ],
        ],
      ),
    );
  }
}
