import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/router/navigation_services.dart';
import '../../../../app/router/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../logic/cart_cubit.dart';

class CartBadgeButton extends StatelessWidget {
  const CartBadgeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartCubit, CartState, int>(
      selector: (state) => state.itemsCount,
      builder: (context, count) {
        return InkWell(
          onTap: () => NavigationService.push(Routes.cartScreen),
          customBorder: const CircleBorder(),
          child: Container(
            height: 38.w,
            width: 38.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.successColor.themeColor.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: Badge.count(
              count: count,
              isLabelVisible: count > 0,
              backgroundColor: AppColors.saleRed.themeColor,
              textColor: AppColors.overlayOnDark.themeColor,
              alignment: AlignmentDirectional.topEnd,
              offset: const Offset(8, -10),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 20.sp,
                color: AppColors.successColor.themeColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
