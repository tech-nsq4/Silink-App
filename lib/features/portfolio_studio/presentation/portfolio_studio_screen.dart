import 'package:flutter/material.dart';

import '../../../app/router/routes.dart';
import '../../../core/di/injection.dart';
import '../../card_studio/data/models/studio_draft.dart';
import '../../card_studio/logic/card_studio_cubit.dart';
import '../../card_studio/presentation/card_studio_screen.dart';
import '../data/portfolio_studio_repo.dart';

class PortfolioStudioScreen extends StatefulWidget {
  const PortfolioStudioScreen({super.key, this.portfolioId, this.initialDraft});

  final String? portfolioId;
  final StudioDraft? initialDraft;

  @override
  State<PortfolioStudioScreen> createState() => _PortfolioStudioScreenState();
}

class _PortfolioStudioScreenState extends State<PortfolioStudioScreen> {
  late final PortfolioStudioRepo _repo =
      getIt<PortfolioStudioRepo>(param1: widget.portfolioId);
  late final CardStudioCubit _cubit = CardStudioCubit(_repo);

  void _openCard() {
    if (widget.portfolioId != null) {
      Navigator.of(context).pop(true);
      return;
    }
    Navigator.of(context).pushReplacementNamed(
      Routes.profileCardScreen,
      arguments: {'fromStudio': true, 'portfolioId': _repo.portfolioId},
    );
  }

  @override
  Widget build(BuildContext context) {
    return CardStudioScreen(
      remote: widget.portfolioId != null,
      initialDraft: widget.initialDraft,
      portfolioMode: true,
      cubit: _cubit,
      onFinished: _openCard,
    );
  }
}
