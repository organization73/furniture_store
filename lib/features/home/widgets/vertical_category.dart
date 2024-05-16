import 'package:decordash/common/widgets/images/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordash/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:decordash/features/home/model/category_model.dart';

class VerticalCategory extends StatelessWidget {
  const VerticalCategory(
      {super.key, required this.onTap, required this.category});
  final VoidCallback onTap;
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: RoundedContainer(
          gradient: true,
          width: 110.w,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          raduis: 8.r,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                  child: RoundedImage(
                imageUrl: category.image,
                isNetworkImage: true,
                applyImageRaduis: false,
              )),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0).r,
                  child: Text(category.name,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
              ),
            ],
          ),
        ));
  }
}
