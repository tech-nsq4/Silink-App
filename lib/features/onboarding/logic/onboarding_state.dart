part of 'onboarding_cubit.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

final class OnboardingLoading extends OnboardingState {
  const OnboardingLoading();
}

final class OnboardingReady extends OnboardingState {
  const OnboardingReady(this.slides);

  final List<OnboardingSlide> slides;

  @override
  List<Object?> get props => [slides];
}
