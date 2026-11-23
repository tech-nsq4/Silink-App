import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/locale_keys.dart';

class StudioLinkInput extends StatefulWidget {
  const StudioLinkInput({
    super.key,
    required this.controller,
    required this.color,
    required this.onChanged,
    this.autofocus = false,
  });

  final TextEditingController controller;
  final Color color;
  final ValueChanged<String> onChanged;
  final bool autofocus;

  @override
  State<StudioLinkInput> createState() => _StudioLinkInputState();
}

class _StudioLinkInputState extends State<StudioLinkInput> {
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focused = _focus.hasFocus;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: AppColors.studioFieldFill.themeColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: focused
                ? widget.color
                : AppColors.studioFieldBorder.themeColor,
            width: focused ? 1.6 : 1,
          ),
        ),
        child: TextField(
          controller: widget.controller,
          focusNode: _focus,
          autofocus: widget.autofocus,
          onChanged: widget.onChanged,
          keyboardType: TextInputType.url,
          autocorrect: false,
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontFamily: AppFonts.familyFont,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.studioFieldText.themeColor,
          ),
          decoration: InputDecoration(
            hintText: LocaleKeys.cardStudio_linkHint.tr(),
            hintStyle: TextStyle(
              fontFamily: AppFonts.familyFont,
              fontSize: 11.sp,
              color: AppColors.studioFieldHint.themeColor,
            ),
            isDense: true,
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.link_rounded,
              size: 18.sp,
              color: widget.color,
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
          ),
        ),
      ),
    );
  }
}
