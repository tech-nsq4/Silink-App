import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/locale_keys.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/app_text_field.dart';
import '../models/product.dart';
import '../widgets/product_grid_card.dart';
import '../widgets/section_header.dart';
import '../widgets/special_offer_card.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  String _searchQuery = '';

  final Product _specialOffer = const Product(
    id: 'titanium-card',
    name: 'بطاقة معدنية تيتانيوم',
    price: 289,
    oldPrice: 349,
    rating: 4.9,
    reviewCount: 187,
    customizable: true,
    badge: ProductBadge.specialOffer,
  );

  final List<Product> _featuredProducts = const [
    Product(
      id: 'titanium-card-2',
      name: 'بطاقة معدنية تيتانيوم',
      price: 289,
      badge: ProductBadge.specialOffer,
      customizable: true,
    ),
    Product(
      id: 'nfc-premium',
      name: 'بطاقة NFC بريميوم',
      price: 149,
      badge: ProductBadge.bestSeller,
      customizable: true,
    ),
    Product(
      id: 'nfc-medal',
      name: 'ميدالية NFC فاخرة',
      price: 199,
    ),
    Product(
      id: 'nfc-sticker',
      name: 'ملصق NFC للهاتف',
      price: 49,
    ),
  ];

  List<Product> get _filteredProducts {
    if (_searchQuery.trim().isEmpty) return _featuredProducts;
    return _featuredProducts
        .where((p) => p.name.contains(_searchQuery.trim()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // StatsAppBar(
          //   title: LocaleKeys.store_title.tr(),
          //   child: InkWell(
          //     onTap: () {},
          //     borderRadius: BorderRadius.circular(20.r),
          //     child: Container(
          //       height: 36.h,
          //       width: 36.w,
          //       decoration: BoxDecoration(
          //         color:
          //             AppColors.successColor.themeColor.withValues(alpha: 0.10),
          //         shape: BoxShape.circle,
          //       ),
          //       child: IconButton(
          //         onPressed: () {},
          //         icon: Badge.count(
          //           count: 3,
          //           backgroundColor: Colors.red,
          //           textStyle: TextStyle(
          //             fontSize: 10.sp,
          //             fontWeight: FontWeight.w700,
          //           ),
          //           offset: const Offset(-9, -10),
          //           alignment: Alignment.topLeft,
          //           child: SvgPicture.asset(AppImages.iconsCart),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: AppText(
                      '${LocaleKeys.nav_home.tr()} / ${LocaleKeys.store_title.tr()}',
                      fontSize: 12.sp,
                      color: AppColors.textSecondaryColor.themeColor,
                    ),
                  ),
                  12.height,
                  CustomTextField(
                    hint: 'ابحث عن منتج...',
                    onChanged: (value) => setState(() => _searchQuery = value),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 20.sp,
                      color: AppColors.textSecondaryColor.themeColor,
                    ),
                  ),
                  12.height,
                  // CategoryFilterChips(
                  //   categories: _categories,
                  //   selectedIndex: _selectedCategory,
                  //   onSelected: (i) => setState(() => _selectedCategory = i),
                  // ),
                  16.height,
                  SectionHeader(
                      title: LocaleKeys.store_offers.tr(), onViewAll: () {}),
                  12.height,
                  SpecialOfferCard(product: _specialOffer),
                  16.height,
                  SectionHeader(title: 'المنتجات المميزة', onViewAll: () {}),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredProducts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12.h,
                      crossAxisSpacing: 12.w,
                      childAspectRatio: 0.72,
                    ),
                    itemBuilder: (context, index) =>
                        ProductGridCard(product: _filteredProducts[index]),
                  ),
                  SizedBox(height: 16.h),
                  DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      dashPattern: [10, 5],
                      strokeWidth: 2,
                      radius: const Radius.circular(16),
                      color: AppColors.borderColor.themeColor,
                    ),
                    child: CustomButton(
                      onTap: () {},
                      title: 'عرض جميع المنتجات (8)',
                      color: AppColors.backgroundColor.themeColor,
                      textColor: AppColors.textPrimaryColor.themeColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

