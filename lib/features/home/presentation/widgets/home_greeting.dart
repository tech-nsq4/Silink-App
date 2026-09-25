import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/locale_keys.dart';
import '../../../../core/widgets/app_text.dart';

class HomeGreeting extends StatefulWidget {
  const HomeGreeting({super.key, required this.name});

  final String name;

  @override
  State<HomeGreeting> createState() => _HomeGreetingState();
}

class _HomeGreetingState extends State<HomeGreeting>
    with TickerProviderStateMixin {
  late final AnimationController _waveController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2400),
  )..repeat();

  late final AnimationController _nameController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  )..forward();

  late final AnimationController _shimmerController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2600),
  )..repeat();

  late final Animation<double> _wave = TweenSequence<double>([
    TweenSequenceItem(tween: Tween(begin: 0, end: 0.35), weight: 1),
    TweenSequenceItem(tween: Tween(begin: 0.35, end: -0.2), weight: 1),
    TweenSequenceItem(tween: Tween(begin: -0.2, end: 0.35), weight: 1),
    TweenSequenceItem(tween: Tween(begin: 0.35, end: -0.2), weight: 1),
    TweenSequenceItem(tween: Tween(begin: -0.2, end: 0), weight: 1),
    TweenSequenceItem(tween: ConstantTween(0), weight: 5),
  ]).animate(
    CurvedAnimation(parent: _waveController, curve: Curves.easeInOut),
  );

  late final Animation<double> _nameScale = Tween<double>(
    begin: 0.8,
    end: 1,
  ).animate(
    CurvedAnimation(parent: _nameController, curve: Curves.easeOutBack),
  );

  String get _greeting => DateTime.now().hour < 12
      ? LocaleKeys.home_greetingMorning.tr()
      : LocaleKeys.home_greeting.tr();

  Shader _shineShader(Rect bounds) {
    final base = AppColors.textPrimaryColor.themeColor;
    final shine = AppColors.mint.themeColor;
    final position = -0.3 + _shimmerController.value * 1.6;
    return LinearGradient(
      colors: [base, shine, base],
      stops: [
        (position - 0.2).clamp(0.0, 1.0),
        position.clamp(0.0, 1.0),
        (position + 0.2).clamp(0.0, 1.0),
      ],
    ).createShader(bounds);
  }

  @override
  void didUpdateWidget(covariant HomeGreeting oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.name != widget.name) _nameController.forward(from: 0);
  }

  @override
  void dispose() {
    _waveController.dispose();
    _nameController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.name.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              _greeting,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondaryColor.themeColor,
            ),
            4.width,
            AnimatedBuilder(
              animation: _wave,
              builder: (_, child) => Transform.rotate(
                angle: _wave.value,
                alignment: Alignment.bottomCenter,
                child: child,
              ),
              child: AppText('👋', fontSize: 13.sp),
            ),
          ],
        ),
        if (name.isNotEmpty)
          ScaleTransition(
            scale: _nameScale,
            alignment: AlignmentDirectional.centerStart
                .resolve(Directionality.of(context)),
            child: AnimatedBuilder(
              animation: _shimmerController,
              builder: (_, child) => ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: _shineShader,
                child: child,
              ),
              child: AppText(
                name,
                fontSize: 25.sp,
                height: 1.2,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimaryColor.themeColor,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        else
          AppText(
            LocaleKeys.home_welcome.tr(),
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimaryColor.themeColor,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }
}
