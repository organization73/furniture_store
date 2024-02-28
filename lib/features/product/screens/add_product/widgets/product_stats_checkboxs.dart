import 'package:flutter/material.dart';

class ProductStatsCheckboxes extends StatefulWidget {
  final Map<String, bool> productStats;

  const ProductStatsCheckboxes({super.key, required this.productStats});

  @override
  ProductStatsCheckboxesState createState() => ProductStatsCheckboxesState();
}

class ProductStatsCheckboxesState extends State<ProductStatsCheckboxes> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.productStats.entries.map((entry) {
        return CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title:
              Text(entry.key, style: Theme.of(context).textTheme.titleMedium),
          value: entry.value,
          onChanged: (newValue) {
            setState(() {
              widget.productStats[entry.key] = newValue!;
            });
          },
        );
      }).toList(),
    );
  }
}
