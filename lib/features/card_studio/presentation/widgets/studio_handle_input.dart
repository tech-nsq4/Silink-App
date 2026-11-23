import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/studio_platform.dart';

class StudioHandleInput extends StatefulWidget {
  const StudioHandleInput({
    super.key,
    required this.controller,
    required this.platform,
    required this.hint,
    required this.onChanged,
    required this.onLinkPasted,
  });

  final TextEditingController controller;
  final StudioPlatform platform;
  final String hint;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onLinkPasted;

  @override
  State<StudioHandleInput> createState() => _StudioHandleInputState();
}

class _StudioHandleInputState extends State<StudioHandleInput> {
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

  void _onChanged(String raw) {
    if (StudioPlatform.isFullLink(raw)) {
      widget.onLinkPasted(raw);
      return;
    }
    final clean = StudioPlatform.cleanHandle(raw);
    if (clean != raw) {
      widget.controller.value = TextEditingValue(
        text: clean,
        selection: TextSelection.collapsed(offset: clean.length),
      );
    }
    widget.onChanged(clean);
  }

  @override
  Widget build(BuildContext context) {
    final brand = widget.platform.color;
    final focused = _focus.hasFocus;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.studioFieldFill.themeColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: focused ? brand : AppColors.studioFieldBorder.themeColor,
            width: focused ? 1.6 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
              color: brand.withValues(alpha: 0.09),
              child: AppText(
                widget.platform.displayBase,
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.studioFieldText.themeColor
                    .withValues(alpha: 0.75),
              ),
            ),
            Expanded(
              child: TextField(
                controller: widget.controller,
                focusNode: _focus,
                onChanged: _onChanged,
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
                  hintText: widget.hint,
                  hintStyle: TextStyle(
                    fontFamily: AppFonts.familyFont,
                    fontSize: 11.sp,
                    color: AppColors.studioFieldHint.themeColor,
                  ),
                  isDense: true,
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 13.h),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
