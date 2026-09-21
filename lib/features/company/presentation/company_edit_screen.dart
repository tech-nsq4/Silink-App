import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:Silink/features/company/logic/company_cubit.dart';
import 'package:Silink/features/company/widgets/company_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyEditScreen extends StatelessWidget {
  const CompanyEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final company = context.watch<CompanyCubit>().state.company;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ScreenHeaderBar(title: LocaleKeys.company_edit.tr()),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(19.w),
                child: CompanySectionCard(
                  title: LocaleKeys.company_edit.tr(),
                  child: Column(
                    children: [
                      CompanyField(
                        label: LocaleKeys.company_name.tr(),
                        hint: LocaleKeys.company_name_hint.tr(),
                      ),
                      SizedBox(height: 12.h),
                      CompanyField(
                        label: LocaleKeys.company_phone.tr(),
                        hint: LocaleKeys.company_phone_hint.tr(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
