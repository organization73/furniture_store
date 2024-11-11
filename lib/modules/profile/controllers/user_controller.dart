import 'package:decordashapp/data/services/cloud_storage/firebase_storage_service.dart';
import 'package:decordashapp/utils/constants/image_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/data/repositories/authentication/authentication_repo.dart';
import 'package:decordashapp/data/repositories/user/user_repo.dart';
import 'package:decordashapp/modules/authentication/screens/user_login/user_login_screen.dart';
import 'package:decordashapp/modules/profile/models/user_model.dart';
import 'package:decordashapp/modules/profile/widgets/re_auth_user_form.dart';
import 'package:decordashapp/utils/constants/sizes.dart';
import 'package:decordashapp/utils/helpers/network_manager.dart';
import 'package:decordashapp/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  final imageLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = true.obs;
  final GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();
  final TextEditingController verifyEmail = TextEditingController();
  final TextEditingController verifyPassword = TextEditingController();
  final FocusNode verifyEmailFocus = FocusNode();
  final FocusNode verifyPasswordFocus = FocusNode();

  final userRepo = Get.put(UserRepo());
  final storageServices = Get.put(FirebaseStorageServices());

  @override
  onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepo.fetchUserData();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> saveUserRecord(UserCredential? userCred) async {
    try {
      /// refresh user record
      await fetchUserRecord();
      if (user.value.id.isEmpty) {
        if (userCred != null) {
          final namePart =
              UserModel.nameParts(userCred.user!.displayName ?? '');
          final userName = UserModel.generateUsernameFromFullName(
              userCred.user!.displayName ?? '');

          final user = UserModel(
              id: userCred.user!.uid,
              firstName: namePart[0],
              lastName:
                  namePart.length > 1 ? namePart.sublist(1).join(' ') : '',
              userName: userName,
              email: userCred.user!.email ?? '',
              phoneNumber: userCred.user!.phoneNumber ?? '',
              avatar: userCred.user!.photoURL ?? '');

          await userRepo.saveuserRecord(user);
        }
      }
    } catch (e) {
      TLoaders.warningSnackBar(
          title: 'Data is not saved!',
          message: 'Something went wrong while saving you information');
    }
  }

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(TSizes.md),
        title: 'Delete Account',
        middleText:
            'Are you sure you want to delete your account?, This action is not reversable and all you data will be deleted',
        confirm: ElevatedButton(
            onPressed: () async => deleteUserAccount(),
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(Get.context!).colorScheme.error,
                side: BorderSide(
                    color: Theme.of(Get.context!).colorScheme.error)),
            child: Text('Delete',
                style: TextStyle(
                  color: Theme.of(Get.context!).colorScheme.onError,
                ))),
        cancel: OutlinedButton(
            onPressed: () => Get.back(), child: const Text('Cancel')));
  }

  void deleteUserAccount() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Processing', ImageStrings.processingInfo);

      final auth = AuthenticatorRepo.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await userRepo.removeUserRecord(auth.authUser!.uid);
          await auth.deleteAccount();
          FullScreenLoader.stopLoading();
          Get.offAll(
            () => const UserLoginScreen(),
          );
        } else if (provider == 'password') {
          FullScreenLoader.stopLoading();
          Get.to(
            () => const ReAuthLoginForm(),
          );
        } else if (provider == 'phone') {
          await userRepo.removeUserRecord(auth.authUser!.uid);
          await auth.deleteAccount();
          FullScreenLoader.stopLoading();
          Get.offAll(
            () => const UserLoginScreen(),
          );
        }
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }

  Future<void> reAuthEmailAndPasswordUser() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Processing', ImageStrings.processingInfo);
      final isConnected = NetworkManager.instance.isOnline;
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'internet'.tr, message: 'noInternet'.tr);
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();

        return;
      }
      await AuthenticatorRepo.instance.reAuthEmailAndPasswordUser(
          verifyEmail.text.trim(), verifyPassword.text.trim());

      await userRepo.removeUserRecord(user.value.id);
      await AuthenticatorRepo.instance.deleteAccount();

      FullScreenLoader.stopLoading();
      Get.offAll(
        () => const UserLoginScreen(),
      );
    } catch (e) {
      FullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }

  Future<void> uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        imageLoading.value = true;

        final imageUrl = await storageServices.uploadImageFile(
            'Users/Images/Profile/', image);

        Map<String, dynamic> json = {"avatar": imageUrl};
        await userRepo.updateSingleField(json);
        user.value.avatar = imageUrl;
        user.refresh();

        TLoaders.successSnackBar(
            title: 'Done'.tr, message: 'Profile image has been updated');
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    } finally {
      imageLoading.value = false;
    }
  }

  Future<void> uploadGalleryInfo({required bool isCertificate}) async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 65,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        FullScreenLoader.openLoadingDialog(
            'Processing', ImageStrings.processingInfo);

        final isConnected = NetworkManager.instance.isOnline;
        if (!isConnected) {
          FullScreenLoader.stopLoading();
          TLoaders.warningSnackBar(
              title: 'internet'.tr, message: 'noInternet'.tr);
          return;
        }

        final imageUrl = await storageServices.uploadImageFile(
            isCertificate
                ? 'Users/Images/Gallery/Certificate/'
                : 'Users/Images/Gallery/Picture/',
            image);

        Map<String, dynamic> json = {
          isCertificate ? "galleryCertificate" : "galleryPicture": imageUrl
        };
        await userRepo.updateSingleField(json);
        if (isCertificate) {
          user.value.galleryCertificate = imageUrl;
        } else {
          user.value.galleryPicture = imageUrl;
        }

        user.refresh();
        FullScreenLoader.stopLoading();

        if (isCertificate) {
          TLoaders.successSnackBar(
              title: 'Done'.tr,
              message:
                  'Your gallery certificate is uploaded and waiting verification');
        } else {
          TLoaders.successSnackBar(
              title: 'Done'.tr, message: 'Your gallery picture is uploaded ');
        }
      }
    } catch (e) {
      FullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }
}
