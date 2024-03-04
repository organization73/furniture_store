import 'package:flutter/material.dart';
import 'package:furniture_store/features/gallery/screens/all_galleries/widgets/gallery_card.dart';
import 'package:furniture_store/features/gallery/model/static_data.dart';
import 'package:furniture_store/utils/constants/sizes.dart';

class AllGalleriesPage extends StatelessWidget {
  const AllGalleriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.pagePaddingSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Find Thousands of Products\n",
                          style: Theme.of(context).textTheme.bodyLarge),
                      TextSpan(
                          text: "Form Mulltiple Galleries",
                          style: Theme.of(context).textTheme.headlineLarge),
                    ],
                  ),
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: TSizes.spaceBtwItems,
                    );
                  },
                  itemCount: StaticData.sampleProperties.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GalleryCard(
                      gallery: StaticData.sampleProperties[index],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
