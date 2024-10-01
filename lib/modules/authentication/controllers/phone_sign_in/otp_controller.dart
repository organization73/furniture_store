import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/data/repositories/authentication/authentication_repo.dart';
import 'package:decordashapp/data/repositories/user/user_repo.dart';
import 'package:decordashapp/data/services/chat/notifications/notification_service.dart';
import 'package:decordashapp/modules/authentication/controllers/phone_sign_in/phone_sign_in_controller.dart';
import 'package:decordashapp/modules/authentication/screens/gallery_selction/gallery_selection.dart';
import 'package:decordashapp/modules/personalization/models/user_model.dart';
import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:decordashapp/utils/popups/full_screen_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  final phoneController = PhoneSingInController.instance;
  static final notifications = NotificationsService();

  void verifyOTP(String otp) async {
    try {
      FullScreenLoader.openLoadingDialog(
          'loggingInLoadingTitle'.tr, TImages.processingInfo);

      if (otp.isNotEmpty) {
        try {
          final UserCredential userCred = await AuthenticatorRepo.instance
              .getPhoneUserSigninCredentials(otp);

          final bool isVerified = userCred.user != null ? true : false;
          if (isVerified) {
            final newUser = UserModel(
              id: userCred.user!.uid,
              firstName:
                  'rgrg', //phoneController.firstNameController.text.trim(),
              lastName:
                  'egege', //phoneController.lastNameController.text.trim(),
              phoneNumber: phoneController.number.phoneNumber!,
            );

            await UserRepo.instance.saveuserRecord(newUser);

            Get.off(
              () => GallerySelection(),
              duration: const Duration(milliseconds: 300),
              transition: Transition.rightToLeft,
            );
            await notifications.requestPermission();
            await notifications.getToken();

            TLoaders.successSnackBar(
                title: 'congrats'.tr, message: 'accountCreationConfirmed'.tr);
          } else {
            FullScreenLoader.stopLoading();
            TLoaders.errorSnackBar(
                title: 'errorMes'.tr, message: 'wrongCodeMes'.tr);
          }
        } catch (e) {
          FullScreenLoader.stopLoading();
          TLoaders.errorSnackBar(
              title: 'errorMes'.tr, message: 'wrongCodeMes'.tr);
        }
      } else {
        FullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'Enter The OTP Code',
            message:
                'Please enter the OTP code recieved in the messege on your phone');
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      rethrow;
    }
  }
}
