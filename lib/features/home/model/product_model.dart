import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ProductModel {
  final String id;
  late String productName;
  late double productPrice;
  late String productImage;
  late bool onSale;
  late ProductDetails productDetails;
  List<dynamic> rates = [];
  double productRating = 0;
  int productNumOfRating = 0;

  ProductModel({
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.onSale,
    required this.productDetails,
    this.rates = const [],
    String id = '',
  }) : id = id.isEmpty ? const Uuid().v4() : id {
    updateRates();
  }

  void updateRates() {
    if (rates.isEmpty) {
      productRating = 0;
      productNumOfRating = 0;
    } else {
      productRating = rates.map((rate) => rate.rating).reduce((a, b) => a + b) /
          rates.length;
      productNumOfRating = rates.length;
    }
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      productName: json['productName'] ?? '',
      productPrice: json['productPrice']?.toDouble() ?? 0.0,
      productImage: json['productImage'] ?? '',
      onSale: json['onSale'] ?? false,
      rates: List<dynamic>.from(json['rates'] ?? []),
      productDetails: ProductDetails.fromJson(json['ProductDetails'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'productName': productName,
        'productPrice': productPrice,
        'productImage': productImage,
        'onSale': onSale,
        'rates': rates.map((rate) => rate.toJson()).toList(),
        'ProductDetails': productDetails.toJson(),
      };

  factory ProductModel.fromFirebaseDocument(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    if (snapshot.exists) {
      return ProductModel(
        id: snapshot.id,
        productName: data['productName'] ?? '',
        productPrice: data['productPrice']?.toDouble() ?? 0.0,
        productImage: data['productImage'] ?? '',
        onSale: data['onSale'] ?? false,
        rates: data['rates'] ?? [],
        productDetails: ProductDetails.fromJson(data['ProductDetails'] ?? {}),
      );
    } else {
      return ProductModel(
        id: '',
        productName: '',
        productPrice: 0.0,
        productImage: '',
        onSale: false,
        rates: [],
        productDetails: ProductDetails(
          condition: '',
          color: '',
          productListImages: [],
          productSpecs: {},
          productDesc: '',
          productStats: ProductStats(
              delivery: false, negotiable: false, modifiable: false),
          productSeller: ProductSeller(name: '', location: ''),
        ),
      );
    }
  }

  ProductModel copyWith({
    String? id,
    String? productName,
    double? productPrice,
    String? productImage,
    bool? onSale,
    List<dynamic>? rates,
    ProductDetails? productDetails,
  }) {
    return ProductModel(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      productImage: productImage ?? this.productImage,
      onSale: onSale ?? this.onSale,
      rates: rates ?? this.rates,
      productDetails: productDetails ?? this.productDetails,
    );
  }
}

class ProductDetails {
  String condition;
  String color;
  List<String> productListImages;
  Map<String, String> productSpecs;
  String productDesc;
  ProductStats productStats;
  ProductSeller productSeller;

  ProductDetails({
    required this.condition,
    required this.color,
    required this.productListImages,
    required this.productSpecs,
    required this.productDesc,
    required this.productStats,
    required this.productSeller,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      condition: json['Condition'] ?? '',
      color: json['color'] ?? '',
      productListImages: List<String>.from(json['productListImages'] ?? []),
      productSpecs: Map<String, String>.from(json['productSpecs'] ?? {}),
      productDesc: json['productDesc'] ?? '',
      productStats: ProductStats.fromJson(json['productStats'] ?? {}),
      productSeller: ProductSeller.fromJson(json['productSeller'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'Condition': condition,
        'color': color,
        'productListImages': productListImages,
        'productSpecs': productSpecs,
        'productDesc': productDesc,
        'productStats': productStats.toJson(),
        'productSeller': productSeller.toJson(),
      };
}

class ProductStats {
  bool delivery;
  bool negotiable;
  bool modifiable;

  ProductStats({
    required this.delivery,
    required this.negotiable,
    required this.modifiable,
  });

  factory ProductStats.fromJson(Map<String, dynamic> json) {
    return ProductStats(
      delivery: json['Delivery'] ?? false,
      negotiable: json['Negotiable'] ?? false,
      modifiable: json['Modifiable'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'Delivery': delivery,
        'Negotiable': negotiable,
        'Modifiable': modifiable,
      };
}

class ProductSeller {
  String name;
  String location;

  ProductSeller({
    required this.name,
    required this.location,
  });

  factory ProductSeller.fromJson(Map<String, dynamic> json) {
    return ProductSeller(
      name: json['name'] ?? '',
      location: json['location'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'location': location,
      };
}

class Review {
  String reviewerName;
  int rating;
  String comment;
  String timestamp;

  Review({
    required this.reviewerName,
    required this.rating,
    required this.comment,
    required this.timestamp,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      reviewerName: json['reviewer_name'] ?? '',
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'reviewer_name': reviewerName,
        'rating': rating,
        'comment': comment,
        'timestamp': timestamp,
      };
}
