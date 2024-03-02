import 'package:get/get.dart';
import 'package:furniture_store/features/personalization/models/user_model.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  final GetStorage _storage = GetStorage();
  final Rx<UserModel?> _user = Rx<UserModel?>(null);

  UserModel? get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  void _loadUserData() {
    final userData = _storage.read('user_data');
    if (userData != null) {
      _user.value = UserModel.fromJson(userData);
    }
  }

  void updateUser(UserModel user) {
    _user.value = user;
    _storage.write('user_data', user.toJson());
  }
}

// class UserController extends GetxController {
//   static UserController get instance => Get.find();

  

//   // final userRepository = Get.put(UserRepo());

//   // Future<void> saveUserRecord(UserCredential? userCred) async {
//   //   try {
//   //     if (userCred != null) {
//   //       final namePart = UserModel.nameParts(userCred.user!.displayName ?? '');
//   //       final userName = UserModel.generateUsernameFromFullName(
//   //           userCred.user!.displayName ?? '');

//   //       final user = UserModel(
//   //           id: userCred.user!.uid,
//   //           firstName: namePart[0],
//   //           lastName: namePart.length > 1 ? namePart.sublist(1).join(' ') : '',
//   //           userName: userName,
//   //           email: userCred.user!.email ?? '',
//   //           phoneNumber: userCred.user!.phoneNumber ?? '',
//   //           avatar: userCred.user!.photoURL ?? '');

//   //       await userRepository.saveuserRecord(user);
//   //     }
//   //   } catch (e) {
//   //     TLoaders.warningSnackBar(
//   //         title: 'Data is not saved!',
//   //         message: 'Something went wrong while saving you information');
//   //   }
//   // }
// }
