import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberInput extends StatelessWidget {
  const PhoneNumberInput({
    super.key,
    this.onChange,
  });

  final ValueChanged<PhoneNumber>? onChange;

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      textStyle: const TextStyle(fontSize: TSizes.fontSizeSm),
      onInputChanged: onChange,
      inputDecoration: InputDecoration(
        border: const OutlineInputBorder().copyWith(
          borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
        ),
        labelText: 'phoneNo'.tr,
      ),
      keyboardType: const TextInputType.numberWithOptions(
        signed: true,
        decimal: false,
      ),
      selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          setSelectorButtonAsPrefixIcon: true,
          leadingPadding: 15,
          useEmoji: true),
      initialValue: PhoneNumber(
        isoCode: 'EG',
      ),
      formatInput: false,
      countries: const ["EG"],
    );
  }
}
