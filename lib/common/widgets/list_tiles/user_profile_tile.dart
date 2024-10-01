import 'package:decordashapp/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordashapp/data/repositories/authentication/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/images/circular_image.dart';
import 'package:decordashapp/modules/personalization/controllers/user/user_controller.dart';
import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.onPress,
  });
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return ListTile(
      leading: Obx(() {
        final networkImage = controller.user.value.avatar;
        final image = networkImage.isNotEmpty ? networkImage : TImages.user;
        if (controller.profileLoading.value) {
          return const ShimmerLoaderEffect(
            width: 50,
            height: 50,
            raduis: 50,
          );
        } else {
          return CircularImage(
            width: 50,
            height: 50,
            imageUrl: image,
            padding: 2,
            isNetworkImage: networkImage.isNotEmpty,
          );
        }
      }),
      title: Obx(() {
        if (controller.profileLoading.value) {
          return const ShimmerLoaderEffect(
            height: 15,
            width: 80,
          );
        } else {
          return Text(
            controller.user.value.fullName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          );
        }
      }),
      subtitle: Obx(() {
        if (controller.profileLoading.value) {
          return const ShimmerLoaderEffect(
            height: 15,
            width: 80,
          );
        } else {
          return Text(
            controller.user.value.email,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall,
          );
        }
      }),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: onPress, icon: const Icon(IconsaxPlusLinear.edit)),
          IconButton(
              tooltip: 'logout'.tr,
              onPressed: () => AuthenticatorRepo.instance.logOut(),
              icon: const Icon(IconsaxPlusLinear.login)),
        ],
      ),
    );
  }
}
