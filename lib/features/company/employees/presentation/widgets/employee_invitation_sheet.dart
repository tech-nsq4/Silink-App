import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/features/company/employees/data/models/employee_invitation_model.dart';
import 'package:Silink/features/company/employees/presentation/widgets/employee_invitation_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeInvitationSheet extends StatelessWidget {
  const EmployeeInvitationSheet({super.key, required this.invitation});

  final EmployeeInvitationModel invitation;

  static Future<void> show(
    BuildContext context,
    EmployeeInvitationModel invitation,
  ) =>
      showModalBottomSheet<void>(
        context: context,
        backgroundColor: AppColors.backgroundColor.themeColor,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        builder: (_) => EmployeeInvitationSheet(invitation: invitation),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: EmployeeInvitationCard(invitation: invitation),
      ),
    );
  }
}
