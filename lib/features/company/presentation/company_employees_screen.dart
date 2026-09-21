import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:Silink/features/company/logic/company_cubit.dart';
import 'package:Silink/features/company/logic/company_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyEmployeesScreen extends StatelessWidget {
  const CompanyEmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyCubit, CompanyState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                ScreenHeaderBar(
                  title: LocaleKeys.company_employees.tr(),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(19.w),
                    itemCount: state.employees.length,
                    separatorBuilder: (_, __) =>
                        SizedBox(height: 8.h),
                    itemBuilder: (context, index) {
                      final e = state.employees[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: AppText(e.initial),
                        ),
                        title: AppText(e.name),
                        subtitle: AppText(e.role),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline_rounded),
                          onPressed: () => context
                              .read<CompanyCubit>()
                              .removeEmployee(e.id),
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
