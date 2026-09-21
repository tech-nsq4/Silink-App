import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/screen_state_layout.dart';
import 'package:Silink/features/profile_completion/logic/profile_completion_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Silink/core/widgets/channel_badge.dart';
import 'widgets/edit_field_sheet.dart';
import 'widgets/toggle_field_row.dart';

class ContactLinksStep extends StatefulWidget {
  const ContactLinksStep({super.key});

  @override
  State<ContactLinksStep> createState() => _ContactLinksStepState();
}

class _ContactLinksStepState extends State<ContactLinksStep> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCompletionCubit>().loadLinks();
  }

  IconData _iconFor(String type) {
    switch (type) {
      case 'website':
        return Icons.language;
      case 'portfolio':
        return Icons.grid_view_outlined;
      case 'booking':
        return Icons.calendar_today_outlined;
      case 'quote':
        return Icons.description_outlined;
      case 'profile':
        return Icons.file_download_outlined;
      case 'custom':
        return Icons.link;
      default:
        return Icons.link;
    }
  }

  Future<void> _edit(String type, String label, String placeholder,
      String initialValue) async {
    final result = await showEditFieldSheet(
      context,
      title: label,
      hint: placeholder,
      initialValue: initialValue,
    );
    if (result == null || !mounted) return;
    context.read<ProfileCompletionCubit>().updateLinkValue(type, result);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCompletionCubit, ProfileCompletionState>(
      builder: (context, state) {
        return CustomScreenStateLayout(
          isLoading: state.linksLoading && state.links.isEmpty,
          error: state.linksError != null
              ? ErrorModel(
                  code: ErrorEnum.otherError,
                  errorMessage: state.linksError!,
                )
              : null,
          onRetry: () =>
              context.read<ProfileCompletionCubit>().loadLinks(force: true),
          builder: (context) => SingleChildScrollView(
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
                for (final link in state.links) ...[
                  ToggleFieldRow(
                    title: link.label,
                    hint: link.placeholder,
                    value: link.value,
                    enabled: link.visible,
                    badge: LinkBadge(icon: _iconFor(link.type)),
                    onToggle: (v) {
                      if (v && link.value.trim().isEmpty) {
                        _edit(link.type, link.label, link.placeholder,
                            link.value);
                        return;
                      }
                      context
                          .read<ProfileCompletionCubit>()
                          .toggleLinkVisible(link.type, v);
                    },
                    onEditTap: () => _edit(
                      link.type,
                      link.label,
                      link.placeholder,
                      link.value,
                    ),
                  ),
                  10.height,
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
