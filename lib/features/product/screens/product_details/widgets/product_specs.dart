import 'package:flutter/material.dart';

class ProductSpecs extends StatelessWidget {
  Map<String, String> productSpecs;

  ProductSpecs({super.key, required this.productSpecs});

  @override
  Widget build(BuildContext context) {
    productSpecs.remove('ablakash');
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
