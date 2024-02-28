import 'package:flutter/material.dart';
import 'package:furniture_store/common/widgets/ratings_widget.dart';
import 'package:furniture_store/data/repositories/product/product.dart';

import 'package:get/get.dart';

class AddReview extends StatefulWidget {
  final Product product;
  const AddReview({super.key, required this.product});

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  final TextEditingController _reviewController = TextEditingController();
  final FocusNode _reviewFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          "Write your review",
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AddRatingWidget(rating: 0),
              TextFormField(
                controller: _reviewController,
                focusNode: _reviewFocus,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Type your review here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your review';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 68,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // print(widget.product.rates.length);
                DateTime currentDateTime = DateTime.now();
                Review review = Review(
                  reviewerName: "UserClass",
                  rating: userrate,
                  comment: _reviewController.text,
                  timestamp:
                      '${currentDateTime.year}-${(currentDateTime.month)}-${(currentDateTime.day)}/'
                      '${(currentDateTime.hour % 12)}:${(currentDateTime.minute)} '
                      '${currentDateTime.hour < 12 ? 'AM' : 'PM'}',
                );
                widget.product.rates.add(review);

                //TODO: fix that the review lsit does not update, use state management
                Get.back();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('Please write a review'),
                  duration: Duration(milliseconds: 2500),
                ));
              }
            },
            child: Text('tContinue'.tr)),
      ),
    );
  }
}
