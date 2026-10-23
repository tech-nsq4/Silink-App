import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/convert_helper.dart';
import '../../../../core/widgets/digital_card_preview.dart';
import '../../data/models/portfolio_model.dart';

class PortfolioCardPreview extends StatelessWidget {
  const PortfolioCardPreview({super.key, required this.portfolio});

  final PortfolioModel portfolio;

  String _initials(String name) => name
      .trim()
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .take(2)
      .map((word) => word.characters.first)
      .join();

  @override
  Widget build(BuildContext context) {
    final card = portfolio.card;
    final basic = card?.basic;
    final appearance = card?.appearance;
    final name = basic?.fullName.trim().isNotEmpty == true
        ? basic!.fullName
        : portfolio.displayName;
    final font = appearance?.fontFamily ?? '';
    return DigitalCardPreview(
      name: name,
      title: basic?.jobTitle ?? portfolio.jobTitle,
      company: basic?.company ?? portfolio.company,
      initials: _initials(name),
      photoUrl: basic?.photoUrl ?? portfolio.photoUrl,
      template:
          (card?.templateSlug.isNotEmpty ?? false) ? card!.templateSlug : 'pro',
      accent: ConvertHelper.hexToColor(
        appearance?.primaryColor ?? '',
        fallback: AppColors.accentTeal.themeColor,
      ),
      buttonRadius:
          DigitalCardPreview.shapeRadii[appearance?.buttonShape] ?? 12,
      fontFamily: font.isEmpty ? null : font,
    );
  }
}
