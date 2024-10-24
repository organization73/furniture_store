import 'package:decordashapp/modules/profile/screens/change_gallery_info_screen.dart';
import 'package:decordashapp/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/headings/section_heading.dart';
import 'package:decordashapp/common/widgets/shimmer/shimmer_loader.dart';
import 'package:decordashapp/common/widgets/user_profile/profile_widget.dart';
import 'package:decordashapp/modules/profile/controllers/user_controller.dart';
import 'package:decordashapp/modules/profile/widgets/change_name.dart';
import 'package:decordashapp/modules/profile/widgets/profile_menu.dart';
import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:decordashapp/utils/constants/sizes.dart';

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
                    networkImage.isNotEmpty ? networkImage : ImageStrings.user;
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
                  : const SizedBox.shrink(),
              (controller.user.value.phoneNumber.isNotEmpty)
                  ? ProfileMenu(
                      title: 'Phone Number',
                      value: controller.user.value.phoneNumber,
                      onPress: () {},
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              (controller.user.value.accountType == AccountType.gallery)
                  ? Column(
                      children: [
                        const SectionHeading(
                          title: 'Gallery Information',
                          showActionButton: false,
                        ),
                        (controller.user.value.galleryName.isNotEmpty)
                            ? ProfileMenu(
                                title: 'Name',
                                showIcon: true,
                                value: controller.user.value.galleryName,
                                onPress: () => Get.off(
                                  () => const ChangeGalleryInfoScreen(),
                                  duration: const Duration(milliseconds: 300),
                                  transition: Transition.downToUp,
                                ),
                              )
                            : const SizedBox.shrink(),
                        (controller.user.value.galleryAddress.isNotEmpty)
                            ? ProfileMenu(
                                title: 'Address',
                                value: controller.user.value.galleryAddress,
                                onPress: () {},
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: Text('Close Account',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.error)))
            ],
          ),
        ),
      ),
    );
  }
}
