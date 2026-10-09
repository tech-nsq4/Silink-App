import 'package:Silink/features/clients/presentation/clients_screen.dart';
import 'package:Silink/features/my_card/presentation/my_cards_screen.dart';
import 'package:Silink/features/profile_completion/data/models/profile_completion_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../account/widgets/account_tab_body.dart';
import '../../home/presentation/home_screen.dart';
import '../../profile/logic/profile_cubit.dart';
import 'widgets/layout_nav_bar.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({
    super.key,
    this.currentPage = 0,
    this.cardData,
  });

  final int currentPage;
  final ProfileCompletionData? cardData;

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentPage;
    context.read<ProfileCubit>().registerFcmToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              onOpenClients: () => setState(() => _currentIndex = 2),
            ),
            const MyCardsScreen(),
            const ClientsScreen(),
            const AccountTabBody(),
          ],
        ),
      ),
      bottomNavigationBar: LayoutNavBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}
