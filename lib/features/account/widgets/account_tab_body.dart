import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../profile/logic/profile_cubit.dart';
import '../presentation/account_guest_screen.dart';
import '../presentation/account_screen.dart';

class AccountTabBody extends StatelessWidget {
  const AccountTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileCubit, ProfileState, bool>(
      selector: (state) => state is ProfileSuccess,
      builder: (context, isLoggedIn) => isLoggedIn
          ? const AccountScreen(showBack: false)
          : const AccountGuestScreen(showBack: false),
    );
  }
}
