import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/headings/section_heading.dart';
import 'package:decordashapp/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordashapp/common/widgets/user_profile/profile_widget.dart';
import 'package:decordashapp/features/personalization/controllers/user/user_controller.dart';
import 'package:decordashapp/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:decordashapp/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          padding:
              const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: Column(
            children: [
              Obx(() {
                final networkImage = controller.user.value.avatar;
                final image =
                    networkImage.isNotEmpty ? networkImage : TImages.user;
                if (controller.imageLoading.value) {
                  return ShimmerLoaderEffect(
                    width: 100.w,
                    height: 100.h,
                    raduis: 50.r,
                  );
                } else {
                  return ProfileWidget(
                    isNetworkImage: networkImage.isNotEmpty,
                    imagePath: image,
                    onClicked: () => controller.uploadUserProfilePicture(),
                  );
                }
              }),
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const SectionHeading(
                title: 'Profile Information',
                showActionButton: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              ProfileMenu(
                title: 'Name',
                showIcon: true,
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
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const SectionHeading(
                title: 'Account Information',
                showActionButton: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              (controller.user.value.email.isNotEmpty)
                  ? ProfileMenu(
                      title: 'E-mail',
                      value: controller.user.value.email,
                      onPress: () {},
                    )
                  : const SizedBox(),
              (controller.user.value.phoneNumber.isNotEmpty)
                  ? ProfileMenu(
                      title: 'Phone Number',
                      value: controller.user.value.phoneNumber,
                      onPress: () {},
                    )
                  : const SizedBox(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: Text(
                    'Close Account',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
