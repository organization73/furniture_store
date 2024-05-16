import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/repositories/authentication/authentication_repo.dart';
import 'package:decordash/data/repositories/user/user_repo.dart';
import 'package:decordash/features/authentication/controllers/phone_sign_in/phone_sign_in_controller.dart';
import 'package:decordash/features/authentication/screens/gallery_selction/gallery_selection.dart';
import 'package:decordash/features/personalization/models/user_model.dart';
import 'package:decordash/utils/logging/logger.dart';
import 'package:decordash/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();
  final phoneController = PhoneSingInController.instance;
  void verifyOTP(String otp) async {
    try {
      FullScreenLoader.openLoadingDialog(
          'processingLoading'.tr, 'assets/animations/animation-of-docer.json');
      if (otp.isNotEmpty) {
        try {
          var userCred = await AuthenticatorRepo.instance
              .getPhoneUserSigninCredentials(otp);
          var isVerified = userCred.user != null ? true : false;
          if (isVerified) {
            final newUser = UserModel(
              id: userCred.user!.uid,
              firstName: phoneController.firstNameController.text.trim(),
              lastName: phoneController.lastNameController.text.trim(),
              userName: phoneController.userNameController.text.trim(),
              phoneNumber: phoneController.phoneNumController.text.trim(),
            );

            await UserRepo.instance.saveuserRecord(newUser);

            TLoaders.successSnackBar(
                title: 'congrats'.tr, message: 'accountCreationConfirmed'.tr);
            Get.off(
              () => GallerySelection(),
              duration: const Duration(milliseconds: 300),
              transition: Transition.rightToLeft,
            );
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
      LoggerHelper.warning(e.toString());
    }
  }
}
