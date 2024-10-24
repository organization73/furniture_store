import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/data/repositories/banners/banners_repo.dart';
import 'package:decordashapp/modules/home/model/banners_model.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  final isLoading = false.obs;
  final _bannersRepo = Get.put(BannersRepo());

  RxList<BannersModel> banners = <BannersModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;

      final banners = await _bannersRepo.fetchBanners();

      this.banners.assignAll(banners);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'ohSnap'.tr, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
