import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/headings/section_heading.dart';
import 'package:furniture_store/common/widgets/shimmer/shimmerLoader.dart';
import 'package:furniture_store/common/widgets/user_profile/profile_widget.dart';
import 'package:furniture_store/features/personalization/controllers/user/user_controller.dart';
import 'package:furniture_store/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:furniture_store/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:furniture_store/utils/constants/image_strings.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: Column(
            children: [
              Obx(() {
                final networkImage = controller.user.value.avatar;
                final image =
                    networkImage.isNotEmpty ? networkImage : TImages.user;
                if (controller.imageLoading.value) {
                  return const ShimmerLoaderEffect(
                    width: 100,
                    height: 100,
                    raduis: 50,
                  );
                } else {
                  return ProfileWidget(
                    isNetworkImage: networkImage.isNotEmpty,
                    imagePath: image,
                    onClicked: () => controller.uploadUserProfilePicture(),
                  );
                }
              }),
              SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              const Divider(),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const SectionHeading(
                title: 'Profile Information',
                showActionButton: false,
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              ProfileMenu(
                title: 'Name',
                value: controller.user.value.fullName,
                onPress: () => Get.off(
                  () => const ChangeNameScreen(),
                  duration: const Duration(milliseconds: 300),
                  transition: Transition.downToUp,
                ),
              ),
              ProfileMenu(
                title: 'Username',
                value: controller.user.value.userName,
                onPress: () {},
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Divider(),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const SectionHeading(
                title: 'Account Information',
                showActionButton: false,
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              ProfileMenu(
                title: 'E-mail',
                value: controller.user.value.email,
                onPress: () {},
              ),
              ProfileMenu(
                title: 'Phone Number',
                value: controller.user.value.phoneNumber,
                onPress: () {},
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Divider(),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
