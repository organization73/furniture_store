import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furniture_store/common/widgets/review_container.dart';
import 'package:furniture_store/data/repositories/product/product.dart';
import 'package:furniture_store/features/product/screens/add_review/add_review.dart';
import 'package:furniture_store/utils/constants/sizes.dart';
import 'package:get/get.dart';

class Reviews extends StatefulWidget {
  final Product product;

  const Reviews({super.key, required this.product});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Reviews",
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.pagePaddingSpace),
          child: ListView(
            children: [
              widget.product.rates.isNotEmpty
                  ? Column(
                      children: List.generate(
                        widget.product.rates.length,
                        (index) => Column(
                          children: [
                            ReviewContainer(
                              review: widget.product.rates[index],
                              profileImgUrl:
                                  'https://picsum.photos/id/1062/80/80',
                            ),
                            SizedBox(
                              height: 24.h,
                            )
                          ],
                        ),
                      ),
                    )
                  : SizedBox(
                      child: Text(
                        "There are no Reviews...",
                        style: TextStyle(
                            fontSize: 21.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 68,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ElevatedButton(
            onPressed: () => Get.to(
                  () => AddReview(product: widget.product),
                  duration: const Duration(milliseconds: 300),
                  transition: Transition.downToUp,
                ),
            child: const Text('Write your review')),
      ),
    );
  }
}
