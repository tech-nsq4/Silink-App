import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AuthFieldLabel extends StatelessWidget {
  const AuthFieldLabel({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: AppText(
        text,
        fontSize: 14,
        color: AppColors.primaryColor.themeColor,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
