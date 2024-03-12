import 'package:flutter/material.dart';
import 'package:decordash/utils/constants/enums.dart';

class BrandTitleText extends StatelessWidget {
  const BrandTitleText(
      {super.key,
      this.color,
      required this.title,
      this.maxLines = 1,
      this.textAlign = TextAlign.center,
      this.brandtextSize = TextSizes.small});
  final Color? color;
  final String title;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes brandtextSize;

  @override
  Widget build(BuildContext context) {
    return Text(title,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: brandtextSize == TextSizes.small
            ? Theme.of(context).textTheme.labelSmall!.apply(color: color)
            : brandtextSize == TextSizes.medium
                ? Theme.of(context).textTheme.bodyLarge!.apply(color: color)
                : brandtextSize == TextSizes.large
                    ? Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .apply(color: color)
                    : Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: color));
  }
}
