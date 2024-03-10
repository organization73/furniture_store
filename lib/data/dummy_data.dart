import 'package:decordash/features/home/model/banners_model.dart';
import 'package:decordash/features/home/model/category_model.dart';
import 'package:decordash/features/home/model/product_model.dart';
import 'package:decordash/features/home/model/review_model.dart';
import 'package:decordash/features/home/model/vendor_model.dart';
import 'package:decordash/features/notifications/model/notifications_model.dart';
import 'package:decordash/utils/constants/enums.dart';
import 'package:decordash/utils/constants/image_strings.dart';

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
      productImage: 'TImages.productImage1',
      onSale: true,
      productDetails: ProductDetails(
        condition: 'used',
        color: 'red',
        productListImages: [
          'TImages.productImage2',
          'TImages.productImage3',
          'TImages.productImage4',
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
      productImage: 'TImages.productImage3',
      onSale: true,
      productDetails: ProductDetails(
        condition: 'new',
        color: 'White',
        productListImages: [
          'TImages.productImage2',
          'TImages.productImage3',
          'TImages.productImage4',
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
      productImage: 'TImages.productImage12',
      onSale: true,
      productDetails: ProductDetails(
        condition: 'new',
        color: 'red',
        productListImages: [
          'TImages.productImage2',
          'TImages.productImage3',
          'TImages.productImage4',
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
      productImage: 'TImages.productImage6',
      onSale: true,
      productDetails: ProductDetails(
        condition: 'new',
        color: 'red',
        productListImages: [
          'TImages.productImage2',
          'TImages.productImage3',
          'TImages.productImage4',
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
            name: 'Mohamed',
            location: 'Louxor',
            image: 'https://picsum.photos/id/1062/80/80',
            isFeatured: false,
            productsCount: 1,
            accountType: AccountType.regular),
      ),
    ),
    /////////////////////////////

    ProductModel(
      productName: 'Bedroom Red Bed',
      categoryId: '1',
      sku: 'AE525',
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
      productImage: 'TImages.productImage5',
      onSale: false,
      productDetails: ProductDetails(
        condition: 'used',
        color: 'red',
        productListImages: [
          'TImages.productImage2',
          'TImages.productImage3',
          'TImages.productImage4',
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
            image: 'https://picsum.photos/id/1062/80/80',
            isFeatured: false,
            productsCount: 1,
            accountType: AccountType.regular),
      ),
    ),

    ProductModel(
      productName: 'Bedroom Red Bed',
      categoryId: '1',
      sku: 'AE525',
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
      productImage: 'TImages.productImage5',
      onSale: false,
      productDetails: ProductDetails(
        condition: 'used',
        color: 'red',
        productListImages: [
          'TImages.productImage2',
          'TImages.productImage3',
          'TImages.productImage4',
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
            image: 'https://picsum.photos/id/1062/80/80',
            isFeatured: false,
            productsCount: 1,
            accountType: AccountType.regular),
      ),
    ),

    ProductModel(
      productName: 'Bedroom Red Bed',
      categoryId: '1',
      sku: 'AE525',
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
      productImage: 'TImages.productImage5',
      onSale: false,
      productDetails: ProductDetails(
        condition: 'used',
        color: 'red',
        productListImages: [
          'TImages.productImage2',
          'TImages.productImage3',
          'TImages.productImage4',
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
            image: 'https://picsum.photos/id/1062/80/80',
            isFeatured: false,
            productsCount: 1,
            accountType: AccountType.regular),
      ),
    ),
  ];

  static final List<BannersModel> banners = [
    BannersModel(image: 'TImages.banner1', active: false),
    BannersModel(image: 'TImages.banner2', active: true),
    BannersModel(image: 'TImages.banner3', active: true),
    BannersModel(image: 'TImages.banner4', active: true),
    BannersModel(image: 'TImages.banner5', active: true),
    BannersModel(image: 'TImages.banner6', active: true),
    BannersModel(image: 'TImages.banner7', active: true),
    BannersModel(image: 'TImages.banner8', active: false),
  ];

  static final List<CategoryModel> categories = [
    CategoryModel(
        id: '1', image: 'TImages.sportIcon', name: 'Sports', isFeatured: true),
    CategoryModel(
        id: '5',
        image: 'TImages.furnitureIcon',
        name: 'Funraniture',
        isFeatured: true),
    CategoryModel(
        id: '2',
        image: 'TImages.electronicsIcon',
        name: 'Electronics',
        isFeatured: true),
    CategoryModel(
        id: '3', image: 'TImages.clothIcon', name: 'Cloth', isFeatured: true),
    CategoryModel(
        id: '4', image: 'TImages.animalIcon', name: 'Animals', isFeatured: true),
    CategoryModel(
        id: '6', image: 'TImages.shoeIcon', name: 'Shoes', isFeatured: true),
    CategoryModel(
        id: '7',
        image: 'TImages.cosmeticsIcon',
        name: 'Cosmitics',
        isFeatured: true),
    CategoryModel(
        id: '14',
        image: 'TImages.jeweleryIcon',
        name: 'Jewerly',
        isFeatured: true),

    /// Sub Categories
    CategoryModel(
        id: '8',
        image: 'TImages.sportIcon',
        name: 'Sports Shoes',
        isFeatured: false,
        parentId: '1'),
    CategoryModel(
        id: '9',
        image: 'TImages.sportIcon',
        name: 'Track Suits',
        isFeatured: false,
        parentId: '1'),
    CategoryModel(
        id: '10',
        image: 'TImages.sportIcon',
        name: 'Sports Equipment',
        isFeatured: false,
        parentId: '1'),

    CategoryModel(
        id: '11',
        image: 'TImages.furnitureIcon',
        name: 'Bedroom Furniture',
        isFeatured: false,
        parentId: '5'),
    CategoryModel(
        id: '12',
        image: 'TImages.furnitureIcon',
        name: 'Kitchen Furniture',
        isFeatured: false,
        parentId: '5'),
    CategoryModel(
        id: '13',
        image: 'TImages.furnitureIcon',
        name: 'Office',
        isFeatured: false,
        parentId: '5'),

    CategoryModel(
        id: '14',
        image: 'TImages.electronicsIcon',
        name: 'Laptop',
        isFeatured: false,
        parentId: '2'),
    CategoryModel(
        id: '15',
        image: 'TImages.electronicsIcon',
        name: 'Mobile',
        isFeatured: false,
        parentId: '2'),

    CategoryModel(
        id: '16',
        image: 'TImages.clothIcon',
        name: 'Shirts',
        isFeatured: false,
        parentId: '3'),
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

  static final List<Notifications> notificationsList = [
    Notifications(
        title: 'The Best Title',
        subtitle:
            'Cure.Id veniam culpa officia aute dolor amet deserunt ex proident commodo'),
  ];

////////////////////////////////////
  // static final List<ProductCategoryModel> productCategories = [
  //   ProductCategoryModel(productId: '001', categoryId: '1'),
  //   ProductCategoryModel(productId: '001', categoryId: '8'),
  //   ProductCategoryModel(productId: '004', categoryId: '3'),
  //   ProductCategoryModel(productId: '002', categoryId: '3'),
  //   ProductCategoryModel(productId: '002', categoryId: '16'),
  //   ProductCategoryModel(productId: '003', categoryId: '3'),
  //   ProductCategoryModel(productId: '005', categoryId: '1'),
  //   ProductCategoryModel(productId: '005', categoryId: '8'),
  //   ProductCategoryModel(productId: '040', categoryId: '2'),
  //   ProductCategoryModel(productId: '040', categoryId: '15'),
  //   ProductCategoryModel(productId: '006', categoryId: '2'),
  //   ProductCategoryModel(productId: '007', categoryId: '4'),
  //   ProductCategoryModel(productId: '009', categoryId: '1'),
  //   ProductCategoryModel(productId: '009', categoryId: '8'),
  //   ProductCategoryModel(productId: '010', categoryId: '1'),
  //   ProductCategoryModel(productId: '010', categoryId: '8'),
  //   ProductCategoryModel(productId: '011', categoryId: '1'),
  //   ProductCategoryModel(productId: '011', categoryId: '8'),
  //   ProductCategoryModel(productId: '012', categoryId: '1'),
  //   ProductCategoryModel(productId: '012', categoryId: '8'),
  //   ProductCategoryModel(productId: '013', categoryId: '1'),
  //   ProductCategoryModel(productId: '013', categoryId: '8'),
  //   ProductCategoryModel(productId: '014', categoryId: '1'),
  //   ProductCategoryModel(productId: '014', categoryId: '9'),
  //   ProductCategoryModel(productId: '015', categoryId: '1'),
  //   ProductCategoryModel(productId: '015', categoryId: '9'),
  //   ProductCategoryModel(productId: '016', categoryId: '1'),
  //   ProductCategoryModel(productId: '016', categoryId: '9'),
  //   ProductCategoryModel(productId: '017', categoryId: '1'),
  //   ProductCategoryModel(productId: '017', categoryId: '9'),
  //   ProductCategoryModel(productId: '018', categoryId: '1'),
  //   ProductCategoryModel(productId: '018', categoryId: '10'),
  //   ProductCategoryModel(productId: '019', categoryId: '1'),
  //   ProductCategoryModel(productId: '019', categoryId: '10'),
  //   ProductCategoryModel(productId: '020', categoryId: '1'),
  //   ProductCategoryModel(productId: '020', categoryId: '10'),
  //   ProductCategoryModel(productId: '021', categoryId: '1'),
  //   ProductCategoryModel(productId: '021', categoryId: '10'),
  //   ProductCategoryModel(productId: '022', categoryId: '5'),
  //   ProductCategoryModel(productId: '022', categoryId: '11'),
  //   ProductCategoryModel(productId: '023', categoryId: '11'),
  //   ProductCategoryModel(productId: '023', categoryId: '5'),
  //   ProductCategoryModel(productId: '024', categoryId: '5'),
  //   ProductCategoryModel(productId: '024', categoryId: '11'),
  //   ProductCategoryModel(productId: '025', categoryId: '5'),
  //   ProductCategoryModel(productId: '025', categoryId: '11'),
  //   ProductCategoryModel(productId: '026', categoryId: '5'),
  //   ProductCategoryModel(productId: '026', categoryId: '12'),
  //   ProductCategoryModel(productId: '027', categoryId: '5'),
  //   ProductCategoryModel(productId: '027', categoryId: '12'),
  //   ProductCategoryModel(productId: '028', categoryId: '5'),
  //   ProductCategoryModel(productId: '028', categoryId: '12'),
  //   ProductCategoryModel(productId: '029', categoryId: '5'),
  //   ProductCategoryModel(productId: '029', categoryId: '13'),
  //   ProductCategoryModel(productId: '030', categoryId: '5'),
  //   ProductCategoryModel(productId: '030', categoryId: '13'),
  //   ProductCategoryModel(productId: '031', categoryId: '5'),
  //   ProductCategoryModel(productId: '031', categoryId: '13'),
  //   ProductCategoryModel(productId: '032', categoryId: '5'),
  //   ProductCategoryModel(productId: '032', categoryId: '13'),
  //   ProductCategoryModel(productId: '033', categoryId: '2'),
  //   ProductCategoryModel(productId: '033', categoryId: '14'),
  //   ProductCategoryModel(productId: '034', categoryId: '2'),
  //   ProductCategoryModel(productId: '034', categoryId: '14'),
  //   ProductCategoryModel(productId: '035', categoryId: '2'),
  //   ProductCategoryModel(productId: '035', categoryId: '14'),
  //   ProductCategoryModel(productId: '036', categoryId: '2'),
  //   ProductCategoryModel(productId: '036', categoryId: '14'),
  //   ProductCategoryModel(productId: '037', categoryId: '2'),
  //   ProductCategoryModel(productId: '037', categoryId: '15'),
  //   ProductCategoryModel(productId: '038', categoryId: '2'),
  //   ProductCategoryModel(productId: '038', categoryId: '15'),
  //   ProductCategoryModel(productId: '039', categoryId: '2'),
  //   ProductCategoryModel(productId: '039', categoryId: '15'),
  //   ProductCategoryModel(productId: '008', categoryId: '2'),
  // ];

  // static final List<VendorCategoryModel> vendorsCategory = [
  //   VendorCategoryModel(vendorId: '1', categoryId: '1'),
  //   VendorCategoryModel(vendorId: '1', categoryId: '8'),
  //   VendorCategoryModel(vendorId: '1', categoryId: '9'),
  //   VendorCategoryModel(vendorId: '1', categoryId: '10'),
  //   VendorCategoryModel(vendorId: '2', categoryId: '1'),
  //   VendorCategoryModel(vendorId: '2', categoryId: '8'),
  //   VendorCategoryModel(vendorId: '2', categoryId: '9'),
  //   VendorCategoryModel(vendorId: '2', categoryId: '10'),
  //   VendorCategoryModel(vendorId: '3', categoryId: '1'),
  //   VendorCategoryModel(vendorId: '3', categoryId: '8'),
  //   VendorCategoryModel(vendorId: '3', categoryId: '9'),
  //   VendorCategoryModel(vendorId: '3', categoryId: '10'),
  //   VendorCategoryModel(vendorId: '4', categoryId: '1'),
  //   VendorCategoryModel(vendorId: '4', categoryId: '8'),
  //   VendorCategoryModel(vendorId: '4', categoryId: '9'),
  //   VendorCategoryModel(vendorId: '4', categoryId: '10'),
  //   VendorCategoryModel(vendorId: '5', categoryId: '15'),
  //   VendorCategoryModel(vendorId: '5', categoryId: '2'),
  //   VendorCategoryModel(vendorId: '10', categoryId: '14'),
  //   VendorCategoryModel(vendorId: '10', categoryId: '2'),
  //   VendorCategoryModel(vendorId: '6', categoryId: '3'),
  //   VendorCategoryModel(vendorId: '6', categoryId: '16'),
  //   VendorCategoryModel(vendorId: '7', categoryId: '2'),
  //   VendorCategoryModel(vendorId: '8', categoryId: '5'),
  //   VendorCategoryModel(vendorId: '8', categoryId: '11'),
  //   VendorCategoryModel(vendorId: '8', categoryId: '12'),
  //   VendorCategoryModel(vendorId: '8', categoryId: '13'),
  //   VendorCategoryModel(vendorId: '9', categoryId: '5'),
  //   VendorCategoryModel(vendorId: '9', categoryId: '11'),
  //   VendorCategoryModel(vendorId: '9', categoryId: '12'),
  //   VendorCategoryModel(vendorId: '9', categoryId: '13'),
  // ];
}
