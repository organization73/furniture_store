import 'package:decordash/common/widgets/chips/custom_choice_chip.dart';
import 'package:decordash/features/product/screens/add_product/controllers/add_product_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

typedef OnOptionSelected = void Function(int? selectedOption);

class ConditionSelection extends StatefulWidget {
  OnOptionSelected onOptionSelected;

  ConditionSelection({super.key, required this.onOptionSelected});

  @override
  State<ConditionSelection> createState() => _ConditionSelectionState();
}

class _ConditionSelectionState extends State<ConditionSelection> {
  int _value= AddProductController.instance.condition; // Set to null initially

  @override
  Widget build(BuildContext context) {
    final availableChoices = [
      'newCond'.tr,
      'used'.tr,
    ];
    return Wrap(
      spacing: 20,
      runSpacing: 10,
      children: List.generate(
        availableChoices.length,
        (int index) {
          return CustomChoiceChip(
            text: availableChoices[index],
            selected: _value == index,
            onSelected: (bool selected) {
              if (selected && _value != index) {
                // Only change state if a new option is selected
                setState(() {
                  _value = index;
                });
                // Call the callback function with the selected option
                widget.onOptionSelected(_value);
              } else if (!selected && _value == index) {
                // Deselect the current option
                setState(() {
                  _value = 0;
                });
                // Call the callback function with null to indicate deselection
                widget.onOptionSelected(null);
              }
            },
          );
        },
      ).toList(),
    );
  }
}
