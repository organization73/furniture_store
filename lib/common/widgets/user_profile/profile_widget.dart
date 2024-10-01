import 'package:decordashapp/common/widgets/icons/circular_icon.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/images/circular_image.dart';

import 'package:iconsax_plus/iconsax_plus.dart';

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
            width: 100,
            height: 100,
            isNetworkImage: isNetworkImage,
          ),
          Positioned(
            bottom: 0,
            right: 2,
            child: CicularIcon(
              icon: IconsaxPlusLinear.edit_2,
              height: 35,
              width: 35,
              onPress: onClicked,
            ),
          ),
        ],
      ),
    );
  }
}
