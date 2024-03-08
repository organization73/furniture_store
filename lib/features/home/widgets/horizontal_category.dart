import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:furniture_store/features/home/model/category_model.dart';
import 'package:furniture_store/utils/constants/colors.dart';

class HorizontalCategory extends StatelessWidget {
  const HorizontalCategory(
      {super.key, required this.onTap, required this.category});
  final VoidCallback onTap;
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: RoundedContainer(
          width: 125.w,
          hight: 56.h,
          backgroundColor: TColors.grey.withOpacity(0.7),
          raduis: 8,
          child: Stack(
            children: [
              Positioned(
                right: 5,
                bottom: 0,
                child: SizedBox(
                  width: 50.r,
                  height: 50.r,
                  child: CachedNetworkImage(
                    imageUrl: category.image,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    category.name,
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
