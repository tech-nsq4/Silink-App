import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/extensions.dart';
import '../utils/app_colors.dart';
import '../utils/convert_helper.dart';
import '../utils/locale_keys.dart';
import 'app_text.dart';
import 'gradient_action_button.dart';

class AppColorPickerDialog extends StatefulWidget {
  const AppColorPickerDialog({super.key, required this.initial});

  final Color initial;

  static const List<Color> hueStops = [
    Color(0xFFFF0000),
    Color(0xFFFFFF00),
    Color(0xFF00FF00),
    Color(0xFF00FFFF),
    Color(0xFF0000FF),
    Color(0xFFFF00FF),
    Color(0xFFFF0000),
  ];

  static Future<Color?> show(BuildContext context, {required Color initial}) =>
      showDialog<Color>(
        context: context,
        builder: (_) => AppColorPickerDialog(initial: initial),
      );

  @override
  State<AppColorPickerDialog> createState() => _AppColorPickerDialogState();
}

class _AppColorPickerDialogState extends State<AppColorPickerDialog> {
  late HSVColor _hsv = HSVColor.fromColor(widget.initial);

  void _pickShade(Offset position, Size size) {
    final s = (position.dx / size.width).clamp(0.0, 1.0);
    final v = 1 - (position.dy / size.height).clamp(0.0, 1.0);
    setState(() => _hsv = _hsv.withSaturation(s).withValue(v));
  }

  void _pickHue(double dx, double width) {
    final hue = (dx / width).clamp(0.0, 1.0) * 360;
    setState(() => _hsv = _hsv.withHue(hue == 360 ? 359.9 : hue));
  }

  Widget _thumb(Color color) => Container(
        width: 20.w,
        height: 20.w,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white.light, width: 3),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.light.withValues(alpha: 0.25),
              blurRadius: 4,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final color = _hsv.toColor();
    final pureHue = HSVColor.fromAHSV(1, _hsv.hue, 1, 1).toColor();
    final thumb = 20.w;
    return Dialog(
      backgroundColor: AppColors.white.themeColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.r)),
      child: Padding(
        padding: EdgeInsets.all(18.w),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Directionality(
                textDirection: Directionality.of(context),
                child: AppText(
                  LocaleKeys.cardStudio_colorPickerTitle.tr(),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 14.h),
              LayoutBuilder(
                builder: (context, constraints) {
                  final size = Size(constraints.maxWidth, 170.h);
                  return GestureDetector(
                    onPanDown: (d) => _pickShade(d.localPosition, size),
                    onPanUpdate: (d) => _pickShade(d.localPosition, size),
                    child: SizedBox.fromSize(
                      size: size,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14.r),
                              child: DecoratedBox(
                                decoration: BoxDecoration(color: pureHue),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.white.light,
                                        AppColors.white.light
                                            .withValues(alpha: 0),
                                      ],
                                    ),
                                  ),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          AppColors.black.light
                                              .withValues(alpha: 0),
                                          AppColors.black.light,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: _hsv.saturation * size.width - thumb / 2,
                            top: (1 - _hsv.value) * size.height - thumb / 2,
                            child: _thumb(color),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16.h),
              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  return GestureDetector(
                    onPanDown: (d) => _pickHue(d.localPosition.dx, width),
                    onPanUpdate: (d) => _pickHue(d.localPosition.dx, width),
                    child: SizedBox(
                      height: thumb,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.centerLeft,
                        children: [
                          Container(
                            height: 12.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              gradient: const LinearGradient(
                                colors: AppColorPickerDialog.hueStops,
                              ),
                            ),
                          ),
                          Positioned(
                            left: _hsv.hue / 360 * width - thumb / 2,
                            child: _thumb(pureHue),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Container(
                    width: 34.w,
                    height: 34.w,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: AppColors.studioPanelBorder.themeColor),
                    ),
                  ),
                  10.width,
                  AppText(
                    ConvertHelper.colorToHex(color),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: AppText(
                        LocaleKeys.cardStudio_colorPickerCancel.tr(),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondaryColor.themeColor,
                      ),
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: GradientActionButton(
                      title: LocaleKeys.cardStudio_colorPickerConfirm.tr(),
                      centerTitle: true,
                      radius: 12,
                      minHeight: 42,
                      onTap: () => Navigator.of(context).pop(color),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
