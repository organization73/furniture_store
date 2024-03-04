import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_store/common/widgets/loaders/loaders.dart';
import 'package:furniture_store/data/repositories/user/user_repo.dart';
import 'package:furniture_store/features/personalization/models/user_model.dart';

import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepo());

  Future<void> saveUserRecord(UserCredential? userCred) async {
    try {
      if (userCred != null) {
        final namePart = UserModel.nameParts(userCred.user!.displayName ?? '');
        final userName = UserModel.generateUsernameFromFullName(
            userCred.user!.displayName ?? '');

        final user = UserModel(
            id: userCred.user!.uid,
            firstName: namePart[0],
            lastName: namePart.length > 1 ? namePart.sublist(1).join(' ') : '',
            userName: userName,
            email: userCred.user!.email ?? '',
            phoneNumber: userCred.user!.phoneNumber ?? '',
            avatar: userCred.user!.photoURL ?? '');

        await userRepository.saveuserRecord(user);
      }
    } catch (e) {
      TLoaders.warningSnackBar(
          title: 'Data is not saved!',
          message: 'Something went wrong while saving you information');
    }
  }
}