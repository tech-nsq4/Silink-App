import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:Silink/core/utils/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/flow_footer.dart';
import '../../../core/widgets/flow_page_title.dart';
import '../../../core/widgets/flow_top_bar.dart';
import 'widgets/new_card_art.dart';
import 'widgets/new_card_explainer.dart';
import 'widgets/new_card_method_card.dart';

class NewCardStartScreen extends StatefulWidget {
  const NewCardStartScreen({super.key, required this.usageIntent});

  final String usageIntent;

  @override
  State<NewCardStartScreen> createState() => _NewCardStartScreenState();
}

class _NewCardStartScreenState extends State<NewCardStartScreen> {
  bool _withAssistant = true;

  void _start() => NavigationService.push(
        _withAssistant
            ? Routes.cardAssistantScreen
            : (kIsGuest
                ? Routes.cardStudioScreen
                : Routes.portfolioStudioScreen),
        arguments: {'usageIntent': widget.usageIntent},
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor.themeColor,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: FlowTopBar(
              eyebrow: LocaleKeys.newCard_eyebrow.tr(),
              title: LocaleKeys.newCard_title.tr(),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(22.w, 12.h, 22.w, 25.h),
              children: [
                FlowPageTitle(
                  eyebrow: LocaleKeys.newCard_pageEyebrow.tr(),
                  title: LocaleKeys.newCard_pageTitle.tr(),
                  subtitle: LocaleKeys.newCard_pageSubtitle.tr(),
                ),
                const NewCardArt(),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: NewCardMethodCard(
                          icon: Icons.auto_awesome_outlined,
                          title: LocaleKeys.newCard_assistantTitle.tr(),
                          subtitle: LocaleKeys.newCard_assistantSubtitle.tr(),
                          selected: _withAssistant,
                          onTap: () => setState(() => _withAssistant = true),
                        ),
                      ),
                      10.width,
                      Expanded(
                        child: NewCardMethodCard(
                          icon: Icons.space_dashboard_outlined,
                          title: LocaleKeys.newCard_manualTitle.tr(),
                          subtitle: LocaleKeys.newCard_manualSubtitle.tr(),
                          selected: !_withAssistant,
                          onTap: () => setState(() => _withAssistant = false),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _withAssistant
                      ? NewCardExplainer(
                          key: const ValueKey('assistant'),
                          title:
                              LocaleKeys.newCard_assistantExplainerTitle.tr(),
                          body: LocaleKeys.newCard_assistantExplainerBody.tr(),
                          steps: [
                            LocaleKeys.newCard_assistantStep1.tr(),
                            LocaleKeys.newCard_assistantStep2.tr(),
                            LocaleKeys.newCard_assistantStep3.tr(),
                          ],
                        )
                      : NewCardExplainer(
                          key: const ValueKey('manual'),
                          title: LocaleKeys.newCard_manualExplainerTitle.tr(),
                          body: LocaleKeys.newCard_manualExplainerBody.tr(),
                        ),
                ),
              ],
            ),
          ),
          FlowFooter(
            title: _withAssistant
                ? LocaleKeys.newCard_assistantCta.tr()
                : LocaleKeys.newCard_manualCta.tr(),
            note: LocaleKeys.newCard_footerNote.tr(),
            onTap: _start,
          ),
        ],
      ),
    );
  }
}
