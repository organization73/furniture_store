import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/repositories/authentication/authentication_repo.dart';
import 'package:decordash/features/authentication/screens/gallery_selction/gallery_selection.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async {
    if (otp.isNotEmpty) {
      var isVerified = await AuthenticatorRepo.instance.verifyOTP(otp);
      if (isVerified) {
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
      TLoaders.warningSnackBar(
          title: 'Enter The OTP Code',
          message:
              'Please enter the OTP code recieved in the messege on your phone');
    }
  }
}
