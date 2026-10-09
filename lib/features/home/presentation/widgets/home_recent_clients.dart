import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../clients/data/models/client_model.dart';

class HomeRecentClients extends StatelessWidget {
  const HomeRecentClients({
    super.key,
    required this.clients,
    required this.emptyLabel,
    required this.onTap,
  });

  final List<ClientModel> clients;
  final String emptyLabel;
  final ValueChanged<ClientModel> onTap;

  String _subtitle(ClientModel client) {
    final categories = client.categories.map((c) => c.name).join('، ');
    return categories.isNotEmpty ? categories : client.mobile;
  }

  @override
  Widget build(BuildContext context) {
    final line = AppColors.studioStepLine.themeColor;
    if (clients.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        child: AppText(
          emptyLabel,
          fontSize: 10.sp,
          color: AppColors.textSecondaryColor.themeColor,
        ),
      );
    }
    return Column(
      children: [
        for (final client in clients)
          InkWell(
            onTap: () => onTap(client),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: line)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36.w,
                    height: 36.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.studioStepIdleBadge.themeColor,
                      shape: BoxShape.circle,
                    ),
                    child: AppText(
                      client.name.trim().isEmpty
                          ? '?'
                          : client.name.trim().characters.first,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textSecondaryColor.themeColor,
                    ),
                  ),
                  12.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          client.name,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w800,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5.h),
                        AppText(
                          _subtitle(client),
                          fontSize: 8.5.sp,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          color: AppColors.textSecondaryColor.themeColor,
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_left_rounded,
                      size: 20.sp,
                      color: AppColors.textSecondaryColor.themeColor),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
