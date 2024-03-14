import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordash/features/home/model/review_model.dart';
import 'package:decordash/features/home/model/vendor_model.dart';
import 'package:decordash/utils/constants/enums.dart';
import 'package:uuid/uuid.dart';

class ProductModel {
  String id;
  String sku;
  String productName;
  String categoryId;
  double productPrice;
  double productSalePrice;
  String productImage;
  bool onSale;
  ProductDetails productDetails;
  List<dynamic> rates = [];
  double productRating = 0;
  int productNumOfRating = 0;
  bool? isFeatured;

  ProductModel({
    required this.productName,
    required this.categoryId,
    required this.productPrice,
    required this.productSalePrice,
    required this.productImage,
    required this.onSale,
    required this.productDetails,
    this.rates = const [],
    this.isFeatured = false,
    required this.sku,
    String id = '',
  }) : id = id.isEmpty ? const Uuid().v4() : id {
    updateRates();
  }
  static ProductModel empty() => ProductModel(
        productName: '',
        id: '',
        categoryId: '',
        productPrice: 0.0,
        productSalePrice: 0.0,
        productImage: '',
        onSale: false,
        productDetails: ProductDetails(
            condition: '',
            color: '',
            productListImages: [],
            productSpecs: {},
            productDesc: '',
            productStats: ProductStats(
                delivery: false, negotiable: false, modifiable: false),
            productSeller: VendorModel(
                name: '',
                location: '',
                id: '',
                image: '',
                isFeatured: false,
                productsCount: 0,
                accountType: AccountType.regular)),
        sku: '',
      );

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

  Map<String, dynamic> toJson() => {
        'id': id,
        'productName': productName,
        'categoryId': categoryId,
        'productPrice': productPrice,
        'productSalePrice': productSalePrice,
        'sku': sku,
        'productImage': productImage,
        'onSale': onSale,
        'isFeatured': isFeatured,
        'rates': rates.map((rate) => rate.toJson()).toList(),
        'ProductDetails': productDetails.toJson(),
      };

  factory ProductModel.fromFirebaseDocument(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    if (snapshot.exists) {
      data['rates'] = List<dynamic>.from(data['rates'] ?? [])
          .map((rate) => Review.fromJson(rate))
          .toList();
      return ProductModel(
        id: snapshot.id,
        productName: data['productName'] ?? '',
        sku: data['sku'] ?? '',
        categoryId: data['categoryId'] ?? '',
        productPrice: data['productPrice']?.toDouble() ?? 0.0,
        productSalePrice: data['productSalePrice']?.toDouble() ?? 0.0,
        productImage: data['productImage'] ?? '',
        onSale: data['onSale'] ?? false,
        isFeatured: data['isFeatured'] ?? false,
        rates: data['rates'] ?? [],
        productDetails: ProductDetails.fromJson(data['ProductDetails'] ?? {}),
      );
    } else {
      return ProductModel.empty();
    }
  }
}

class ProductDetails {
  String condition;
  String color;
  List<String> productListImages;
  Map<String, String> productSpecs;
  String productDesc;
  ProductStats productStats;
  VendorModel productSeller;
  DateTime? date;

  ProductDetails({
    required this.condition,
    required this.color,
    required this.productListImages,
    required this.productSpecs,
    required this.productDesc,
    required this.productStats,
    required this.productSeller,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      condition: json['Condition'] ?? '',
      color: json['color'] ?? '',
      productListImages: List<String>.from(json['productListImages'] ?? []),
      productSpecs: Map<String, String>.from(json['productSpecs'] ?? {}),
      productDesc: json['productDesc'] ?? '',
      productStats: ProductStats.fromJson(json['productStats'] ?? {}),
      productSeller: VendorModel.fromJson(json['productSeller'] ?? {}),
      date: (json['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
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
        'date': Timestamp.fromDate(date ?? DateTime.now()),
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
