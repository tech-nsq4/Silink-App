import 'package:Silink/core/utils/app_colors.dart';
import 'package:Silink/core/utils/locale_keys.dart';
import 'package:Silink/core/widgets/app_button.dart';
import 'package:Silink/core/widgets/app_text.dart';
import 'package:Silink/core/widgets/app_text_field.dart';
import 'package:Silink/features/profile_completion/presentation/widgets/field_label.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductEditResult {
  final String name;
  final String price;

  ProductEditResult({required this.name, required this.price});
}

Future<ProductEditResult?> showProductEditSheet(
  BuildContext context, {
  required String title,
  String initialName = '',
  String initialPrice = '',
}) {
  final nameCtrl = TextEditingController(text: initialName);
  final priceCtrl = TextEditingController(text: initialPrice);

  return showModalBottomSheet<ProductEditResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(19.w, 20.h, 19.w, 20.h),
          decoration: BoxDecoration(
            color: AppColors.white.themeColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(title, fontSize: 16.sp, fontWeight: FontWeight.w700),
              SizedBox(height: 16.h),
              FieldLabel(
                text: LocaleKeys.products_nameLabel.tr(),
                required: true,
              ),
              CustomTextField(
                controller: nameCtrl,
                hint: LocaleKeys.products_nameHint.tr(),
              ),
              SizedBox(height: 12.h),
              FieldLabel(
                text: LocaleKeys.products_priceLabel.tr(),
                required: true,
              ),
              CustomTextField(
                controller: priceCtrl,
                hint: LocaleKeys.products_priceHint.tr(),
              ),
              SizedBox(height: 16.h),
              CustomButton(
                title: LocaleKeys.common_confirm.tr(),
                onTap: () {
                  final name = nameCtrl.text.trim();
                  final price = priceCtrl.text.trim();
                  if (name.isEmpty || price.isEmpty) return;
                  Navigator.pop(
                    sheetContext,
                    ProductEditResult(name: name, price: price),
                  );
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
