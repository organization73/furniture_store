import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/common/widgets/headings/page_header.dart';
import 'package:decordashapp/common/widgets/input_fields/build_user_input_field.dart';
import 'package:decordashapp/modules/authentication/controllers/phone_sign_in/phone_user_info_controller.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:decordashapp/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class PhoneUserInfoScreen extends StatelessWidget {
  const PhoneUserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PhoneUserInfoController());

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: BuildCTAButton(
              text: 'tContinue'.tr, onPressed: () => controller.updateInfo())),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageHeader(
                  title: 'continueWithPhoneTitle'.tr,
                  subTitle: 'signupTitle'.tr,
                  iconName: IconsaxPlusBroken.profile,
                ),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: RoundedTextField(
                                'firstName'.tr,
                                controller.firstNameController,
                                prefixIcon: IconsaxPlusLinear.user,
                                keyboardType: TextInputType.name,
                                TValidator.validateUserInput),
                          ),
                          const SizedBox(width: TSizes.sm),
                          Expanded(
                            child: RoundedTextField(
                                prefixIcon: IconsaxPlusLinear.clipboard_text,
                                'lastName'.tr,
                                controller.lastNameController,
                                keyboardType: TextInputType.name,
                                TValidator.validateUserInput),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
