import 'package:decordashapp/common/widgets/images/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/features/home/model/category_model.dart';

class VerticalCategory extends StatelessWidget {
  const VerticalCategory(
      {super.key, required this.onTap, required this.category});
  final VoidCallback onTap;
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
                child: RoundedImage(
              imageUrl: category.image,
              isNetworkImage: true,
              applyImageRaduis: false,
              fit: BoxFit.cover,
            )),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(category.name,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
            ),
          ],
        ));
  }
}
