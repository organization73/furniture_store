import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BuildDropDown extends StatefulWidget {
  final String? title;
  final String hintText;
  final List<String> items;
  final void Function(String?) onItemSelected;

  const BuildDropDown({
    super.key,
    required this.items,
    required this.onItemSelected,
    this.title,
    required this.hintText,
  });

  @override
  State<BuildDropDown> createState() => _SimpleDropDownState();
}

class _SimpleDropDownState extends State<BuildDropDown> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) _title(widget.title!),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _dropDown(
                    items: widget.items,
                    onItemSelected: widget.onItemSelected,
                    underline: Container(),
                    style: Theme.of(context).textTheme.bodyMedium,
                    dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                    iconEnabledColor:
                        Theme.of(context).colorScheme.onSecondaryContainer,
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    hintText: widget.hintText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _title(String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        val,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }

  Widget _dropDown({
    required List<String> items,
    required void Function(String?) onItemSelected,
    required String hintText,
    Widget? underline,
    TextStyle? style,
    TextStyle? hintStyle,
    Color? dropdownColor,
    Color? iconEnabledColor,
  }) =>
      DropdownButton<String>(
        isExpanded: true,
        value: _selectedItem,
        underline: underline,
        icon: null,
        dropdownColor: dropdownColor,
        style: style,
        iconEnabledColor: iconEnabledColor,
        onChanged: (String? newValue) {
          setState(() {
            _selectedItem = newValue;
          });
          onItemSelected(newValue);
        },
        hint: Text(hintText, style: hintStyle),
        items: items
            .map(
              (item) =>
                  DropdownMenuItem<String>(value: item, child: Text(item)),
            )
            .toList(),
      );
}
