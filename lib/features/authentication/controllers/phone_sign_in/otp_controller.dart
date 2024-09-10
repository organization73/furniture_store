import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/data/repositories/authentication/authentication_repo.dart';
import 'package:decordashapp/data/repositories/user/user_repo.dart';
import 'package:decordashapp/data/services/notification_service.dart';
import 'package:decordashapp/features/authentication/controllers/phone_sign_in/phone_sign_in_controller.dart';
import 'package:decordashapp/features/authentication/screens/gallery_selction/gallery_selection.dart';
import 'package:decordashapp/features/personalization/models/user_model.dart';
import 'package:decordashapp/utils/logging/logger.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();
  final phoneController = PhoneSingInController.instance;
  static final notifications = NotificationsService();

  void verifyOTP(String otp) async {
    try {
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
              phoneNumber: phoneController.phoneNumber.text.trim(),
              lastActive: DateTime.now(),
            );

            await UserRepo.instance.saveuserRecord(newUser);

            TLoaders.successSnackBar(
                title: 'congrats'.tr, message: 'accountCreationConfirmed'.tr);
            Get.off(
              () => GallerySelection(),
              duration: const Duration(milliseconds: 300),
              transition: Transition.rightToLeft,
            );
            await notifications.requestPermission();
            await notifications.getToken();
          } else {
            TLoaders.errorSnackBar(
                title: 'errorMes'.tr, message: 'wrongCodeMes'.tr);
          }
        } catch (e) {
          TLoaders.errorSnackBar(
              title: 'errorMes'.tr, message: 'wrongCodeMes'.tr);
        }
      } else {
        TLoaders.warningSnackBar(
            title: 'Enter The OTP Code',
            message:
                'Please enter the OTP code recieved in the messege on your phone');
      }
    } catch (e) {
      LoggerHelper.warning(e.toString());
      rethrow;
    }
  }
}
