import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/widgets/build_user_input_field.dart';
import 'package:furniture_store/common/widgets/cta_button.dart';
import 'package:furniture_store/common/widgets/text_header.dart';
import 'package:furniture_store/features/authentication/screens/sign_in_with_phone/enter_code.dart';
import 'package:furniture_store/routes/routes.dart';
import 'package:furniture_store/features/authentication/screens/gallery_selction/gallery_selection.dart';

import 'package:furniture_store/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});
  @override
  PhoneNumberScreenState createState() => PhoneNumberScreenState();
}

class PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    // Dispose the TextEditingController when the form is disposed.
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          height: 68,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: BuildCTAButton(
            text: 'tContinue'.tr,
            onPressed: _codeVerify,
          )),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BuildTopText(
                      title: 'continueWithPhoneTitle'.tr,
                      subTitle: 'continueWithPhoneSubTitle'.tr,
                      iconName: 'phone'),
                  SizedBox(height: 20.h),
                  RoundedTextField(
                      'phoneNo'.tr,
                      _phoneController,
                      prefixIcon: Iconsax.call,
                      TValidator.validatePhoneNumber,
                      keyboardType: TextInputType.phone),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _codeVerify() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pushReplacement(createRoute(CodeVerificationScreen(
        phoneNumber: _phoneController.text,
        routeNamed: GallerySelection(),
      )));
    }
  }
}
