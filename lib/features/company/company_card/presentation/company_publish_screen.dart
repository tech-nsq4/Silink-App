import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyPublishScreen extends StatelessWidget {
  const CompanyPublishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ScreenHeaderBar(
              title: LocaleKeys.company_publish.tr(),
            ),
            Expanded(child: SizedBox(height: 12.h)),
            Padding(
              padding: EdgeInsets.all(19.w),
              child: CustomButton(
                onTap: () {},
                title: LocaleKeys.company_publish.tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
