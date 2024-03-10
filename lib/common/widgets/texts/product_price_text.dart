import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPriceText extends StatelessWidget {
  const ProductPriceText({
    super.key,
    this.currencySign,
    required this.price,
    this.maxLines = 1,
    this.isLarge = false,
    this.lineThrough = false,
  });

  final String? currencySign, price;
  final int maxLines;
  final bool isLarge;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    final localizedcurrencySign = currencySign?.tr ?? 'currencySign'.tr;

    return Text(
      '$price $localizedcurrencySign',
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: isLarge
          ? Theme.of(context).textTheme.headlineMedium!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null,
              color: lineThrough ? Colors.grey : null)
          : Theme.of(context).textTheme.titleLarge!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null,
              color: lineThrough ? Colors.grey : null),
    );
  }
}
