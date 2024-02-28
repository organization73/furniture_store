import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_store/common/widgets/cta_button.dart';
import 'package:furniture_store/common/widgets/text_header.dart';
import 'package:furniture_store/features/authentication/screens/login/login_screen.dart';
import 'package:furniture_store/features/authentication/screens/success_screen.dart';
import 'package:furniture_store/features/authentication/screens/gallery_info.dart';
import 'package:get/get.dart';

class GallerySelection extends StatefulWidget {
  const GallerySelection({super.key});
  @override
  GallerySelectionState createState() => GallerySelectionState();
}

class GallerySelectionState extends State<GallerySelection> {
  int selectedOption = 0; // 0 represents "Yes", 1 represents "No"
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                BuildTopText(
                    title: 'gallarySelect'.tr,
                    subTitle: 'gallarySelectDesc'.tr,
                    iconName: 'gallery_survey'),
                SizedBox(height: 40.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: selectedOption == 1
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedOption = 1;
                      });
                    },
                    child: ListTile(
                      title: Text('yesMes'.tr,
                          style: Theme.of(context).textTheme.titleSmall),
                      leading: Radio(
                        value: 1,
                        groupValue: selectedOption,
                        onChanged: (int? value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: selectedOption == 0
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedOption = 0;
                      });
                    },
                    child: ListTile(
                      title: Text('noMes'.tr,
                          style: Theme.of(context).textTheme.titleSmall),
                      leading: Radio(
                        value: 0,
                        groupValue: selectedOption,
                        onChanged: (int? value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0.h),
                Center(
                  child: SvgPicture.asset('assets/icons/gallery_loc.svg'),
                ),
                SizedBox(height: 20.0.h),
                BuildCTAButton(
                  text: 'cont'.tr,
                  onPressed: () {
                    if (selectedOption == 0) {
                      // Navigator.of(context).pushReplacement(
                      //     createRoute(const SelectPictureScreen()));
                      Get.off(
                        () => const SuccessScreen(
                          screen: LoginSignUpScreen(),
                        ),
                        duration: const Duration(milliseconds: 300),
                        transition: Transition.rightToLeft,
                      );
                    } else {
                      // Navigator.of(context).pushReplacement(
                      //     createRoute(const GalleryInformationScreen()));
                      Get.off(
                        () => const GalleryInformationScreen(),
                        duration: const Duration(milliseconds: 300),
                        transition: Transition.rightToLeft,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
