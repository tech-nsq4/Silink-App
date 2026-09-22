import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/screen_state_layout.dart';
import 'package:Silink/features/profile_completion/logic/profile_completion_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/ranking_row_card.dart';

class ContentRankingStep extends StatefulWidget {
  const ContentRankingStep({super.key});

  @override
  State<ContentRankingStep> createState() => _ContentRankingStepState();
}

class _ContentRankingStepState extends State<ContentRankingStep> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCompletionCubit>().loadArrangement();
  }

  IconData _iconFor(String type) {
    switch (type) {
      case 'basic':
        return Icons.person_outline;
      case 'bio':
        return Icons.description_outlined;
      case 'quick_contact':
        return Icons.call_outlined;
      case 'channels':
        return Icons.share_outlined;
      case 'links':
        return Icons.link;
      case 'products':
        return Icons.inventory_2_outlined;
      case 'services':
        return Icons.work_outline;
      default:
        return Icons.widgets_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCompletionCubit, ProfileCompletionState>(
      builder: (context, state) {
        return CustomScreenStateLayout(
          isLoading: state.arrangementLoading && state.arrangement.isEmpty,
          error: state.arrangementError != null
              ? ErrorModel(
                  code: ErrorEnum.otherError,
                  errorMessage: state.arrangementError!,
                )
              : null,
          onRetry: () => context
              .read<ProfileCompletionCubit>()
              .loadArrangement(force: true),
          builder: (context) {
            final sections = state.arrangement;
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    LocaleKeys.ranking_title.tr(),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                  ),
                  4.height,
                  AppText(
                    LocaleKeys.ranking_subtitle.tr(),
                    fontSize: 14.sp,
                  ),
                  16.height,
                  for (final entry in sections.indexed)
                    RankingRowCard(
                      title: entry.$2.label,
                      icon: _iconFor(entry.$2.type),
                      enabled: entry.$2.visible,
                      locked: entry.$2.locked,
                      hint: entry.$2.hint,
                      canMoveUp: entry.$1 > 0 &&
                          !entry.$2.locked &&
                          !sections[entry.$1 - 1].locked,
                      canMoveDown: entry.$1 < sections.length - 1 &&
                          !entry.$2.locked &&
                          !sections[entry.$1 + 1].locked,
                      onToggle: (v) => context
                          .read<ProfileCompletionCubit>()
                          .toggleArrangementVisible(entry.$2.type, v),
                      onMoveUp: () => context
                          .read<ProfileCompletionCubit>()
                          .moveArrangementSection(entry.$2.type, -1),
                      onMoveDown: () => context
                          .read<ProfileCompletionCubit>()
                          .moveArrangementSection(entry.$2.type, 1),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
