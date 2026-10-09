import 'package:equatable/equatable.dart';

import '../../../../core/utils/locale_keys.dart';

class OnboardingSlide extends Equatable {
  const OnboardingSlide({
    required this.tagKey,
    required this.titleKey,
    required this.bodyKey,
  });

  final String tagKey;
  final String titleKey;
  final String bodyKey;

  static const List<OnboardingSlide> slides = [
    OnboardingSlide(
      tagKey: LocaleKeys.onboarding_identityTag,
      titleKey: LocaleKeys.onboarding_identityTitle,
      bodyKey: LocaleKeys.onboarding_identityBody,
    ),
    OnboardingSlide(
      tagKey: LocaleKeys.onboarding_meetingsTag,
      titleKey: LocaleKeys.onboarding_meetingsTitle,
      bodyKey: LocaleKeys.onboarding_meetingsBody,
    ),
    OnboardingSlide(
      tagKey: LocaleKeys.onboarding_chancesTag,
      titleKey: LocaleKeys.onboarding_chancesTitle,
      bodyKey: LocaleKeys.onboarding_chancesBody,
    ),
  ];

  @override
  List<Object?> get props => [tagKey, titleKey, bodyKey];
}
