import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/widgets/cta_button.dart';
import 'package:furniture_store/common/widgets/text_header.dart';
import 'package:furniture_store/features/authentication/screens/login/login_screen.dart';
import 'package:furniture_store/features/authentication/screens/success_screen.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GalleryInformationScreen extends StatefulWidget {
  const GalleryInformationScreen({super.key});
  @override
  GalleryInformationScreenState createState() =>
      GalleryInformationScreenState();
}

class GalleryInformationScreenState extends State<GalleryInformationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController galleryNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  File? selectedImage;

  String? validateGalleryName(String? value) {
    if (value == null || value.isEmpty) {
      return 'galleryVal'.tr;
    }
    if (value.length <= 4) {
      return 'galleryVallen'.tr;
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'galleryAddressTextval'.tr;
    }
    if (value.length <= 6) {
      return 'galleryAddressVal'.tr;
    }
    return null;
  }

  String? validateFile(File? file) {
    if (file == null) {
      return 'fileUpload'.tr;
    }
    return null;
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
      }
    });
  }

  @override
  void dispose() {
    // Dispose the TextEditingController when the form is disposed.
    galleryNameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 40.h,
                  ),
                  BuildTopText(
                      title: 'gallaryTitle'.tr,
                      subTitle: 'gallaryTitleDesc'.tr,
                      iconName: 'email'),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: galleryNameController,
                    validator: validateGalleryName,
                    decoration: InputDecoration(
                      hintText: 'galleryName'.tr,
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: addressController,
                    validator: validateAddress,
                    decoration: InputDecoration(
                      hintText: 'galleryAddress'.tr,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  InkWell(
                    onTap: _pickImage,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ListTile(
                        leading: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Icon(Icons.attachment_rounded),
                        ),
                        title: Text(
                          'uploadGalleryID'.tr,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ),
                  ),
                  if (selectedImage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Text(
                        '${'selectedFile'.tr}: ${selectedImage!.path.split('/').last}',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  SizedBox(height: 60.h),
                  BuildCTAButton(
                    text: 'cont'.tr,
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        String? fileValidation = validateFile(selectedImage);
                        // TODO: inverse the condition to validate the form and use the mvc architecture
                        if (fileValidation == null) {
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
                          // Display error message for file validation
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(fileValidation,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onError)),
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
