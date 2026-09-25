import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../core/utils/app_overlay.dart';
import '../data/models/profile_card_model.dart';
import '../data/profile_card_repo.dart';

part 'profile_card_state.dart';

class ProfileCardCubit extends Cubit<ProfileCardState> {
  ProfileCardCubit(this._repo) : super(const ProfileCardInitial());

  final ProfileCardRepo _repo;

  Future<void> getMyCard() async {
    emit(const ProfileCardLoading());
    try {
      final card = await _repo.getMyCard();
      emit(ProfileCardSuccess(card));
    } catch (e) {
      final msg = e is NetworkException ? e.message : e.toString();
      AppOverlay.showError(msg);
      emit(ProfileCardError(msg));
    }
  }
}
