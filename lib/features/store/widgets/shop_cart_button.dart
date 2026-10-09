import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/router/navigation_services.dart';
import '../../../app/router/routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_text.dart';
import '../../cart/logic/cart_cubit.dart';

class ShopCartButton extends StatelessWidget {
  const ShopCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = 35.w;
    return BlocSelector<CartCubit, CartState, int>(
      selector: (state) => state.itemsCount,
      builder: (context, count) => InkWell(
        onTap: () => NavigationService.push(Routes.cartScreen),
        customBorder: const CircleBorder(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.white.themeColor,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.topIconBorder.themeColor),
              ),
              child: Icon(Icons.shopping_bag_outlined,
                  size: 18.sp, color: AppColors.topIconColor.themeColor),
            ),
            if (count > 0)
              PositionedDirectional(
                top: -4.h,
                end: -4.w,
                child: Container(
                  constraints: BoxConstraints(minWidth: 16.w),
                  height: 16.w,
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.accentTeal.themeColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: AppText(
                    '$count',
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white.light,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
