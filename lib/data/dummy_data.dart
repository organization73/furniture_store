import 'package:furniture_store/features/home/model/banners_model.dart';
import 'package:furniture_store/features/home/model/category_model.dart';
import 'package:furniture_store/features/home/model/product_model.dart';
import 'package:furniture_store/utils/constants/image_strings.dart';

class DummyData {
  static final List<ProductModel> products = [
    ProductModel(
      productName: 'Bedroom Red Bed',
      productPrice: 200,
      rates: [
        Review(
          reviewerName: 'John Doe',
          rating: 4,
          comment:
              'Great product! It exceeded my expectations. Highly recommended.',
          timestamp: "2023-12-15/2:25 AM",
        ),
        Review(
          reviewerName: 'Alice Smith',
          rating: 3,
          comment:
              'The product is good, but it could use some improvements. The packaging was damaged.',
          timestamp: "2023-12-15/2:25 AM",
        ),
        Review(
          reviewerName: 'Eva Johnson',
          rating: 5,
          comment:
              'Absolutely love it! The quality is excellent, and delivery was super fast.',
          timestamp: "2023-12-15/2:25 AM",
        ),
      ],
      productImage: TImages.productImage1,
      onSale: false,
      productDetails: ProductDetails(
        condition: 'used',
        color: 'red',
        productListImages: [
          TImages.productImage1,
          TImages.productImage2,
          TImages.productImage3,
          TImages.productImage4,
        ],
        productSpecs: {
          'ablakash': 'mdf',
          'fabric type': 'gg',
          'fabric density': 'fg',
          'wood type': 'Abs',
        },
        productDesc:
            'A big red bed with unrivaled comfort and a striking visual experience.',
        productStats: ProductStats(
          delivery: true,
          negotiable: false,
          modifiable: true,
        ),
        productSeller: ProductSeller(
          name: 'ahmed',
          location: 'Damieta',
        ),
      ),
    ),
  ];

  static final List<BannersModel> banners = [
    BannersModel(
        image:
            'https://assets.materialup.com/uploads/09b18322-202a-4acc-9706-84a91e3771e1/attachment.jpg',
        active: true),
    BannersModel(
        image:
            'https://t4.ftcdn.net/jpg/04/66/25/33/360_F_466253361_c4fAjCqVZD4L2boH8vfqjUbUYk0wLcP7.jpg',
        active: false),
    BannersModel(
        image:
            'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/furniture-banner-template-design-a636dbc0cd8fcad1e4f5c65dc3746501_screen.jpg?ts=1609919679',
        active: false),
  ];

  static final List<CategoryModel> categories = [
    CategoryModel(
        id: '1',
        image: TImages.chairsCategory,
        name: 'Chairs',
        isFeatured: true),
    CategoryModel(
        id: '2', image: TImages.desksCategory, name: 'Desks', isFeatured: true),
    CategoryModel(
        id: '3', image: TImages.sofasCategory, name: 'Sofas', isFeatured: true),

    //////////////////
    CategoryModel(
        id: '8',
        image: TImages.productImage1,
        name: 'Sofas',
        isFeatured: false,
        parentId: '1'),
  ];
}
