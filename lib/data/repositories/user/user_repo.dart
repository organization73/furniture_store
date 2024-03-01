import 'package:furniture_store/features/personalization/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserRepo extends GetxController {
  static UserRepo get instance => Get.find();

  Future<void> saveUserRecord(UserModel user) async {
    try {
      GetStorage().write('user_data', user.toJson());
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<UserModel?> getUserData() async {
    final userData = GetStorage().read('user_data');
    if (userData != null) {
      return UserModel.fromJson(userData);
    }
    return null;
  }
}
