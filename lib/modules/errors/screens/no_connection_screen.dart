import 'package:decordashapp/common/widgets/buttons/cta_button.dart';
import 'package:decordashapp/modules/errors/controllers/network_connection_controller.dart';
import 'package:decordashapp/modules/errors/widgets/error_info_widget.dart';
import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, this.showActionButton = false});
  final bool showActionButton;

  @override
  Widget build(BuildContext context) {
    final NetworkController networkController = Get.put(NetworkController());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: showActionButton
          ? BottomAppBar(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: BuildCTAButton(
                  text: 'Retry',
                  onPressed: () => networkController.retryConnection()),
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Lottie.asset(ImageStrings.noInternet),
                ),
              ),
              const ErrorInfo(
                title: "Lost in Space!",
                description:
                    "The page you are looking for seems to be missing. Please check your internet.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
