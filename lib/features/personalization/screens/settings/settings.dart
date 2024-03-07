import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/appbar/custom_appbar.dart';
import 'package:furniture_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:furniture_store/common/widgets/headings/section_heading.dart';
import 'package:furniture_store/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:furniture_store/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:furniture_store/data/dummy_data.dart';
import 'package:furniture_store/data/repositories/authentication/authentication_repo.dart';
import 'package:furniture_store/data/repositories/category/category_repo.dart';
import 'package:furniture_store/data/repositories/product/product_repo.dart';
import 'package:furniture_store/data/repositories/vendor/vendor_repo.dart';
import 'package:furniture_store/features/manufacture_request/screens/manufacture_req_screen.dart';
import 'package:furniture_store/features/personalization/controllers/user/user_controller.dart';
import 'package:furniture_store/features/personalization/screens/profile/profile.dart';
import 'package:furniture_store/utils/constants/sizes.dart';

import 'package:furniture_store/utils/theme/theme.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

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
              padding:
                  EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
              child: Column(
                children: [
                  SectionHeading(
                    title: 'accountSettings'.tr,
                    showActionButton: false,
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.designtools,
                    title: 'manefactureReq'.tr,
                    subTitle: 'manefactureReqDesc'.tr,
                    onTap: () => Get.to(
                      () => const ManufactureRequestsPage(),
                      duration: const Duration(milliseconds: 300),
                      transition: Transition.rightToLeft,
                    ),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.buy_crypto,
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
                    icon: Iconsax.language_circle,
                    title: 'language'.tr,
                    subTitle: 'languageDesc'.tr,
                    onTap: () => _showLanguageModel(),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.moon,
                    title: 'darkMode'.tr,
                    subTitle: 'darkModeDesc'.tr,
                    onTap: () {
                      Get.changeTheme(Get.isDarkMode
                          ? TAppTheme.lightTheme
                          : TAppTheme.darkTheme);
                    },
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.arrow_up_1,
                    title: 'Upload Categories',
                    subTitle: 'Upload all catedories data to firebase',
                    onTap: () {
                      CategoryRepo.instance
                          .uploadDummyData(DummyData.categories);
                    },
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.arrow_up_1,
                    title: 'Upload Products',
                    subTitle: 'Upload all products data to firebase',
                    onTap: () {
                      ProductRepo.instance
                          .uploadProductsToFirestore(DummyData.products);
                    },
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.arrow_up_1,
                    title: 'Upload Vendors',
                    subTitle: 'Upload all vendors data to firebase',
                    onTap: () {
                      VendorRepo.instance
                          .uploadDummyData(DummyData.vendors);
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
