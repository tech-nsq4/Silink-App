import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/network_exceptions.dart';
import '../../../core/utils/app_overlay.dart';
import '../../../core/utils/locale_keys.dart';
import '../data/contact_repo.dart';
import '../data/models/contact_message.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit(this._repo) : super(const ContactInitial());

  final ContactRepo _repo;

  Future<void> send(ContactMessage message) async {
    if (state is ContactSending) return;
    emit(const ContactSending());
    try {
      await _repo.send(message);
      if (isClosed) return;
      AppOverlay.showSuccess(LocaleKeys.help_sent.tr());
      emit(const ContactSent());
    } catch (e) {
      if (isClosed) return;
      final msg = e is NetworkException ? e.message : e.toString();
      AppOverlay.showError(msg);
      emit(ContactError(msg));
    }
  }
}
