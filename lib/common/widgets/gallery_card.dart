import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GalleryCard extends StatelessWidget {
  const GalleryCard({
    super.key,
    required this.onTap,
    required this.ratting,
    required this.totalRatting,
    required this.name,
    required this.imgPath,
  });
  final String name;
  final String imgPath;
  final double ratting;
  final int totalRatting;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            child: LikeListTile(
          title: name,
          ratting: '$ratting',
          subtitle: "$totalRatting Reviews",
          color: Colors.black,
          imgPath: imgPath,
        ))
      ],
    );
  }
}

class LikeListTile extends StatelessWidget {
  const LikeListTile(
      {super.key,
      required this.title,
      required this.ratting,
      required this.subtitle,
      this.color = Colors.grey,
      required this.imgPath});
  final String title;
  final String ratting;
  final String subtitle;
  final Color color;
  final String imgPath;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: SizedBox(
        width: 50.w,
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage(imgPath))),
          ),
        ),
      ),
      title: Text(title),
      subtitle: Row(
        children: [
          const Icon(Icons.star, color: Colors.yellow, size: 15),
          SizedBox(width: 2.w),
          Text(ratting),
          Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(width: 4, height: 4),
              )),
          Text(subtitle)
        ],
      ),
    );
  }
}
