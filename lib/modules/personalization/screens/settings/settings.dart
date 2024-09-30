import 'package:decordashapp/modules/ai/screens/ai_design_screen.dart';
import 'package:decordashapp/utils/constants/enums.dart';
import 'package:decordashapp/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:decordashapp/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:decordashapp/common/widgets/headings/section_heading.dart';
import 'package:decordashapp/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:decordashapp/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:decordashapp/modules/manufacture_request/screens/manufacture_req_screen.dart';
import 'package:decordashapp/modules/personalization/controllers/user/user_controller.dart';
import 'package:decordashapp/modules/personalization/screens/profile/profile.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showLanguageModel() {
    showModalBottomSheet<void>(
      context: Get.overlayContext!,
      showDragHandle: true,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'selectLan'.tr,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ListTile(
              title: Text(
                'English',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              leading: const Text(
                'en',
                style: TextStyle(fontSize: 25),
              ),
              onTap: () {
                Get.updateLocale(const Locale('en', 'US'));
                Get.back();
              },
            ),
            ListTile(
              title: Text(
                'Arabic',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              leading: const Text(
                'ar',
                style: TextStyle(fontSize: 25),
              ),
              onTap: () {
                Get.updateLocale(const Locale('ar', 'SA'));
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

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
                            AccountType.vendor
                        ? Column(
                            children: [
                              SectionHeading(
                                title: 'gallaryTitle'.tr,
                                showActionButton: false,
                              ),
                              SettingsMenuTile(
                                icon: Iconsax.buildings_copy,
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
                      icon: Iconsax.designtools_copy,
                      title: 'manefactureReq'.tr,
                      subTitle: 'manefactureReqDesc'.tr,
                      onTap: () => Get.to(
                        () => const ManufactureRequestsPage(),
                        duration: const Duration(milliseconds: 300),
                        transition: Transition.rightToLeft,
                      ),
                    ),
                    SettingsMenuTile(
                      icon: Iconsax.d_cube_scan_copy,
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
                      icon: Iconsax.language_square_copy,
                      title: 'language'.tr,
                      subTitle: 'languageDesc'.tr,
                      onTap: () => _showLanguageModel(),
                    ),
                    SettingsMenuTile(
                      icon: Iconsax.moon_copy,
                      title: 'darkMode'.tr,
                      subTitle: 'darkModeDesc'.tr,
                      onTap: () {
                        Get.changeTheme(Get.isDarkMode
                            ? const MaterialTheme().light()
                            : const MaterialTheme().dark());
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
