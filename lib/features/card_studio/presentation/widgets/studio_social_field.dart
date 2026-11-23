import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/custom_text_field_phone/custom_text_field_phone_code.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';
import '../../data/models/studio_platform.dart';
import '../../data/models/studio_whatsapp.dart';
import 'studio_handle_input.dart';
import 'studio_link_input.dart';
import 'studio_link_preview.dart';
import 'studio_mode_tabs.dart';
import 'studio_platform_badge.dart';
import 'studio_toggle.dart';

class StudioSocialField extends StatefulWidget {
  const StudioSocialField({
    super.key,
    required this.type,
    required this.label,
    required this.visible,
    required this.value,
    required this.controller,
    required this.onToggle,
    required this.onChanged,
  });

  final String type;
  final String label;
  final bool visible;
  final String value;
  final TextEditingController controller;
  final ValueChanged<bool> onToggle;
  final ValueChanged<String> onChanged;

  @override
  State<StudioSocialField> createState() => _StudioSocialFieldState();
}

class _StudioSocialFieldState extends State<StudioSocialField> {
  late final StudioPlatform _platform = StudioPlatform.of(widget.type);
  late bool _linkMode = _platform.isCustomLink(widget.value);
  late final TextEditingController _linkCtrl =
      TextEditingController(text: _linkMode ? widget.value : '');
  late String _handleValue = _linkMode ? '' : widget.value;
  late String _linkValue = _linkMode ? widget.value : '';

  bool get _isWhatsapp => widget.type == StudioPlatform.whatsapp.type;

  @override
  void dispose() {
    _linkCtrl.dispose();
    super.dispose();
  }

  void _setHandleValue(String value) {
    _handleValue = value;
    widget.onChanged(value);
  }

  void _setLinkValue(String raw) {
    _linkValue = StudioPlatform.normalizeLink(raw);
    widget.onChanged(_linkValue);
  }

  void _switchMode(int index) {
    final toLink = index == 1;
    if (toLink == _linkMode) return;
    setState(() => _linkMode = toLink);
    widget.onChanged(toLink ? _linkValue : _handleValue);
  }

  void _onLinkPasted(String raw) {
    _linkCtrl.value = TextEditingValue(
      text: raw.trim(),
      selection: TextSelection.collapsed(offset: raw.trim().length),
    );
    widget.controller.clear();
    _handleValue = '';
    setState(() => _linkMode = true);
    _setLinkValue(raw);
  }

  Widget _handleInput() {
    if (_isWhatsapp) {
      return CustomTextFieldPhoneCode(
        key: const ValueKey('number'),
        controller: widget.controller,
        hint: LocaleKeys.cardStudio_whatsappHint.tr(),
        initialCountryCode: StudioWhatsapp.parse(_handleValue).iso,
        isRequired: false,
        disableLengthCheck: true,
        borderRadius: 10,
        fillColor: AppColors.studioFieldFill.themeColor,
        borderColor: AppColors.studioFieldBorder.themeColor,
        focusedBorderColor: _platform.color,
        onChanged: (phone) => _setHandleValue(
          StudioWhatsapp.compose(phone.countryCode, phone.number),
        ),
      );
    }
    return StudioHandleInput(
      key: const ValueKey('handle'),
      controller: widget.controller,
      platform: _platform,
      hint: LocaleKeys.cardStudio_usernameHint.tr(),
      onChanged: (handle) => _setHandleValue(_platform.compose(handle)),
      onLinkPasted: _onLinkPasted,
    );
  }

  Widget _body() {
    return Padding(
      padding: EdgeInsets.only(top: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StudioModeTabs(
            labels: [
              _isWhatsapp
                  ? LocaleKeys.cardStudio_modeNumber.tr()
                  : LocaleKeys.cardStudio_modeUsername.tr(),
              LocaleKeys.cardStudio_modeLink.tr(),
            ],
            index: _linkMode ? 1 : 0,
            color: _platform.color,
            onChanged: _switchMode,
          ),
          12.height,
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            switchInCurve: Curves.easeOut,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                alignment: AlignmentDirectional.topStart,
                child: child,
              ),
            ),
            child: _linkMode
                ? StudioLinkInput(
                    key: const ValueKey('link'),
                    controller: _linkCtrl,
                    color: _platform.color,
                    onChanged: _setLinkValue,
                  )
                : _handleInput(),
          ),
          StudioLinkPreview(link: widget.value, color: _platform.color),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visible = widget.visible;
    final help = _isWhatsapp
        ? LocaleKeys.cardStudio_whatsappHelp.tr()
        : LocaleKeys.cardStudio_handleHelp.tr();
    return AnimatedContainer(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white.themeColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: visible
              ? _platform.color.withValues(alpha: 0.5)
              : AppColors.studioIdentityBorder.themeColor,
          width: visible ? 1.4 : 1,
        ),
        boxShadow: visible
            ? [
                BoxShadow(
                  color: _platform.color.withValues(alpha: 0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ]
            : const [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () => widget.onToggle(!visible),
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                StudioPlatformBadge(platform: _platform, active: visible),
                12.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        widget.label,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w800,
                      ),
                      2.height,
                      AppText(
                        help,
                        fontSize: 8.5.sp,
                        height: 1.4,
                        color: AppColors.studioFieldHint.themeColor,
                      ),
                    ],
                  ),
                ),
                8.width,
                StudioToggle(value: visible, onChanged: widget.onToggle),
              ],
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 260),
            sizeCurve: Curves.easeOutCubic,
            crossFadeState:
                visible ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            firstChild: const SizedBox(width: double.infinity),
            secondChild: _body(),
          ),
        ],
      ),
    );
  }
}
