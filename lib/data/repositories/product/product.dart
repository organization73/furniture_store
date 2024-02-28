class Product {
  String productName;
  double productPrice;
  double productRating = 0;
  int productNumOfRating = 0;
  List<dynamic> rates;
  String productImage;
  bool onSale;
  ProductDetails productDetails;

  Product({
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.onSale,
    required this.productDetails,
    required this.rates,
  }) {
    updateRates();
  }

  void updateRates() {
    if (rates.isEmpty) {
      productRating = 0;
    } else {
      double averageRate = 0;
      for (var element in rates) {
        averageRate += element.rating;
      }
      productRating = averageRate / rates.length;
    }

    productNumOfRating = rates.length;
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productName: json['productName'],
      productPrice: json['productPrice'].toDouble(),
      // productRating: json['productRating'].toDouble(),
      // productNumOfRating: json['productNumOfRating']??0,
      productImage: json['productImage'],
      rates: json['rates'],
      onSale: json['onSale'],
      productDetails: ProductDetails.fromJson(json['ProductDetails']),
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
      condition: json['Condition'],
      color: json['color'],
      productListImages: List<String>.from(json['productListImages']),
      productSpecs: Map<String, String>.from(json['productSpecs']),
      productDesc: json['productDesc'],
      productStats: ProductStats.fromJson(json['productStats']),
      productSeller: ProductSeller.fromJson(json['productSeller']),
    );
  }
}

class ProductStats extends Iterable {
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
      delivery: json['Delivery'],
      negotiable: json['Negotiable'],
      modifiable: json['Modifiable'],
    );
  }

  @override
  // TODO: implement iterator
  Iterator get iterator => throw UnimplementedError();
}

class ProductSeller {
  String name;

  ProductSeller({
    required this.name,
  });

  factory ProductSeller.fromJson(Map<String, dynamic> json) {
    return ProductSeller(
      name: json['name'],
    );
  }
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
      reviewerName: json['reviewer_name'],
      rating: json['rating'],
      comment: json['comment'],
      timestamp: json['timestamp'],
    );
  }
}
