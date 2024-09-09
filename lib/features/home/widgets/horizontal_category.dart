import 'package:decordashapp/common/widgets/images/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordashapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:decordashapp/features/home/model/category_model.dart';

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
          gradient: true,
          width: 115.w,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          raduis: 8.r,
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.bottomRight,
                  child: RoundedImage(
                    width: 50.r,
                    height: 50.r,
                    imageUrl: category.image,
                    isNetworkImage: true,
                    fit: BoxFit.cover,
                    applyImageRaduis: false,
                    padding: const EdgeInsets.all(5).r,
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
