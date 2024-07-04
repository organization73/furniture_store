import 'package:decordash/common/widgets/icons/circular_icon.dart';
import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/utils/http/http_client.dart';
import 'package:decordash/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ReportIcon extends StatelessWidget {
  const ReportIcon({super.key, required this.productId});
  final String productId;
  @override
  Widget build(BuildContext context) {
    return CicularIcon(
      width: 35.r,
      height: 35.r,
      icon: Iconsax.warning_2,
      color: Theme.of(context).colorScheme.error,
      onPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Report Product'),
              content: const Text(
                  'Are you sure you want to report this product for review?'),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Report'),
                  onPressed: () async {
                    // Perform the report action here
                    Navigator.of(context).pop();
                    FullScreenLoader.openLoadingDialog("Reporting",
                        'assets/animations/animation-of-docer.json');
                    try {
                      await THttpHelper.postBearerAuth("product/report-product",
                          GetStorage().read("token"), {"productId": productId});
                      FullScreenLoader.stopLoading();
                      TLoaders.successSnackBar(
                          title: "Report Sent Successfully");
                    } catch (e) {
                      FullScreenLoader.stopLoading();
                      TLoaders.errorSnackBar(
                          title:
                              "error happing while tring to report, please try again");
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
