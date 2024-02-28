import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/widgets/gallery_card.dart';
import 'package:furniture_store/utils/constants/image_strings.dart';

class GalleryOwner {
  final String name;
  final String imagePath;

  GalleryOwner(this.name, this.imagePath);
}

final List<GalleryOwner> items = [
  GalleryOwner('Ahmed', TImages.user),
  GalleryOwner('Ali', TImages.user),
  GalleryOwner('Sameh', TImages.user),
  GalleryOwner('Khaled', TImages.user),
  GalleryOwner('Sayed', TImages.user),
  GalleryOwner('Mohamed', TImages.user),
  GalleryOwner('Medo', TImages.user),
];

class BuildGalleriesList extends StatelessWidget {
  const BuildGalleriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 100.h,
            width: ScreenUtil().screenWidth,
            margin: const EdgeInsets.symmetric(vertical: 15),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: Theme.of(context).colorScheme.surfaceVariant)),
            child: GalleryCard(
              onTap: () {},
              ratting: 3,
              totalRatting: 24,
              name: items[index].name,
              imgPath: items[index].imagePath,
            ),
          );
        });
  }
}
