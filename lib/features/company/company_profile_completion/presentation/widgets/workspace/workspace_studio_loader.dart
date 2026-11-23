import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/locale_keys.dart';
import '../../../../../../core/widgets/app_error.dart';
import '../../../../../../core/widgets/custom_loading_widget.dart';
import '../../../../../card_studio/logic/card_studio_cubit.dart';

class WorkspaceStudioLoader extends StatelessWidget {
  const WorkspaceStudioLoader({
    super.key,
    required this.cubit,
    required this.builder,
  });

  final CardStudioCubit cubit;
  final Widget Function(CardStudioSuccess state) builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardStudioCubit, CardStudioState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is CardStudioSuccess) return builder(state);
        if (state is CardStudioError) {
          return AppError(
            message: state.message,
            retryLabel: LocaleKeys.common_retry.tr(),
            onRetry: cubit.startContentOnly,
          );
        }
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 60.h),
          child: CustomLoadingWidget(
            color: AppColors.accentTeal.themeColor,
            size: 30,
          ),
        );
      },
    );
  }
}
