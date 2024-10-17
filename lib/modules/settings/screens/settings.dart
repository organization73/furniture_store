import 'package:decordashapp/data/dummy_data.dart';
import 'package:decordashapp/data/repositories/banners/banners_repo.dart';
import 'package:decordashapp/data/repositories/category/category_repo.dart';
import 'package:decordashapp/modules/ai/screens/ai_design_screen.dart';
import 'package:decordashapp/utils/constants/enums.dart';
import 'package:decordashapp/utils/helpers/helper_functions.dart';
import 'package:decordashapp/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:decordashapp/common/widgets/headings/section_heading.dart';
import 'package:decordashapp/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:decordashapp/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:decordashapp/modules/manufacture_request/screens/manufacture_req_screen.dart';
import 'package:decordashapp/modules/profile/controllers/user_controller.dart';
import 'package:decordashapp/modules/profile/screens/profile.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
                child: SafeArea(
              child: Column(
                children: [
                  ProfileTile(
                    onPress: () => Get.to(
                      () => const ProfileScreen(),
                      duration: const Duration(milliseconds: 300),
                      transition: Transition.downToUp,
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections * 1.5,
                  ),
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.pagePaddingSpace),
              child: Obx(() {
                return Column(
                  children: [
                    UserController.instance.user.value.accountType ==
                            AccountType.gallery
                        ? Column(
                            children: [
                              SectionHeading(
                                title: 'gallaryTitle'.tr,
                                showActionButton: false,
                              ),
                              SettingsMenuTile(
                                icon: IconsaxPlusLinear.buildings,
                                title: UserController
                                    .instance.user.value.galleryName,
                                subTitle: UserController
                                    .instance.user.value.galleryAddress,
                                onTap: () {},
                              ),
                              const SizedBox(
                                height: TSizes.spaceBtwSections,
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    SectionHeading(
                      title: 'accountSettings'.tr,
                      showActionButton: false,
                    ),
                    SettingsMenuTile(
                      icon: IconsaxPlusLinear.designtools,
                      title: 'manefactureReq'.tr,
                      subTitle: 'manefactureReqDesc'.tr,
                      onTap: () => Get.to(
                        () => const ManufactureRequestsPage(),
                        duration: const Duration(milliseconds: 300),
                        transition: Transition.rightToLeft,
                      ),
                    ),
                    SettingsMenuTile(
                      icon: IconsaxPlusLinear.d_cube_scan,
                      title: 'AI Designs',
                      subTitle: 'buyPointsDesc'.tr,
                      onTap: () => Get.to(
                        () => const AiPage(),
                        duration: const Duration(milliseconds: 300),
                        transition: Transition.rightToLeft,
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    SectionHeading(
                      title: 'appSettings'.tr,
                      showActionButton: false,
                    ),
                    SettingsMenuTile(
                      icon: IconsaxPlusLinear.language_square,
                      title: 'language'.tr,
                      subTitle: 'languageDesc'.tr,
                      onTap: () => THelperFunctions.showLanguageModel(),
                    ),
                    SettingsMenuTile(
                      icon: IconsaxPlusLinear.moon,
                      title: 'darkMode'.tr,
                      subTitle: 'darkModeDesc'.tr,
                      onTap: () {
                        Get.changeTheme(Get.isDarkMode
                            ? const MaterialTheme().light()
                            : const MaterialTheme().dark());
                      },
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    const SectionHeading(
                      title: 'Testing',
                      showActionButton: false,
                    ),
                    SettingsMenuTile(
                      icon: IconsaxPlusLinear.arrange_circle,
                      title: 'Upload Banners',
                      subTitle: 'Upload all banners data to firebase',
                      onTap: () {
                        BannersRepo.instance.uploadDummyData(
                          DummyData.banners,
                        );
                      },
                    ),
                    SettingsMenuTile(
                      icon: IconsaxPlusLinear.arrange_circle,
                      title: 'Upload Categories And Rooms',
                      subTitle: 'Upload all catedories data to firebase',
                      onTap: () {
                        CategoryRepo.instance.uploadDummyData(
                          DummyData.categories,
                          DummyData.rooms,
                        );
                      },
                    ),
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
