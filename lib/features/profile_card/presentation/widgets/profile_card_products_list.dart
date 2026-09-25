import 'package:Silink/core/extensions/extensions.dart';
import 'package:Silink/features/profile_card/data/models/profile_card_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'profile_card_dots.dart';
import 'profile_card_product_card.dart';

class ProfileCardProductsList extends StatefulWidget {
  const ProfileCardProductsList({
    super.key,
    required this.products,
    required this.primaryColor,
    required this.fontFamily,
    required this.onProductTap,
  });

  final List<ProfileCardProduct> products;
  final Color primaryColor;
  final String? fontFamily;
  final ValueChanged<ProfileCardProduct> onProductTap;

  @override
  State<ProfileCardProductsList> createState() =>
      _ProfileCardProductsListState();
}

class _ProfileCardProductsListState extends State<ProfileCardProductsList> {
  final ScrollController _controller = ScrollController();
  int _current = 0;

  double get _itemExtent => ProfileCardProductCard.width + 12.w;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    final position = _controller.position;
    final atEnd = position.pixels >= position.maxScrollExtent - 1;
    final index = atEnd
        ? widget.products.length - 1
        : (position.pixels / _itemExtent).round();
    final clamped = index.clamp(0, widget.products.length - 1);
    if (clamped != _current) setState(() => _current = clamped);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = widget.products;

    return Column(
      children: [
        SingleChildScrollView(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (int i = 0; i < products.length; i++) ...[
                  if (i > 0) SizedBox(width: 12.w),
                  ProfileCardProductCard(
                    product: products[i],
                    primaryColor: widget.primaryColor,
                    fontFamily: widget.fontFamily,
                    onTap: () => widget.onProductTap(products[i]),
                  ),
                ],
              ],
            ),
          ),
        ),
        if (products.length > 1) ...[
          14.height,
          ProfileCardDots(
            count: products.length,
            current: _current,
            activeColor: widget.primaryColor,
          ),
        ],
      ],
    );
  }
}
