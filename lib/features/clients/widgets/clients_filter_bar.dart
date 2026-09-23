import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';
import '../models/client_model.dart';

class ClientsFilterBar extends StatelessWidget {
  const ClientsFilterBar(
      {super.key, required this.selected, required this.onSelected});

  final ClientStatus selected;
  final ValueChanged<ClientStatus> onSelected;

  static const _order = [
    ClientStatus.all,
    ClientStatus.newClient,
    ClientStatus.contacted,
    ClientStatus.qualified,
    ClientStatus.converted,
  ];

  String _label(ClientStatus status) {
    switch (status) {
      case ClientStatus.all:
        return LocaleKeys.clients_filterAll.tr();
      case ClientStatus.newClient:
        return LocaleKeys.clients_filterNew.tr();
      case ClientStatus.contacted:
        return LocaleKeys.clients_filterContacted.tr();
      case ClientStatus.qualified:
        return LocaleKeys.clients_filterQualified.tr();
      case ClientStatus.converted:
        return LocaleKeys.clients_filterConverted.tr();
      case ClientStatus.important:
        return LocaleKeys.clients_statusImportant.tr();
      case ClientStatus.lost:
        return LocaleKeys.clients_statusLost.tr();
      case ClientStatus.notImportant:
        return LocaleKeys.clients_statusNotImportant.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 19.w),
        itemCount: _order.length,
        separatorBuilder: (_, __) => 8.width,
        itemBuilder: (context, index) {
          final status = _order[index];
          final isSelected = status == selected;
          return GestureDetector(
            onTap: () => onSelected(status),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.successColor.themeColor
                    : AppColors.white.themeColor,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : AppColors.borderColor.themeColor,
                ),
              ),
              child: Center(
                child: AppText(
                  _label(status),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: isSelected
                      ? Colors.white
                      : AppColors.textSecondaryColor.themeColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
