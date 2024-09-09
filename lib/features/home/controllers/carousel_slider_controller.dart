import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/data/repositories/banners/banners_repo.dart';
import 'package:decordashapp/features/home/model/banners_model.dart';
import 'package:get/get.dart';

class CustomeCarouselSliderController extends GetxController {
  static CustomeCarouselSliderController get instance => Get.find();

  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final _bannersRepo = Get.put(BannersRepo());

  RxList<BannersModel> banners = <BannersModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
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
