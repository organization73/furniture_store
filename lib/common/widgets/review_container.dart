import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/widgets/ratings_widget.dart';
import 'package:furniture_store/data/repositories/product/product.dart';

class ReviewContainer extends StatelessWidget {
  final Review review;

  const ReviewContainer({
    super.key,
    required this.review,
    this.profileImgUrl,
  });

  final String? profileImgUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
            radius: 25,
            child: CachedNetworkImage(
              imageUrl: profileImgUrl ?? "https://picsum.photos/id/1062/80/80",
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(),
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
              RatingWidget(
                rating: (4).toInt(),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                review.comment,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 8.h),
              Text(review.timestamp,
                  style: Theme.of(context).textTheme.bodySmall)
            ],
          ),
        ),
      ],
    );
  }
}
