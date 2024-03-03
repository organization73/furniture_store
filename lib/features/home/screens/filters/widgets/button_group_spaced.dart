import 'package:flutter/material.dart';
import 'package:furniture_store/utils/constants/colors.dart';

class ButtonGroupSpaced extends StatefulWidget {
  final List<String> items;

  const ButtonGroupSpaced({super.key, required this.items});

  @override
  ButtonGroupSpacedState createState() => ButtonGroupSpacedState();
}

class ButtonGroupSpacedState extends State<ButtonGroupSpaced> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.items.map((item) {
        int currentIndex = widget.items.indexOf(item);
        return GestureDetector(
          onTap: () {
            setState(() {
              activeIndex = currentIndex;
            });
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
            margin: const EdgeInsets.only(right: 8.0, bottom: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: activeIndex == currentIndex
                    ? TColors.primary
                    : const Color.fromRGBO(163, 167, 168, 1),
              ),
            ),
            child: Text(item),
          ),
        );
      }).toList(),
    );
  }
}
