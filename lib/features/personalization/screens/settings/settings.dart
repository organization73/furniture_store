import 'package:flutter/material.dart';
import 'package:decordash/common/widgets/appbar/custom_appbar.dart';
import 'package:decordash/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:decordash/common/widgets/headings/section_heading.dart';
import 'package:decordash/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:decordash/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:decordash/data/dummy_data.dart';
import 'package:decordash/data/repositories/authentication/authentication_repo.dart';
import 'package:decordash/data/repositories/banners/banners_repo.dart';
import 'package:decordash/data/repositories/category/category_repo.dart';
import 'package:decordash/data/repositories/product/product_repo.dart';
import 'package:decordash/data/repositories/vendor/vendor_repo.dart';
import 'package:decordash/features/manufacture_request/screens/manufacture_req_screen.dart';
import 'package:decordash/features/personalization/controllers/user/user_controller.dart';
import 'package:decordash/features/personalization/screens/profile/profile.dart';
import 'package:decordash/utils/constants/sizes.dart';

import 'package:decordash/utils/theme/theme.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showLanguageModel() {
    showModalBottomSheet<void>(
      context: Get.overlayContext!,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'selectLan'.tr,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              ListTile(
                title: Text(
                  'English',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                leading: const Text(
                  'en',
                  style: TextStyle(fontSize: 30),
                ),
                onTap: () {
                  Get.updateLocale(const Locale('en', 'US'));
                  Get.back();
                },
              ),
              ListTile(
                title: Text(
                  'Arabic',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                leading: const Text(
                  'ar',
                  style: TextStyle(fontSize: 30),
                ),
                onTap: () {
                  Get.updateLocale(const Locale('ar', 'SA'));
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
                child: SafeArea(
              child: Column(
                children: [
                  CustomAppBar(
                    title: Text(
                      'myAccount'.tr,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  ProfileTile(
                    onPress: () => Get.to(
                      () => const ProfileScreen(),
                      duration: const Duration(milliseconds: 300),
                      transition: Transition.downToUp,
                    ),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.pagePaddingSpace),
              child: Column(
                children: [
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
                    icon: Iconsax.buy_crypto_copy,
                    title: 'buyPoints'.tr,
                    subTitle: 'buyPointsDesc'.tr,
                    onTap: () {},
                  ),
                  SizedBox(
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
                          ? TAppTheme.lightTheme
                          : TAppTheme.darkTheme);
                    },
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.arrow_up_1_copy,
                    title: 'Upload Categories',
                    subTitle: 'Upload all catedories data to firebase',
                    onTap: () {
                      CategoryRepo.instance
                          .uploadDummyData(DummyData.categories);
                    },
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.arrow_up_1_copy,
                    title: 'Upload Banners',
                    subTitle: 'Upload all banners data to firebase',
                    onTap: () {
                      BannersRepo.instance.uploadDummyData(DummyData.banners);
                    },
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.arrow_up_1_copy,
                    title: 'Upload Products',
                    subTitle: 'Upload all products data to firebase',
                    onTap: () {
                      ProductRepo.instance
                          .uploadProductsToFirestore(DummyData.products);
                    },
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.arrow_up_1_copy,
                    title: 'Upload Vendors',
                    subTitle: 'Upload all vendors data to firebase',
                    onTap: () {
                      VendorRepo.instance.uploadDummyData(DummyData.vendors);
                    },
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () => AuthenticatorRepo.instance.logOut(),
                        child: Text('logout'.tr)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
