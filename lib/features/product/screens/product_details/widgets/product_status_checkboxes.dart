import 'package:flutter/material.dart';
import 'package:furniture_store/data/repositories/product/product.dart';

class ProductStatsCheckboxes extends StatelessWidget {
  final ProductStats productStats;

  const ProductStatsCheckboxes({super.key, required this.productStats});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            'Delivery',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          leading: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Icon(
                productStats.delivery ? Icons.check : Icons.clear,
                color: Colors.white,
              )),
        ),
        ListTile(
          title: Text(
            'Negotioable',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          leading: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Icon(
                productStats.negotiable ? Icons.check : Icons.clear,
                color: Colors.white,
              )),
        ),
        ListTile(
          title: Text(
            'Modifiable',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          leading: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Icon(
                productStats.modifiable ? Icons.check : Icons.clear,
                color: Colors.white,
              )),
        )
      ],
    );
  }
}
