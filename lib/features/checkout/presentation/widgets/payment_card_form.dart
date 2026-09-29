import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/card_input_formatters.dart';
import '../../../../core/utils/locale_keys.dart';
import 'checkout_section_card.dart';
import 'labeled_text_field.dart';

class PaymentCardForm extends StatelessWidget {
  const PaymentCardForm({
    super.key,
    required this.cardNumberController,
    required this.expiryController,
    required this.cvvController,
    required this.onChanged,
  });

  final TextEditingController cardNumberController;
  final TextEditingController expiryController;
  final TextEditingController cvvController;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckoutSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LabeledTextField(
            label: LocaleKeys.store_card_number.tr(),
            hint: LocaleKeys.store_card_number_hint.tr(),
            controller: cardNumberController,
            keyboardType: TextInputType.number,
            inputFormatters: [CardNumberInputFormatter()],
            onChanged: onChanged,
          ),
          14.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: LabeledTextField(
                  label: LocaleKeys.store_expiry_date.tr(),
                  hint: LocaleKeys.store_expiry_hint.tr(),
                  controller: expiryController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [ExpiryDateInputFormatter()],
                  onChanged: onChanged,
                ),
              ),
              12.width,
              Expanded(
                child: LabeledTextField(
                  label: LocaleKeys.store_cvv.tr(),
                  hint: LocaleKeys.store_cvv_hint.tr(),
                  controller: cvvController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
