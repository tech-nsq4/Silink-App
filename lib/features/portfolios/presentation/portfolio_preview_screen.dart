import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/public_profile/public_profile_data.dart';
import '../../../core/widgets/public_profile/public_profile_view.dart';
import '../data/models/portfolio_model.dart';
import 'widgets/portfolio_actions.dart';

class PortfolioPreviewScreen extends StatelessWidget {
  const PortfolioPreviewScreen({super.key, required this.portfolio});

  final PortfolioModel portfolio;

  @override
  Widget build(BuildContext context) {
    final card = portfolio.card;
    final data = card?.toPublicProfile() ??
        PublicProfileData(
          name: portfolio.displayName,
          title: portfolio.jobTitle,
          company: portfolio.company,
          photoUrl: portfolio.photoUrl,
        );
    return Scaffold(
      backgroundColor: AppColors.backgroundColor.themeColor,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.paddingOf(context).top),
          Expanded(
            child: PublicProfileView(
              data: data,
              actions: PublicProfileActions(
                onClose: () => Navigator.of(context).maybePop(),
                onShare: () => PortfolioActions.share(portfolio),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
