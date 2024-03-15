import 'package:decordash/utils/constants/colors.dart';
import 'package:decordash/utils/logging/logger.dart';
import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/headings/section_heading.dart';
import 'package:decordash/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordash/common/widgets/user_profile/profile_widget.dart';
import 'package:decordash/features/personalization/controllers/user/user_controller.dart';
import 'package:decordash/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:decordash/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:decordash/utils/constants/image_strings.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    LoggerHelper.info(controller.user.value.accountType.toString());
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
                    style: TextStyle(color: TColors.error),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
