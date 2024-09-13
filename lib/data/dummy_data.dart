import 'package:decordashapp/features/home/model/banners_model.dart';
import 'package:decordashapp/features/home/model/category_model.dart';
import 'package:decordashapp/features/home/model/product_category_model.dart';
import 'package:decordashapp/features/product/model/product_model.dart';
import 'package:decordashapp/features/home/model/review_model.dart';
import 'package:decordashapp/features/home/model/vendor_category_model.dart';
import 'package:decordashapp/features/home/model/vendor_model.dart';
import 'package:decordashapp/utils/constants/enums.dart';
import 'package:decordashapp/utils/constants/image_strings.dart';

class DummyData {
  static final List<ProductModel> products = [
    ProductModel(
      id: 'c001',
      productName: 'Wooden Stoole',
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
      productImage: 'assets/images/products/chairs/001.png',
      onSale: true,
      productDetails: ProductDetails(
        condition: 'used',
        color: "Color(0xff3897f1)",
        productListImages: [
          'assets/images/products/chairs/002.png',
          'assets/images/products/chairs/003.png'
        ],
        productSpecs: {
          'ablakash': 'mdf',
          'fabric type': 'cloth',
          'fabric density': '60',
          'wood type': 'Abs',
        },
        productDesc:
            'A big stoole chair with unrivaled comfort and a striking visual experience.',
        productStats: ProductStats(
          delivery: true,
          negotiable: false,
          modifiable: true,
        ),
        productSeller: VendorModel(
            id: '1',
            image: TImages.user,
            location: 'Damietta',
            name: 'Ali',
            accountType: AccountType.regular,
            isFeatured: true,
            productsCount: 2,
            isVerified: true),
      ),
    ),
    ProductModel(
      id: 'c002',
      productName: 'Wooden Chair With Rest Arms And Coushen',
      categoryId: '1',
      sku: 'AE54',
      productPrice: 450,
      productSalePrice: 375,
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
      productImage: 'assets/images/products/chairs/002.png',
      onSale: true,
      productDetails: ProductDetails(
        condition: 'new',
        color: "Color(0xff3820f1)",
        productListImages: [
          'assets/images/products/chairs/001.png',
          'assets/images/products/chairs/003.png'
        ],
        productSpecs: {
          'ablakash': 'mdf',
          'fabric type': 'cloth',
          'fabric density': '60',
          'wood type': 'Abs',
        },
        productDesc:
            'A big white chair with unrivaled comfort and a striking visual experience.',
        productStats: ProductStats(
          delivery: true,
          negotiable: true,
          modifiable: true,
        ),
        productSeller: VendorModel(
            id: '2',
            image: TImages.user,
            location: 'Cairo',
            name: 'Mohamed',
            accountType: AccountType.vendor,
            isFeatured: true,
            productsCount: 20,
            isVerified: false),
      ),
    ),
    ProductModel(
      id: 'c003',
      productName: 'Swivle Chair With Rest Arms',
      categoryId: '1',
      sku: 'AE51',
      productPrice: 520,
      productSalePrice: 450,
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
      productImage: 'assets/images/products/chairs/003.png',
      onSale: true,
      productDetails: ProductDetails(
        condition: 'new',
        color: "Color(0xff389744)",
        productListImages: [
          'assets/images/products/chairs/002.png',
          'assets/images/products/chairs/004.png'
        ],
        productSpecs: {
          'ablakash': 'mdf',
          'fabric type': 'cloth',
          'fabric density': '60',
          'wood type': 'Abs',
        },
        productDesc:
            'A big swivle chair with unrivaled comfort and a striking visual experience.',
        productStats: ProductStats(
          delivery: true,
          negotiable: true,
          modifiable: true,
        ),
        productSeller: VendorModel(
            id: '3',
            image: TImages.user,
            location: 'Louxor',
            name: 'Khaled',
            accountType: AccountType.regular,
            isFeatured: false,
            productsCount: 5,
            isVerified: false),
      ),
    ),
    ProductModel(
      id: 'c004',
      productName: 'Wooden Chair',
      categoryId: '1',
      sku: 'AE511',
      productPrice: 300,
      productSalePrice: 300,
      isFeatured: true,
      rates: [
        Review(
            reviewerName: 'John Doe',
            rating: 4,
            comment:
                'Great product! It exceeded my expectations. Highly recommended.',
            reviewerImage: 'https://picsum.photos/id/1066/80/80'),
      ],
      productImage: 'assets/images/products/chairs/004.png',
      onSale: false,
      productDetails: ProductDetails(
        condition: 'new',
        color: "Color(0xff6011f1)",
        productListImages: [
          'assets/images/products/chairs/002.png',
          'assets/images/products/chairs/003.png'
        ],
        productSpecs: {
          'ablakash': 'mdf',
          'fabric type': 'none',
          'fabric density': '0',
          'wood type': 'Abs',
        },
        productDesc:
            'A big wooden chair with unrivaled comfort and a striking visual experience.',
        productStats: ProductStats(
          delivery: true,
          negotiable: false,
          modifiable: false,
        ),
        productSeller: VendorModel(
            id: '4',
            image: TImages.user,
            location: 'Aswan',
            name: 'Samy',
            accountType: AccountType.vendor,
            isFeatured: false,
            productsCount: 10,
            isVerified: true),
      ),
    ),
    ProductModel(
      id: 's001',
      productName: 'Red Sofa',
      categoryId: '2',
      sku: 'AE558',
      productPrice: 1200,
      productSalePrice: 900,
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
      productImage: 'assets/images/products/sofas/001.png',
      onSale: true,
      productDetails: ProductDetails(
        condition: 'used',
        color: "Color(0xff3557001)",
        productListImages: [
          'assets/images/products/sofas/002.png',
          'assets/images/products/sofas/003.png'
        ],
        productSpecs: {
          'ablakash': 'mdf',
          'fabric type': 'cloth',
          'fabric density': '60',
          'wood type': 'Abs',
        },
        productDesc:
            'A big red sofa with unrivaled comfort and a striking visual experience.',
        productStats: ProductStats(
          delivery: true,
          negotiable: false,
          modifiable: true,
        ),
        productSeller: VendorModel(
            id: '1',
            image: TImages.user,
            location: 'Damietta',
            name: 'Ali',
            accountType: AccountType.regular,
            isFeatured: true,
            productsCount: 2,
            isVerified: true),
      ),
    ),
    ProductModel(
      id: 's002',
      productName: 'Wooden Sofa With Rest Arms And Coushen',
      categoryId: '2',
      sku: 'AE564',
      productPrice: 800,
      productSalePrice: 760,
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
      productImage: 'assets/images/products/sofas/002.png',
      onSale: true,
      productDetails: ProductDetails(
        condition: 'new',
        color: "Color(0xff4907f8)",
        productListImages: [
          'assets/images/products/sofas/001.png',
          'assets/images/products/sofas/003.png'
        ],
        productSpecs: {
          'ablakash': 'mdf',
          'fabric type': 'cloth',
          'fabric density': '60',
          'wood type': 'Abs',
        },
        productDesc:
            'A big black sofa with unrivaled comfort and a striking visual experience.',
        productStats: ProductStats(
          delivery: false,
          negotiable: true,
          modifiable: true,
        ),
        productSeller: VendorModel(
            id: '2',
            image: TImages.user,
            location: 'Cairo',
            name: 'Mohamed',
            accountType: AccountType.vendor,
            isFeatured: true,
            productsCount: 20,
            isVerified: false),
      ),
    ),
    ProductModel(
      id: 's003',
      productName: 'Sofa With Rest Arms',
      categoryId: '2',
      sku: 'AE51',
      productPrice: 520,
      productSalePrice: 450,
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
      productImage: 'assets/images/products/sofas/003.png',
      onSale: false,
      productDetails: ProductDetails(
        condition: 'new',
        color: "Color(0xff1291d1)",
        productListImages: [
          'assets/images/products/sofas/002.png',
          'assets/images/products/sofas/004.png'
        ],
        productSpecs: {
          'ablakash': 'mdf',
          'fabric type': 'cloth',
          'fabric density': '60',
          'wood type': 'Abs',
        },
        productDesc:
            'A big sofa with unrivaled comfort and a striking visual experience.',
        productStats: ProductStats(
          delivery: true,
          negotiable: true,
          modifiable: true,
        ),
        productSeller: VendorModel(
            id: '3',
            image: TImages.user,
            location: 'Louxor',
            name: 'Khaled',
            accountType: AccountType.regular,
            isFeatured: false,
            productsCount: 5,
            isVerified: false),
      ),
    ),
    ProductModel(
      id: 's004',
      productName: 'Living Sofa',
      categoryId: '1',
      sku: 'AE511',
      productPrice: 2300,
      productSalePrice: 1300,
      isFeatured: true,
      rates: [
        Review(
            reviewerName: 'John Doe',
            rating: 4,
            comment:
                'Great product! It exceeded my expectations. Highly recommended.',
            reviewerImage: 'https://picsum.photos/id/1066/80/80'),
      ],
      productImage: 'assets/images/products/sofas/004.png',
      onSale: false,
      productDetails: ProductDetails(
        condition: 'new',
        color: "Color(0xff3fffff)",
        productListImages: [
          'assets/images/products/sofas/002.png',
          'assets/images/products/sofas/003.png'
        ],
        productSpecs: {
          'ablakash': 'mdf',
          'fabric type': 'none',
          'fabric density': '0',
          'wood type': 'Abs',
        },
        productDesc:
            'A big living sofa chair with unrivaled comfort and a striking visual experience.',
        productStats: ProductStats(
          delivery: true,
          negotiable: false,
          modifiable: false,
        ),
        productSeller: VendorModel(
            id: '4',
            image: TImages.user,
            location: 'Aswan',
            name: 'Samy',
            accountType: AccountType.vendor,
            isFeatured: false,
            productsCount: 10,
            isVerified: true),
      ),
    ),
    ProductModel(
      id: 'b001',
      productName: 'Beige Big Sized Bed',
      categoryId: '3',
      sku: 'AE549958',
      productPrice: 900,
      productSalePrice: 850,
      isFeatured: true,
      rates: [
        Review(
            reviewerName: 'Alice Smith',
            rating: 3,
            comment:
                'The product is good, but it could use some improvements. The packaging was damaged.',
            reviewerImage: 'https://picsum.photos/id/1062/80/80'),
      ],
      productImage: 'assets/images/products/beds/001.png',
      onSale: true,
      productDetails: ProductDetails(
        condition: 'used',
        color: "Color(0xff236998)",
        productListImages: [
          'assets/images/products/beds/002.png',
          'assets/images/products/beds/003.png'
        ],
        productSpecs: {
          'ablakash': 'mdf',
          'fabric type': 'cloth',
          'fabric density': '60',
          'wood type': 'Abs',
        },
        productDesc:
            'A big beige sized bed with unrivaled comfort and a striking visual experience.',
        productStats: ProductStats(
          delivery: false,
          negotiable: false,
          modifiable: false,
        ),
        productSeller: VendorModel(
            id: '1',
            image: TImages.user,
            location: 'Damietta',
            name: 'Ali',
            accountType: AccountType.regular,
            isFeatured: true,
            productsCount: 2,
            isVerified: true),
      ),
    ),
    ProductModel(
      id: 'b002',
      productName: 'White And Blue Bed',
      categoryId: '3',
      sku: 'AE566463',
      productPrice: 800,
      productSalePrice: 760,
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
      productImage: 'assets/images/products/beds/002.png',
      onSale: true,
      productDetails: ProductDetails(
        condition: 'new',
        color: "Color(0xff3897f1)",
        productListImages: [
          'assets/images/products/beds/004.png',
          'assets/images/products/beds/003.png'
        ],
        productSpecs: {
          'ablakash': 'mdf',
          'fabric type': 'cloth',
          'fabric density': '60',
          'wood type': 'Abs',
        },
        productDesc:
            'A big bed with unrivaled comfort and a striking visual experience.',
        productStats: ProductStats(
          delivery: false,
          negotiable: true,
          modifiable: true,
        ),
        productSeller: VendorModel(
            id: '2',
            image: TImages.user,
            location: 'Cairo',
            name: 'Mohamed',
            accountType: AccountType.vendor,
            isFeatured: true,
            productsCount: 20,
            isVerified: false),
      ),
    ),
    ProductModel(
      id: 'b003',
      productName: 'Round Red Bed',
      categoryId: '3',
      sku: 'AE2251',
      productPrice: 520,
      productSalePrice: 450,
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
      productImage: 'assets/images/products/beds/003.png',
      onSale: false,
      productDetails: ProductDetails(
        condition: 'new',
        color: "Color(0xff3897f1)",
        productListImages: [
          'assets/images/products/beds/002.png',
          'assets/images/products/beds/001.png'
        ],
        productSpecs: {
          'ablakash': 'mdf',
          'fabric type': 'cloth',
          'fabric density': '60',
          'wood type': 'Abs',
        },
        productDesc:
            'A big round red with unrivaled comfort and a striking visual experience.',
        productStats: ProductStats(
          delivery: false,
          negotiable: true,
          modifiable: false,
        ),
        productSeller: VendorModel(
            id: '3',
            image: TImages.user,
            location: 'Louxor',
            name: 'Khaled',
            accountType: AccountType.regular,
            isFeatured: false,
            productsCount: 5,
            isVerified: false),
      ),
    ),
    ProductModel(
      id: 'b004',
      productName: 'White Small Bed',
      categoryId: '3',
      sku: 'AE51431',
      productPrice: 500,
      productSalePrice: 450,
      isFeatured: true,
      rates: [
        Review(
            reviewerName: 'John Doe',
            rating: 4,
            comment:
                'Great product! It exceeded my expectations. Highly recommended.',
            reviewerImage: 'https://picsum.photos/id/1066/80/80'),
      ],
      productImage: 'assets/images/products/beds/004.png',
      onSale: true,
      productDetails: ProductDetails(
        condition: 'new',
        color: "Color(0xff3897f1)",
        productListImages: [
          'assets/images/products/beds/002.png',
          'assets/images/products/beds/003.png'
        ],
        productSpecs: {
          'ablakash': 'mdf',
          'fabric type': 'none',
          'fabric density': '0',
          'wood type': 'Abs',
        },
        productDesc:
            'A big bed with unrivaled comfort and a striking visual experience.',
        productStats: ProductStats(
          delivery: false,
          negotiable: false,
          modifiable: false,
        ),
        productSeller: VendorModel(
            id: '4',
            image: TImages.user,
            location: 'Aswan',
            name: 'Samy',
            accountType: AccountType.vendor,
            isFeatured: false,
            productsCount: 10,
            isVerified: true),
      ),
    ),
    ProductModel(
      id: 't001',
      productName: 'Wooden Table',
      categoryId: '4',
      sku: 'AE54558',
      productPrice: 400,
      productSalePrice: 320,
      isFeatured: true,
      rates: [
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
      productImage: 'assets/images/products/tables/001.png',
      onSale: true,
      productDetails: ProductDetails(
        condition: 'used',
        color: "Color(0xff3897f1)",
        productListImages: [
          'assets/images/products/tables/002.png',
          'assets/images/products/tables/003.png'
        ],
        productSpecs: {
          'ablakash': 'mdf',
          'fabric type': 'cloth',
          'fabric density': '60',
          'wood type': 'Abs',
        },
        productDesc:
            'A big wooden table with unrivaled comfort and a striking visual experience.',
        productStats: ProductStats(
          delivery: false,
          negotiable: false,
          modifiable: true,
        ),
        productSeller: VendorModel(
            id: '1',
            image: TImages.user,
            location: 'Damietta',
            name: 'Ali',
            accountType: AccountType.regular,
            isFeatured: true,
            productsCount: 2,
            isVerified: true),
      ),
    ),
    ProductModel(
      id: 't002',
      productName: 'White Bedside Table',
      categoryId: '4',
      sku: 'AE5664',
      productPrice: 800,
      productSalePrice: 760,
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
      productImage: 'assets/images/products/tables/002.png',
      onSale: false,
      productDetails: ProductDetails(
        condition: 'used',
        color: "Color(0xff3897f1)",
        productListImages: [
          'assets/images/products/tables/004.png',
          'assets/images/products/tables/003.png'
        ],
        productSpecs: {
          'ablakash': 'mdf',
          'fabric type': 'cloth',
          'fabric density': '60',
          'wood type': 'Abs',
        },
        productDesc:
            'A big round bedside with unrivaled comfort and a striking visual experience.',
        productStats: ProductStats(
          delivery: false,
          negotiable: true,
          modifiable: true,
        ),
        productSeller: VendorModel(
            id: '2',
            image: TImages.user,
            location: 'Cairo',
            name: 'Mohamed',
            accountType: AccountType.vendor,
            isFeatured: true,
            productsCount: 20,
            isVerified: false),
      ),
    ),
    ProductModel(
      id: 't003',
      productName: 'Dining Table',
      categoryId: '4',
      sku: 'AE51',
      productPrice: 520,
      productSalePrice: 450,
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
      productImage: 'assets/images/products/tables/003.png',
      onSale: false,
      productDetails: ProductDetails(
        condition: 'used',
        color: "Color(0xff3897f1)",
        productListImages: [
          'assets/images/products/tables/002.png',
          'assets/images/products/tables/001.png'
        ],
        productSpecs: {
          'ablakash': 'mdf',
          'fabric type': 'cloth',
          'fabric density': '60',
          'wood type': 'Abs',
        },
        productDesc:
            'A big dining table with unrivaled comfort and a striking visual experience.',
        productStats: ProductStats(
          delivery: true,
          negotiable: true,
          modifiable: true,
        ),
        productSeller: VendorModel(
            id: '3',
            image: TImages.user,
            location: 'Louxor',
            name: 'Khaled',
            accountType: AccountType.regular,
            isFeatured: false,
            productsCount: 5,
            isVerified: false),
      ),
    ),
    ProductModel(
      id: 't004',
      productName: 'Desk Table',
      categoryId: '4',
      sku: 'AE511',
      productPrice: 1100,
      productSalePrice: 1000,
      isFeatured: true,
      rates: [
        Review(
            reviewerName: 'John Doe',
            rating: 4,
            comment:
                'Great product! It exceeded my expectations. Highly recommended.',
            reviewerImage: 'https://picsum.photos/id/1066/80/80'),
      ],
      productImage: 'assets/images/products/tables/004.png',
      onSale: false,
      productDetails: ProductDetails(
        condition: 'new',
        color: "Color(0xff3897f1)",
        productListImages: [
          'assets/images/products/tables/002.png',
          'assets/images/products/tables/003.png'
        ],
        productSpecs: {
          'ablakash': 'mdf',
          'fabric type': 'none',
          'fabric density': '0',
          'wood type': 'Abs',
        },
        productDesc:
            'A big living desk with unrivaled comfort and a striking visual experience.',
        productStats: ProductStats(
          delivery: true,
          negotiable: false,
          modifiable: false,
        ),
        productSeller: VendorModel(
            id: '4',
            image: TImages.user,
            location: 'Aswan',
            name: 'Samy',
            accountType: AccountType.vendor,
            isFeatured: false,
            productsCount: 10,
            isVerified: true),
      ),
    ),
  ];

  static final List<CategoryModel> categories = [
    CategoryModel(
        id: '1',
        image: 'assets/images/categories/chairs.png',
        name: 'Chairs',
        isFeatured: true),
    CategoryModel(
        id: '2',
        image: 'assets/images/categories/sofas.png',
        name: 'Sofas',
        isFeatured: true),
    CategoryModel(
        id: '3',
        image: 'assets/images/categories/beds.png',
        name: 'Beds',
        isFeatured: true),
    CategoryModel(
        id: '4',
        image: 'assets/images/categories/tables.png',
        name: 'Tables',
        isFeatured: true),

    /// Rooms
    CategoryModel(
      id: '8',
      image: 'assets/images/categories/living_room.png',
      name: 'Living Room',
      isFeatured: false,
      isRoom: true,
    ),
    CategoryModel(
      id: '9',
      image: 'assets/images/categories/bed_room.png',
      name: 'Bed Room',
      isFeatured: false,
      isRoom: true,
    ),
    CategoryModel(
      id: '10',
      image: 'assets/images/categories/desk_room.png',
      name: 'Desk Room',
      isFeatured: false,
      isRoom: true,
    ),

    /// Sub Categories
    CategoryModel(
        id: '11',
        image: 'assets/images/categories/chairs.png',
        name: 'Wooden Chairs',
        isFeatured: false,
        parentId: '1'),
    CategoryModel(
        id: '12',
        image: 'assets/images/categories/chairs.png',
        name: 'Swivle Chairs',
        isFeatured: false,
        parentId: '1'),
    CategoryModel(
        id: '13',
        image: 'assets/images/categories/chairs.png',
        name: 'Stools',
        isFeatured: false,
        parentId: '1'),

    CategoryModel(
        id: '21',
        image: 'assets/images/categories/sofas.png',
        name: 'Couches',
        isFeatured: false,
        parentId: '2'),
    CategoryModel(
        id: '22',
        image: 'assets/images/categories/sofas.png',
        name: 'Longue Couches',
        isFeatured: false,
        parentId: '2'),

    CategoryModel(
        id: '31',
        image: 'assets/images/categories/beds.png',
        name: 'Regular Beds',
        isFeatured: false,
        parentId: '3'),

    CategoryModel(
        id: '41',
        image: 'assets/images/categories/tables.png',
        name: 'wooden Tables',
        isFeatured: false,
        parentId: '4'),
    CategoryModel(
        id: '42',
        image: 'assets/images/categories/tables.png',
        name: 'Dining Tables',
        isFeatured: false,
        parentId: '4'),
    CategoryModel(
        id: '43',
        image: 'assets/images/categories/tables.png',
        name: 'Desks',
        isFeatured: false,
        parentId: '4'),
    CategoryModel(
        id: '44',
        image: 'assets/images/categories/tables.png',
        name: 'Bedside Tables',
        isFeatured: false,
        parentId: '4'),
  ];

  static final List<VendorModel> vendors = [
    VendorModel(
        id: '1',
        image: TImages.user,
        location: 'Damietta',
        name: 'Ali',
        accountType: AccountType.regular,
        isFeatured: true,
        productsCount: 2,
        isVerified: true),
    VendorModel(
        id: '2',
        image: TImages.user,
        location: 'Cairo',
        name: 'Mohamed',
        accountType: AccountType.vendor,
        isFeatured: true,
        productsCount: 20,
        isVerified: false),
    VendorModel(
        id: '3',
        image: TImages.user,
        location: 'Louxor',
        name: 'Khaled',
        accountType: AccountType.regular,
        isFeatured: false,
        productsCount: 5,
        isVerified: false),
    VendorModel(
        id: '4',
        image: TImages.user,
        location: 'Aswan',
        name: 'Samy',
        accountType: AccountType.vendor,
        isFeatured: false,
        productsCount: 10,
        isVerified: true),
    VendorModel(
        id: '5',
        image: TImages.user,
        location: 'Alexendaria',
        name: 'Ahmed',
        accountType: AccountType.vendor,
        isFeatured: false,
        productsCount: 8,
        isVerified: true),
    VendorModel(
        id: '6',
        image: TImages.user,
        location: 'Port Said',
        name: 'Mena',
        accountType: AccountType.vendor,
        isFeatured: true,
        productsCount: 2,
        isVerified: false),
    VendorModel(
        id: '7',
        image: TImages.user,
        location: 'Marsa Matroh',
        name: 'Youssef',
        accountType: AccountType.vendor,
        isFeatured: false,
        productsCount: 2,
        isVerified: true),
    VendorModel(
        id: '8',
        image: TImages.user,
        location: 'Esmailia',
        name: 'Salem',
        accountType: AccountType.regular,
        isFeatured: false,
        productsCount: 2,
        isVerified: true),
    VendorModel(
        id: '9',
        image: TImages.user,
        location: 'Menya',
        name: 'Ashraf',
        accountType: AccountType.regular,
        isFeatured: true,
        productsCount: 2,
        isVerified: false),
    VendorModel(
        id: '10',
        image: TImages.user,
        location: 'Rafh',
        name: 'Mossad',
        accountType: AccountType.vendor,
        isFeatured: true,
        productsCount: 2,
        isVerified: false),
    VendorModel(
        id: '11',
        image: TImages.user,
        location: 'Kafr El Sheikh',
        name: 'Mohey',
        accountType: AccountType.vendor,
        isFeatured: true,
        productsCount: 26,
        isVerified: false),
    VendorModel(
        id: '12',
        image: TImages.user,
        location: 'Kafr Said',
        name: 'Reda',
        accountType: AccountType.vendor,
        isFeatured: false,
        productsCount: 2,
        isVerified: false),
  ];

  static final List<ProductCategoryModel> productCategories = [
    ProductCategoryModel(productId: 'c001', categoryId: '11'),
    ProductCategoryModel(productId: 'c001', categoryId: '1'),
    ProductCategoryModel(productId: 'c002', categoryId: '1'),
    ProductCategoryModel(productId: 'c002', categoryId: '12'),
    ProductCategoryModel(productId: 'c003', categoryId: '1'),
    ProductCategoryModel(productId: 'c003', categoryId: '13'),
    ProductCategoryModel(productId: 'c004', categoryId: '1'),
    ProductCategoryModel(productId: 'c004', categoryId: '11'),
    ProductCategoryModel(productId: 's001', categoryId: '2'),
    ProductCategoryModel(productId: 's001', categoryId: '21'),
    ProductCategoryModel(productId: 's002', categoryId: '2'),
    ProductCategoryModel(productId: 's002', categoryId: '22'),
    ProductCategoryModel(productId: 's003', categoryId: '2'),
    ProductCategoryModel(productId: 's003', categoryId: '22'),
    ProductCategoryModel(productId: 's004', categoryId: '2'),
    ProductCategoryModel(productId: 's004', categoryId: '21'),
    ProductCategoryModel(productId: 'b001', categoryId: '3'),
    ProductCategoryModel(productId: 'b001', categoryId: '31'),
    ProductCategoryModel(productId: 'b002', categoryId: '3'),
    ProductCategoryModel(productId: 'b002', categoryId: '31'),
    ProductCategoryModel(productId: 'b003', categoryId: '3'),
    ProductCategoryModel(productId: 'b003', categoryId: '31'),
    ProductCategoryModel(productId: 'b004', categoryId: '3'),
    ProductCategoryModel(productId: 'b004', categoryId: '31'),
    ProductCategoryModel(productId: 't001', categoryId: '4'),
    ProductCategoryModel(productId: 't001', categoryId: '41'),
    ProductCategoryModel(productId: 't002', categoryId: '4'),
    ProductCategoryModel(productId: 't002', categoryId: '44'),
    ProductCategoryModel(productId: 't003', categoryId: '4'),
    ProductCategoryModel(productId: 't003', categoryId: '42'),
    ProductCategoryModel(productId: 't004', categoryId: '4'),
    ProductCategoryModel(productId: 't004', categoryId: '43'),
  ];

  static final List<VendorCategoryModel> vendorsCategory = [
    VendorCategoryModel(vendorId: '1', categoryId: '1'),
    VendorCategoryModel(vendorId: '1', categoryId: '2'),
    VendorCategoryModel(vendorId: '2', categoryId: '3'),
    VendorCategoryModel(vendorId: '2', categoryId: '4'),
    VendorCategoryModel(vendorId: '2', categoryId: '1'),
    VendorCategoryModel(vendorId: '3', categoryId: '4'),
    VendorCategoryModel(vendorId: '4', categoryId: '1'),
    VendorCategoryModel(vendorId: '4', categoryId: '3'),
    VendorCategoryModel(vendorId: '4', categoryId: '2'),
    VendorCategoryModel(vendorId: '5', categoryId: '2'),
    VendorCategoryModel(vendorId: '10', categoryId: '4'),
    VendorCategoryModel(vendorId: '10', categoryId: '2'),
    VendorCategoryModel(vendorId: '6', categoryId: '3'),
    VendorCategoryModel(vendorId: '7', categoryId: '2'),
    VendorCategoryModel(vendorId: '8', categoryId: '1'),
    VendorCategoryModel(vendorId: '8', categoryId: '3'),
    VendorCategoryModel(vendorId: '9', categoryId: '1'),
  ];

  static final List<BannersModel> banners = [
    BannersModel(image: 'assets/banners/chairs.jpg', active: true),
    BannersModel(image: 'assets/banners/chairs2.jpg', active: true),
    BannersModel(image: 'assets/banners/sofas.jpg', active: true),
    BannersModel(image: 'assets/banners/sofas2.jpg', active: false),
    BannersModel(image: 'assets/banners/decor.jpg', active: false),
  ];
}
