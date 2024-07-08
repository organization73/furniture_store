import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  String reviewerName;
  String reviewerImage;
  int rating;
  String comment;

  Review({
    required this.reviewerName,
    required this.reviewerImage,
    required this.rating,
    required this.comment,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      reviewerName: json['reviewerName'] ?? '',
      reviewerImage: json['reviewerImage'] ?? '',
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'reviewerName': reviewerName,
        'reviewerImage': reviewerImage,
        'rating': rating,
        'comment': comment,
      };
}
