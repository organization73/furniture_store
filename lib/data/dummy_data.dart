import 'package:furniture_store/features/home/model/banners_model.dart';
import 'package:furniture_store/features/home/model/category_model.dart';
import 'package:furniture_store/features/home/model/product_model.dart';
import 'package:furniture_store/features/home/model/review_model.dart';
import 'package:furniture_store/features/home/model/vendor_model.dart';
import 'package:furniture_store/utils/constants/enums.dart';
import 'package:furniture_store/utils/constants/image_strings.dart';

class DummyData {
  static final List<ProductModel> products = [
    ProductModel(
      productName: 'Bedroom Red Bed',
      categoryId: '1',
      sku: 'AE55',
      productPrice: 200,
      productSalePrice: 100,
      isFeatured: true,
      rates: [
        Review(
            reviewerName: 'John Doe',
            rating: 4,
            comment:
                'Great product! It exceeded my expectations. Highly recommended.',
            reviewerImage: 'https://picsum.photos/id/1066/80/80'),
        Review(
            reviewerName: 'Alice Smith',
            rating: 3,
            comment:
                'The product is good, but it could use some improvements. The packaging was damaged.',
            reviewerImage: 'https://picsum.photos/id/1062/80/80'),
        Review(
            reviewerName: 'Eva Johnson',
            rating: 5,
            comment:
                'Absolutely love it! The quality is excellent, and delivery was super fast.',
            reviewerImage: 'https://picsum.photos/id/80/80/80'),
      ],
      productImage: TImages.productImage1,
      onSale: false,
      productDetails: ProductDetails(
        condition: 'new',
        color: 'red',
        productListImages: [
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
        productSeller: VendorModel(
            name: 'Ahmed',
            location: 'Damietta',
            id: '1',
            image: 'https://picsum.photos/id/1062/80/80',
            isFeatured: false,
            productsCount: 1,
            accountType: AccountType.regular),
      ),
    ),
  
    ProductModel(
      productName: 'White comfy Chair',
      categoryId: '2',
      sku: 'AE55',
      productPrice: 350,
      productSalePrice: 300,
      isFeatured: true,
      rates: [
        Review(
            reviewerName: 'John Doe',
            rating: 4,
            comment:
                'Great product! It exceeded my expectations. Highly recommended.',
            reviewerImage: 'https://picsum.photos/id/1066/80/80'),
        Review(
            reviewerName: 'Alice Smith',
            rating: 3,
            comment:
                'The product is good, but it could use some improvements. The packaging was damaged.',
            reviewerImage: 'https://picsum.photos/id/1062/80/80'),
        
      ],
      productImage: TImages.productImage3,
      onSale: false,
      productDetails: ProductDetails(
        condition: 'new',
        color: 'White',
        productListImages: [
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
            'Comey chair with unrivaled comfort and a striking visual experience.',
        productStats: ProductStats(
          delivery: true,
          negotiable: false,
          modifiable: true,
        ),
        productSeller: VendorModel(
            name: 'Ali',
            location: 'Mansoura',
            id: '2',
            image: 'https://picsum.photos/id/1062/80/80',
            isFeatured: true,
            productsCount: 2,
            accountType: AccountType.vendor),
      ),
    ),
  
    ProductModel(
      productName: 'Bedroom Black Bed',
      categoryId: '1',
      sku: 'AE5445',
      productPrice: 600,
      productSalePrice: 520,
      isFeatured: true,
      rates: [
        Review(
            reviewerName: 'John Doe',
            rating: 4,
            comment:
                'Great product! It exceeded my expectations. Highly recommended.',
            reviewerImage: 'https://picsum.photos/id/1066/80/80'),
      
        Review(
            reviewerName: 'Eva Johnson',
            rating: 5,
            comment:
                'Absolutely love it! The quality is excellent, and delivery was super fast.',
            reviewerImage: 'https://picsum.photos/id/80/80/80'),
      ],
      productImage: TImages.productImage12,
      onSale: false,
      productDetails: ProductDetails(
        condition: 'new',
        color: 'red',
        productListImages: [
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
        productSeller: VendorModel(
            name: 'Kahled',
            location: 'Cairo',
            id: '4',
            image: 'https://picsum.photos/id/1062/80/80',
            isFeatured: false,
            productsCount: 1,
            accountType: AccountType.vendor),
      ),
    ),
  
    ProductModel(
      productName: 'Kitchen Dining Table',
      categoryId: '3',
      sku: 'AE5885',
      productPrice: 1000,
      productSalePrice: 800,
      isFeatured: true,
      rates: [
        Review(
            reviewerName: 'John Doe',
            rating: 4,
            comment:
                'Great product! It exceeded my expectations. Highly recommended.',
            reviewerImage: 'https://picsum.photos/id/1066/80/80'),
        Review(
            reviewerName: 'Alice Smith',
            rating: 3,
            comment:
                'The product is good, but it could use some improvements. The packaging was damaged.',
            reviewerImage: 'https://picsum.photos/id/1062/80/80'),
        Review(
            reviewerName: 'Eva Johnson',
            rating: 5,
            comment:
                'Absolutely love it! The quality is excellent, and delivery was super fast.',
            reviewerImage: 'https://picsum.photos/id/80/80/80'),
      ],
      productImage: TImages.productImage6,
      onSale: false,
      productDetails: ProductDetails(
        condition: 'new',
        color: 'red',
        productListImages: [
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
        productSeller: VendorModel(
            name: 'Ali',
            location: 'Damietta',
            id: '11',
            image: 'https://picsum.photos/id/1062/80/80',
            isFeatured: false,
            productsCount: 1,
            accountType: AccountType.regular),
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
