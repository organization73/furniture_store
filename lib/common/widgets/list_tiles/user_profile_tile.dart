import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/images/circular_image.dart';
import 'package:decordash/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordash/features/personalization/controllers/user/user_controller.dart';
import 'package:decordash/utils/constants/image_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.onPress,
  });
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
     var controller = UserController.instance;
    print("nnnnnnnnnnnnnnnn");
    print(controller.user.value.firstName);

    return ListTile(
      leading: Obx(() {
        final networkImage = controller.user.value.imageUrl;
        final image = networkImage.isNotEmpty ? networkImage : TImages.user;
        if (controller.profileLoading.value) {
          return ShimmerLoaderEffect(
            width: 50.w,
            height: 50.h,
            raduis: 50.r,
          );
        } else {
          return CircularImage(
            width: 50.r,
            height: 50.r,
            imageUrl: image,
            padding: 2,
            isNetworkImage: networkImage.isNotEmpty,
          );
        }
      }),
      title: Obx(() {
        if (controller.profileLoading.value) {
          return ShimmerLoaderEffect(
            height: 15.h,
            width: 80.w,
          );
        } else {
          return Text(
            controller.user.value.fullName,
            style: Theme.of(context).textTheme.headlineSmall,
          );
        }
      }),
      subtitle: Obx(() {
        if (controller.profileLoading.value) {
          return ShimmerLoaderEffect(
            height: 15.h,
            width: 80.w,
          );
        } else {
          return Text(
            controller.user.value.email,
            style: Theme.of(context).textTheme.bodyMedium,
          );
        }
      }),
      trailing:
          IconButton(onPressed: onPress, icon: const Icon(Iconsax.edit_copy)),
    );
  }
}
