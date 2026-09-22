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

class ContactChannelsStep extends StatefulWidget {
  const ContactChannelsStep({super.key});

  @override
  State<ContactChannelsStep> createState() => _ContactChannelsStepState();
}

class _ContactChannelsStepState extends State<ContactChannelsStep> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCompletionCubit>().loadChannels();
  }

  Widget _badgeFor(String type) {
    switch (type) {
      case 'whatsapp':
        return const ChannelBadge(label: 'W', color: Color(0xFF25D366));
      case 'linkedin':
        return const ChannelBadge(label: 'in', color: Color(0xFF0A66C2));
      case 'instagram':
        return const ChannelBadge(label: 'IG', color: Color(0xFFC13584));
      case 'x':
        return const ChannelBadge(label: 'X', color: Colors.black);
      case 'snapchat':
        return const ChannelBadge(
          label: 'SC',
          color: Color(0xFFFFFC00),
          textColor: Colors.black,
        );
      case 'tiktok':
        return const ChannelBadge(label: 'TT', color: Colors.black);
      default:
        return const ChannelBadge(label: '#', color: Colors.blueGrey);
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
    context.read<ProfileCompletionCubit>().updateChannelValue(type, result);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCompletionCubit, ProfileCompletionState>(
      builder: (context, state) {
        return CustomScreenStateLayout(
          isLoading: state.channelsLoading && state.channels.isEmpty,
          error: state.channelsError != null
              ? ErrorModel(
                  code: ErrorEnum.otherError,
                  errorMessage: state.channelsError!,
                )
              : null,
          onRetry: () =>
              context.read<ProfileCompletionCubit>().loadChannels(force: true),
          builder: (context) => SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  LocaleKeys.channels_title.tr(),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                ),
                4.height,
                AppText(
                  LocaleKeys.channels_subtitle.tr(),
                  fontSize: 14.sp,
                ),
                16.height,
                for (final channel in state.channels) ...[
                  ToggleFieldRow(
                    title: channel.label,
                    hint: channel.placeholder,
                    value: channel.value,
                    enabled: channel.visible,
                    badge: _badgeFor(channel.type),
                    onToggle: (v) {
                      if (v && channel.value.trim().isEmpty) {
                        _edit(channel.type, channel.label, channel.placeholder,
                            channel.value);
                        return;
                      }
                      context
                          .read<ProfileCompletionCubit>()
                          .toggleChannelVisible(channel.type, v);
                    },
                    onEditTap: () => _edit(
                      channel.type,
                      channel.label,
                      channel.placeholder,
                      channel.value,
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
