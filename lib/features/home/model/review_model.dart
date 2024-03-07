import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  String reviewerName;
  String reviewerImage;
  int rating;
  String comment;
  DateTime? date;

  Review({
    required this.reviewerName,
    required this.reviewerImage,
    required this.rating,
    required this.comment,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      reviewerName: json['reviewerName'] ?? '',
      reviewerImage: json['reviewerImage'] ?? '',
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      date: (json['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'reviewerName': reviewerName,
        'reviewerImage': reviewerImage,
        'rating': rating,
        'comment': comment,
        'date': Timestamp.fromDate(date ?? DateTime.now()),
      };
}
