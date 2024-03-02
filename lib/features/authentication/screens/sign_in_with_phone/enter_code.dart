import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/widgets/cta_button.dart';
import 'package:furniture_store/common/widgets/loaders/loaders.dart';
import 'package:furniture_store/features/authentication/screens/gallery_selction/gallery_selection.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CodeVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  const CodeVerificationScreen({
    super.key,
    required this.phoneNumber,
  });
  @override
  CodeVerificationScreenState createState() => CodeVerificationScreenState();
}

class CodeVerificationScreenState extends State<CodeVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    5,
    (index) => TextEditingController(),
  );

  @override
  void dispose() {
    // Dispose the TextEditingController when the form is disposed.
    for (var controller in _controllers) {
      controller.dispose();
    }
    _resendTimer?.cancel(); // Cancel the timer when the widget is disposed

    super.dispose();
  }

  bool isResendButtonEnabled = true;
  Timer? _resendTimer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: BottomAppBar(
        height: 68,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: BuildCTAButton(
          text: 'verify'.tr,
          onPressed: _verifyCode,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Iconsax.verify,
                size: 45,
                color: Theme.of(context).colorScheme.surfaceVariant,
              ),
              SizedBox(height: TSizes.spaceBtwSections),
              Text(
                'enterCode'.tr,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: TSizes.spaceBtwInputFields),
              Text(
                'codeDesc'.tr,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(height: TSizes.spaceBtwInputFields),
              Text(
                widget.phoneNumber,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: TSizes.spaceBtwSections),
              CodeInputWidget(
                controllers: _controllers,
                onCodeVerified: _verifyCode,
              ),
              TextButton(
                onPressed: isResendButtonEnabled ? _resendCode : null,
                child: Text('codeResend'.tr,
                    style: Theme.of(context).textTheme.labelSmall),
              ),
              if (_resendTimer != null)
                CountdownTimer(
                  duration: const Duration(seconds: 30),
                  onTimerUpdate: (duration) {
                    setState(() {
                      isResendButtonEnabled = duration.inSeconds == 0;
                    });
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _verifyCode() {
    if (_controllers.every((controller) => controller.text.isNotEmpty)) {
      String enteredCode =
          _controllers.map((controller) => controller.text).join();
      if (enteredCode == '55555') {
        Get.off(
          () => GallerySelection(),
          duration: const Duration(milliseconds: 300),
          transition: Transition.rightToLeft,
        );
      } else {
        TLoaders.errorSnackBar(
            title: 'errorMes'.tr, message: 'wrongCodeMes'.tr);
      }
    } else {
      // Show error message
      TLoaders.warningSnackBar(
          title: 'Enter The OTP Code',
          message:
              'Please enter the OTP code recieved in the messege on your phone');
    }
  }

  void _resendCode() {
    // Add logic to resend the code
    for (TextEditingController controller in _controllers) {
      controller.clear();
    }

    // Disable the button and start the 30-second timer
    setState(() {
      isResendButtonEnabled = false;
      _resendTimer = Timer(const Duration(seconds: 30), () {
        setState(() {
          isResendButtonEnabled = true;
          _resendTimer = null; // Reset the timer when it's done
        });
      });
    });
  }
}

class CodeInputWidget extends StatefulWidget {
  final List<TextEditingController> controllers;
  final VoidCallback onCodeVerified;

  const CodeInputWidget({
    super.key,
    required this.controllers,
    required this.onCodeVerified,
  });

  @override
  CodeInputWidgetState createState() => CodeInputWidgetState();
}

class CodeInputWidgetState extends State<CodeInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          5,
          (index) => Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: widget.controllers[index],
              textAlign: TextAlign.center,
              maxLength: 1,
              textDirection: TextDirection.ltr, // Force LTR text direction
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                counterText: "",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              onChanged: (value) {
                if (value.isNotEmpty && index != 4) {
                  // Move focus to the next TextFormField
                  FocusScope.of(context).nextFocus();
                }
                if (index == 4 && value.isNotEmpty) {
                  widget.onCodeVerified();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CountdownTimer extends StatefulWidget {
  final Duration duration;
  final ValueChanged<Duration> onTimerUpdate;

  const CountdownTimer({
    super.key,
    required this.duration,
    required this.onTimerUpdate,
  });

  @override
  CountdownTimerState createState() => CountdownTimerState();
}

class CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late Duration _remainingTime;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.duration;
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
  }

  void _updateTimer(Timer timer) {
    setState(() {
      if (_remainingTime.inSeconds > 0) {
        _remainingTime -= const Duration(seconds: 1);
        widget.onTimerUpdate(_remainingTime);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${'resendDesc'.tr} ${_remainingTime.inSeconds} ${'seconds'.tr}',
      style: TextStyle(
        color: _remainingTime.inSeconds > 0
            ? Colors.grey
            : Theme.of(context).textTheme.bodyLarge?.color,
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
