import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/features/authentication/screens/success_screen.dart';
import 'package:furniture_store/features/home/screens/home_screen.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SelectPictureScreen extends StatefulWidget {
  const SelectPictureScreen({super.key});
  @override
  SelectPictureScreenState createState() => SelectPictureScreenState();
}

class SelectPictureScreenState extends State<SelectPictureScreen> {
  String? _pickedImagePath;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    try {
      // Pick an image from the gallery
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Set the picked image path and update the UI
        setState(() {
          _pickedImagePath = pickedFile.path;
        });
      }
    } catch (e) {
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text('Error taking photo: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                height: 100.h,
                child: Column(children: [
                  Text('profilePic'.tr,
                      style: Theme.of(context).textTheme.headlineMedium),
                  SizedBox(height: 8.h),
                  Text('selectProfilePic'.tr,
                      style: Theme.of(context).textTheme.labelSmall),
                ]),
              ),
              SizedBox(
                width: 180.w,
                height: 180.h,
                child: ClipOval(
                  child: _pickedImagePath != null
                      ? Image.file(
                          File(_pickedImagePath!),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : const SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.person,
                            size: 110,
                          )),
                ),
              ),
              SizedBox(height: 60.h),
              Container(
                width: 300.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: InkWell(
                  onTap: _pickImageFromGallery,
                  child: ListTile(
                    leading: const Icon(
                      Icons.attachment_rounded,
                    ),
                    title: Text(
                      'fileUpload'.tr,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SuccessScreen(
                                    screen: HomePage(initialPageIndex: 0),
                                  )),
                          (route) => false);
                    },
                    child: Text('skip'.tr,
                        style: Theme.of(context).textTheme.labelSmall),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SuccessScreen(
                                      screen: HomePage(initialPageIndex: 0),
                                    )),
                            (route) => false);
                      },
                      child: Row(
                        children: [
                          Text('next'.tr,
                              style: Theme.of(context).textTheme.labelMedium),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.arrow_forward,
                            size: TSizes.md,
                            color:
                                Theme.of(context).textTheme.labelMedium?.color,
                          )
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
