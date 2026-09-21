import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../logic/cart_cubit.dart';

class CartBadgeButton extends StatelessWidget {
  const CartBadgeButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final badge = BlocBuilder<CartCubit, CartState>(
      builder: (context, state) => Badge.count(
        count: state.itemsCount,
        isLabelVisible: state.itemsCount > 0,
        backgroundColor: AppColors.errorColor.themeColor,
        textStyle: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w700),
        offset: const Offset(-9, -10),
        alignment: Alignment.topLeft,
        child: SvgPicture.asset(AppImages.iconsCart),
      ),
    );

    return Container(
      height: 36.h,
      width: 36.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.successColor.themeColor.withValues(alpha: 0.10),
        shape: BoxShape.circle,
      ),
      child: onTap == null ? badge : IconButton(onPressed: onTap, icon: badge),
    );
  }
}
