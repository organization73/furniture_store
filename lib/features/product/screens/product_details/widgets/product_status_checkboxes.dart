import 'package:flutter/material.dart';
import 'package:decordash/features/product/model/product_model.dart';

class ProductStatsCheckboxes extends StatelessWidget {
  final ProductModel product;

  const ProductStatsCheckboxes({super.key, required this.product});

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
                product.productDetails.productStats.delivery
                    ? Icons.check
                    : Icons.clear,
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
                product.productDetails.productStats.negotiable
                    ? Icons.check
                    : Icons.clear,
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
                product.productDetails.productStats.modifiable
                    ? Icons.check
                    : Icons.clear,
                color: Colors.white,
              )),
        )
      ],
    );
  }
}
