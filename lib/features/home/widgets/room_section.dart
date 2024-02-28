import 'package:flutter/material.dart';

import 'package:furniture_store/common/widgets/section_description.dart';
import 'package:furniture_store/features/home/screens/categories_screen.dart';
import 'package:furniture_store/routes/routes.dart';
import 'package:furniture_store/utils/constants/image_strings.dart';
import 'package:get/get.dart';

class BuildRoomsSection extends StatelessWidget {
  const BuildRoomsSection({super.key});

  @override
  Widget build(BuildContext context) {
    var lang = Get.locale!.languageCode;

    final Map<String, String> listIteams = {
      'dinRoom'.tr: TImages.livingRoom,
      'bedRoom'.tr: TImages.bedRoom,
      'officeRoom'.tr: TImages.deskRoom,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BuildSectionDescription(
            sectionName: 'roomsSec'.tr, sectionDesc: 'roomsSecDesc'.tr),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: listIteams.entries.map((entry) {
              var sectionName = entry.key;
              var image = entry.value;

              return InkWell(
                onTap: () {
                  Navigator.of(context).push(createRoute(CategoriesPage(
                      categoryName: lang == 'ar'
                          ? 'غرف $sectionName'
                          : '$sectionName Room')));
                },
                child: Container(
                  width: 130,
                  height: 195,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      lang == 'ar'
                          ? Text('غرف\n$sectionName',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.black))
                          : Text('$sectionName\nRoom',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.black)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
