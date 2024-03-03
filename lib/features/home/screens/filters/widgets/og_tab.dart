import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/features/home/screens/filters/widgets/og_tab_item.dart';
import 'package:furniture_store/utils/constants/colors.dart';

class OgTab extends StatefulWidget {
  final List<OgTabItem> items;
  const OgTab({super.key, required this.items});

  @override
  OgTabState createState() => OgTabState();
}

class OgTabState extends State<OgTab> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        widget.items.length,
        (index) => Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                activeIndex = index;
              });
            },
            child: Container(
              height: 47.h,
              decoration: BoxDecoration(
                color: activeIndex == index
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                    : Colors.transparent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(index == 0 ? 5 : 0),
                  bottomLeft: Radius.circular(index == 0 ? 5 : 0),
                  topRight: Radius.circular(
                      index == (widget.items.length - 1) ? 5 : 0),
                  bottomRight: Radius.circular(
                      index == (widget.items.length - 1) ? 5 : 0),
                ),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
              ),
              child: Center(
                child: Text(
                  widget.items[index].title,
                  style: TextStyle(
                    color: activeIndex == index
                        ? TColors.black
                        : const Color.fromRGBO(154, 154, 154, 1),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
