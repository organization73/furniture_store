import 'package:cached_network_image/cached_network_image.dart';
import 'package:decordash/features/home/model/review_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordash/common/widgets/products/rattings/rating_indicator.dart';
import 'package:decordash/features/product/model/product_model.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({
    super.key,
    required this.review,
  });
  final Review review;

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
                  imageUrl: review.reviewerImage,
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
                  Text(review.reviewerName,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomRatingBarIndicator(
                    rating: review.rating.toDouble(),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    review.comment,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
