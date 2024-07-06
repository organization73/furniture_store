import 'package:decordash/features/product/screens/add_product/controllers/add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:fast_color_picker/fast_color_picker.dart';

typedef OnColorSelectedCallback = void Function(Color selectedColor);

class ColorSelection extends StatefulWidget {
  final OnColorSelectedCallback onColorSelected;

  const ColorSelection({super.key, required this.onColorSelected});

  @override
  ColorSelectionState createState() => ColorSelectionState();
}

class ColorSelectionState extends State<ColorSelection> {
  Color? _color = AddProductController.instance.color;

  @override
  Widget build(BuildContext context) {
    return FastColorPicker(
      selectedColor: _color??Colors.white,  
      onColorSelected: (color) {
        setState(() {
          _color = color;
        });
        widget.onColorSelected(color);
      },
    );
  }
}
