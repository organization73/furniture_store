import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:decordashapp/features/notifications/controllers/notifications_controller.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lottie/lottie.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var lang = Get.locale!.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'notif'.tr,
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => NotificationsController.instance.notiList.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      Lottie.asset(
                        'assets/animations/no_notification.json',
                        width: 300.r,
                        height: 300.r,
                        fit: BoxFit.fill,
                      ),
                      Text(
                        'noNotif'.tr,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: NotificationsController.instance.notiList.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) {
                        NotificationsController.instance
                            .removeNotification(index);
                      },
                      background: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.error,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: lang == 'ar'
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(15),
                          titleAlignment: ListTileTitleAlignment.titleHeight,
                          leading: Icon(
                            Iconsax.activity_copy,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          title: Text(
                            NotificationsController
                                .instance.notiList[index].title!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          subtitle: Text(
                            NotificationsController
                                .instance.notiList[index].subtitle!,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
