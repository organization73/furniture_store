import 'package:decordashapp/common/widgets/icons/circular_icon.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/images/circular_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final bool isNetworkImage;
  final VoidCallback onClicked;

  const ProfileWidget({
    super.key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
    this.isNetworkImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircularImage(
            imageUrl: imagePath,
            width: 100.r,
            height: 100.r,
            isNetworkImage: isNetworkImage,
          ),
          Positioned(
            bottom: 0,
            right: 2,
            child: CicularIcon(
              icon: Iconsax.edit_2,
              height: 35.r,
              width: 35.r,
              onPress: onClicked,
            ),
          ),
        ],
      ),
    );
  }
}
