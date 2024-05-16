import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SuccessScreen extends StatefulWidget {
  final dynamic screen; // Declare the field as final

  const SuccessScreen({super.key, required this.screen});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      // Use the 'sc' field to create the route
      Get.to(
        () => widget.screen,
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_circle_rounded,
                size: 60.0,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: 8.0.h),
              Text(
                'done'.tr,
                style: TextStyle(
                  fontSize: 20.0.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
