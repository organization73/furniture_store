import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/widgets/products/rattings/rating_indicator.dart';
import 'package:furniture_store/data/repositories/product/product.dart';
import 'package:furniture_store/features/home/model/product_model.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({
    super.key,
    required this.product,
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
                radius: 25,
                child: CachedNetworkImage(
                  imageUrl: product.rates[0].reviewerImage,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.account_circle),
                )),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.rates[0].reviewerName,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomRatingBarIndicator(
                    rating: product.rates[0].rating.toDouble(),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    product.rates[0].comment,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 8.h),
                  Text(product.rates[0].date.toString(),
                      style: Theme.of(context).textTheme.bodySmall)
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
