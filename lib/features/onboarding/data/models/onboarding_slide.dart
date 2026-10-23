import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/locale_keys.dart';

class OnboardingSlide extends Equatable {
  const OnboardingSlide({
    required this.title,
    required this.body,
    this.tag = '',
    this.imageUrl,
  });

  final String tag;
  final String title;
  final String body;
  final String? imageUrl;

  bool get hasImage => (imageUrl ?? '').trim().isNotEmpty;

  factory OnboardingSlide.fromJson(Map<String, dynamic> json) =>
      OnboardingSlide(
        title: json['title'] as String? ?? '',
        body: json['content'] as String? ?? '',
        imageUrl: json['image'] as String?,
      );

  static List<OnboardingSlide> get local => [
        OnboardingSlide(
          tag: LocaleKeys.onboarding_identityTag.tr(),
          title: LocaleKeys.onboarding_identityTitle.tr(),
          body: LocaleKeys.onboarding_identityBody.tr(),
        ),
        OnboardingSlide(
          tag: LocaleKeys.onboarding_meetingsTag.tr(),
          title: LocaleKeys.onboarding_meetingsTitle.tr(),
          body: LocaleKeys.onboarding_meetingsBody.tr(),
        ),
        OnboardingSlide(
          tag: LocaleKeys.onboarding_chancesTag.tr(),
          title: LocaleKeys.onboarding_chancesTitle.tr(),
          body: LocaleKeys.onboarding_chancesBody.tr(),
        ),
      ];

  @override
  List<Object?> get props => [tag, title, body, imageUrl];
}
