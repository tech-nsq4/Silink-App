import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:Silink/features/company/logic/company_cubit.dart';
import 'package:Silink/features/company/logic/company_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyCardsScreen extends StatelessWidget {
  const CompanyCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyCubit, CompanyState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                ScreenHeaderBar(
                  title: LocaleKeys.company_cards.tr(),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(19.w),
                    itemCount: state.cards.length + 1,
                    separatorBuilder: (_, __) =>
                        SizedBox(height: 10.h),
                    itemBuilder: (context, index) {
                      if (index == state.cards.length) {
                        return _AddTile(
                          onTap: () => context
                              .read<CompanyCubit>()
                              .addCard(
                                'Card ${state.cards.length + 1}',
                                CompanyCubit.generateCardCode(),
                              ),
                        );
                      }
                      final card = state.cards[index];
                      return ListTile(
                        title: AppText(card.name),
                        subtitle: AppText(card.code),
                        trailing: IconButton(
                          icon: const Icon(Icons.swap_horiz_rounded),
                          onPressed: () => context
                              .read<CompanyCubit>()
                              .toggleCardStatus(card.id),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AddTile extends StatelessWidget {
  const _AddTile({required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
