import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/studio_contact.dart';
import 'studio_input.dart';
import 'studio_toggle.dart';

class StudioLinkList extends StatelessWidget {
  const StudioLinkList({
    super.key,
    required this.links,
    required this.controllers,
    required this.labelOf,
    required this.onToggle,
    required this.onChanged,
  });

  final List<StudioContact> links;
  final Map<String, TextEditingController> controllers;
  final String Function(String type) labelOf;
  final void Function(String type, bool visible) onToggle;
  final void Function(String type, String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(13.r),
        border: Border.all(color: AppColors.studioLinkBorder.themeColor),
      ),
      child: Column(
        children: [
          for (final (index, link) in links.indexed)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 13.h),
              decoration: BoxDecoration(
                border: index == 0
                    ? null
                    : Border(
                        top: BorderSide(
                            color: AppColors.studioLinkDivider.themeColor),
                      ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Icon(Icons.link_rounded,
                          size: 15.sp,
                          color: AppColors.studioLinkIcon.themeColor),
                      8.width,
                      Expanded(
                        child: AppText(
                          labelOf(link.type),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      StudioToggle(
                        value: link.visible,
                        onChanged: (value) => onToggle(link.type, value),
                      ),
                    ],
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 240),
                    curve: Curves.easeOutCubic,
                    alignment: Alignment.topCenter,
                    child: link.visible
                        ? Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: StudioInput(
                              controller: controllers[link.type]!,
                              hint: 'https://…',
                              ltr: true,
                              keyboardType: TextInputType.url,
                              onChanged: (value) =>
                                  onChanged(link.type, value),
                            ),
                          )
                        : const SizedBox(width: double.infinity),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
