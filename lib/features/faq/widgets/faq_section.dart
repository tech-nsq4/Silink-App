import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_loading_widget.dart';
import '../../account/widgets/account_section_card.dart';
import '../logic/faq_cubit.dart';
import '../presentation/faq_tile.dart';

class FaqSection extends StatelessWidget {
  const FaqSection({super.key, required this.cubit});

  final FaqCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FaqCubit, FaqState>(
      bloc: cubit,
      builder: (context, state) => switch (state) {
        FaqInitial() || FaqLoading() => Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: CustomLoadingWidget(
              color: AppColors.primaryColor.themeColor,
              size: 32,
            ),
          ),
        FaqError(:final message) => _buildError(message),
        FaqSuccess(:final faqs) when faqs.isEmpty => const SizedBox.shrink(),
        FaqSuccess(:final faqs) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTitle(),
              10.height,
              AccountSectionCard(
                children: [
                  for (var i = 0; i < faqs.length; i++)
                    FaqTile(
                      key: ValueKey(faqs[i].id),
                      question: faqs[i].question,
                      answer: faqs[i].answer,
                      initiallyExpanded: i == 0,
                    ),
                ],
              ),
              18.height,
            ],
          ),
      },
    );
  }

  Widget _buildTitle() {
    return AppText(
      LocaleKeys.help_faqSection.tr(),
      fontSize: 12.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.textSecondaryColor.themeColor,
    );
  }

  Widget _buildError(String message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTitle(),
        10.height,
        AccountSectionCard(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          children: [
            Row(
              children: [
                Expanded(
                  child: AppText(
                    message,
                    fontSize: 12.sp,
                    color: AppColors.textSecondaryColor.themeColor,
                  ),
                ),
                TextButton(
                  onPressed: cubit.getFaqs,
                  child: AppText(
                    LocaleKeys.common_retry.tr(),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor.themeColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        18.height,
      ],
    );
  }
}
