import 'package:Silink/app/router/navigation_services.dart';
import 'package:Silink/app/router/routes.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/screen_header_bar.dart';
import 'package:Silink/features/my_card/models/my_card_model.dart';
import 'package:Silink/features/my_card/widgets/card_more_sheet.dart';
import 'package:Silink/features/my_card/widgets/create_new_card_button.dart';
import 'package:Silink/features/my_card/widgets/my_card_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';

class MyCardsScreen extends StatefulWidget {
  const MyCardsScreen({super.key});

  @override
  State<MyCardsScreen> createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends State<MyCardsScreen> {
  // استبدلها بداتا حقيقية من الـ API/repository (MyCardModel.fromJson)
  final List<MyCardModel> _cards = [
    MyCardModel(
      id: '1',
      name: 'حازم العتيبي',
      role: 'مدير تطوير الأعمال',
      company: 'شركة الرؤية التقنية',
      initials: 'ها',
      avatarColorValue: 0xFF17B78F,
      category: CardCategory.business,
      categoryColorValue: 0xFF2F6FED,
      status: CardLifecycleStatus.active,
      isPublished: true,
      hasNfc: true,
      visitsCount: 36,
      clientsCount: 0,
      lastUpdated: DateTime(2024, 12, 1),
      createdAt: DateTime(2024, 7, 1),
      link: 'silink.nsq4.sa/hazem1',
    ),
    MyCardModel(
      id: '2',
      name: 'حازم العتيبي',
      role: 'مطور تطبيقات',
      company: '',
      initials: 'ها',
      avatarColorValue: 0xFF8B5CF6,
      category: CardCategory.personal,
      categoryColorValue: 0xFF8B5CF6,
      status: CardLifecycleStatus.draft,
      isPublished: false,
      visitsCount: 36,
      clientsCount: 0,
      lastUpdated: DateTime(2024, 11, 15),
      createdAt: DateTime(2024, 8, 1),
      link: 'silink.nsq4.sa/hazem2',
    ),
    MyCardModel(
      id: '3',
      name: 'حازم استشاري',
      role: 'مستشار نفسي مستقل',
      company: '',
      initials: 'ها',
      avatarColorValue: 0xFF17B78F,
      category: CardCategory.freelancer,
      categoryColorValue: 0xFF2F6FED,
      status: CardLifecycleStatus.paused,
      isPublished: true,
      visitsCount: 0,
      clientsCount: 0,
      lastUpdated: DateTime(2024, 1, 1),
      createdAt: DateTime(2024, 1, 1),
      link: 'silink.nsq4.sa/hazem3',
    ),
  ];

  void _onMore(MyCardModel card) {
    showCardMoreSheet(
      context,
      cardName: card.name,
      isPaused: card.status == CardLifecycleStatus.paused,
      onDuplicate: () {},
      onRename: () {},
      onTogglePause: () {},
      onDelete: () {},
    );
  }

  void _onQr(MyCardModel card) {
    // NavigationService.push(Routes.qrCodeScreen, arguments: {'data': ...});
  }

  void _onPreview(MyCardModel card) {
    // NavigationService.push(Routes.publicProfilePreviewScreen, arguments: {'data': ...});
  }

  void _onEdit(MyCardModel card) {
    // NavigationService.push(Routes.profileCompletionScreen);
  }

  void _onOpenDetails(MyCardModel card) {
    NavigationService.push(
      Routes.myCardDetailsScreen,
      arguments: {'card': card},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ScreenHeaderBar(
            title: LocaleKeys.nav_files.tr(),
            showBack: false,
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              itemCount: _cards.length + 1,
              separatorBuilder: (_, __) => 12.height,
              itemBuilder: (context, index) {
                if (index == _cards.length) {
                  return CreateNewCardButton(onTap: () {});
                }
                final card = _cards[index];
                return MyCardTile(
                  card: card,
                  onTap: () => _onOpenDetails(card),
                  onMoreTap: () => _onMore(card),
                  onQrTap: () => _onQr(card),
                  onPreviewTap: () => _onPreview(card),
                  onEditTap: () => _onEdit(card),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}