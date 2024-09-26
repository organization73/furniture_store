import 'package:flutter/material.dart';

class ProductSpecs extends StatelessWidget {
  final Map<String, String> productSpecs;

  const ProductSpecs({super.key, required this.productSpecs});

  @override
  Widget build(BuildContext context) {
    List<Widget> textWidgets = productSpecs.entries.map((entry) {
      return ListTile(
        title: Text(
          entry.key,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing:
            Text(entry.value, style: Theme.of(context).textTheme.labelSmall),
        selected: false,
      );
    }).toList();

    return Column(
      children: textWidgets,
    );
  }
}
