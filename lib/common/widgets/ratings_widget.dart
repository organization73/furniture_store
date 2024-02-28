import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

int userrate = 1;

class RatingWidget extends StatelessWidget {
  final int rating;

  const RatingWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        5,
        (index) => Row(
          children: [
            Icon(
              size: 18.w,
              index < rating ? Icons.star : Icons.star_border,
              color: index < rating ? Colors.amber : Colors.grey,
            ),
            SizedBox(
              width: 1.w,
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AddRatingWidget extends StatefulWidget {
  int rating;

  AddRatingWidget({super.key, required this.rating});

  @override
  State<AddRatingWidget> createState() => _AddRatingWidgetState();
}

class _AddRatingWidgetState extends State<AddRatingWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) => Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  widget.rating = index + 1;
                });
                userrate = index + 1;
              },
              icon: index < widget.rating
                  ? const Icon(Icons.star)
                  : const Icon(Icons.star_border),
              color: index < widget.rating ? Colors.amber : Colors.grey,
            ),
            SizedBox(
              width: 1.w,
            )
          ],
        ),
      ),
    );
  }
}
