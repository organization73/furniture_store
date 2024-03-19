import 'package:decordash/utils/constants/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/repositories/authentication/authentication_repo.dart';
import 'package:decordash/data/repositories/user/user_repo.dart';
import 'package:decordash/features/authentication/screens/login/login_screen.dart';
import 'package:decordash/features/personalization/models/user_model.dart';
import 'package:decordash/features/personalization/screens/profile/widgets/re_auth_user_form.dart';
import 'package:decordash/utils/constants/sizes.dart';
import 'package:decordash/utils/helpers/network_manager.dart';
import 'package:decordash/utils/popups/full_screen_loader.dart';
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

  final userRepository = Get.put(UserRepo());

  @override
  onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserData();
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

          await userRepository.saveuserRecord(user);
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
                backgroundColor: Colors.red,
                side: const BorderSide(color: Colors.red)),
            child: const Text('Delete')),
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text('Cancel')));
  }

  void deleteUserAccount() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Processing', 'assets/animations/animation-of-docer.json');

      final auth = AuthenticatorRepo.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          FullScreenLoader.stopLoading();
          Get.offAll(
            () => const LoginSignUpScreen(),
            duration: const Duration(milliseconds: 300),
            transition: Transition.rightToLeft,
          );
        } else if (provider == 'password') {
          FullScreenLoader.stopLoading();
          Get.to(
            () => const ReAuthLoginForm(),
            duration: const Duration(milliseconds: 300),
            transition: Transition.rightToLeft,
          );
        } else if (provider == 'phone') {
          await auth.deleteAccount();
          FullScreenLoader.stopLoading();
          Get.offAll(
            () => const LoginSignUpScreen(),
            duration: const Duration(milliseconds: 300),
            transition: Transition.rightToLeft,
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
          'Processing', 'assets/animations/animation-of-docer.json');
      final isConnected = await NetworkManager.instance.isConnected();
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
      await AuthenticatorRepo.instance.deleteAccount();

      FullScreenLoader.stopLoading();
      Get.offAll(
        () => const LoginSignUpScreen(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.rightToLeft,
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

        final imageUrl =
            await userRepository.uploadImage('Users/Images/Profile/', image);

        Map<String, dynamic> json = {"avatar": imageUrl};
        await userRepository.updateSingleField(json);
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

  Future<void> uploadGalleryCertificate() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        final imageUrl = await userRepository.uploadImage(
            'Users/Images/Certificate/', image);

        Map<String, dynamic> json = {"galleryCertificate": imageUrl};
        await userRepository.updateSingleField(json);
        user.value.galleryCertificate = imageUrl;
        user.refresh();

        TLoaders.successSnackBar(
            title: 'Done'.tr,
            message:
                'Your gallery certificate is uploaded and waiting verification');
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }

  updateAccountType(int value) async {
    try {
      if (value == 1) {
        Map<String, dynamic> json = {"accountType": 'vendor'};
        await userRepository.updateSingleField(json);
        user.value.accountType = AccountType.vendor;
        user.refresh();
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    }
  }
}
