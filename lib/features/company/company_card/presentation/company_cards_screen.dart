import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyCardsScreen extends StatelessWidget {
  const CompanyCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                itemCount: 0,
                separatorBuilder: (_, __) =>
                    SizedBox(height: 10.h),
                itemBuilder: (context, index) =>
                    const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
