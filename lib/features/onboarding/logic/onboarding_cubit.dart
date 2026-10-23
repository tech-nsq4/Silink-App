import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/onboarding_slide.dart';
import '../data/onboarding_repo.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._repo) : super(const OnboardingLoading());

  final OnboardingRepo _repo;

  Future<void> load() async {
    List<OnboardingSlide> slides;
    try {
      slides = await _repo.getSlides();
    } catch (_) {
      slides = const [];
    }
    if (isClosed) return;
    emit(OnboardingReady(slides.isEmpty ? OnboardingSlide.local : slides));
  }
}
