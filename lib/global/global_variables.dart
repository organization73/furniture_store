import 'package:furniture_store/data/repositories/product/product.dart';

List<dynamic> allProductsList = [
  Product.fromJson({
    'productName': 'Sverom chair 1',
    'productPrice': 200,
    'rates': [
      Review.fromJson({
        'reviewer_name': 'John Doe',
        'rating': 4,
        'comment':
            'Great product! It exceeded my expectations. Highly recommended.',
        'timestamp': "2023-12-15/2:25 AM"
      }),
      Review.fromJson({
        'reviewer_name': 'Alice Smith',
        'rating': 3,
        'comment':
            'The product is good, but it could use some improvements. The packaging was damaged.',
        'timestamp': "2023-12-15/2:25 AM"
      }),
      Review.fromJson({
        'reviewer_name': 'Eva Johnson',
        'rating': 5,
        'comment':
            'Absolutely love it! The quality is excellent, and delivery was super fast.',
        'timestamp': "2023-12-15/2:25 AM"
      })
    ],
    'productImage': 'assets/images/products/product1.png',
    'onSale': false,
    'ProductDetails': {
      'Condition': 'used',
      'color': 'red',
      'productListImages': [
        'assets/images/products/product1.png',
        'assets/images/products/product2.png',
        'assets/images/products/product3.png'
      ],
      'productSpecs': {
        'ablakash': 'mdf',
        'fabric type': 'gg',
        'fabric density': 'fg',
        'Wood type': 'Abs',
      },
      'productDesc':
          'White coated chair combines a full-length React foam midsole for unrivaled comfort and a striking visual experience.',
      'productStats': {
        'Delivery': true,
        'Negotiable': false,
        'Modifiable': true
      },
      'productSeller': {'name': 'ahmed'}
    },
  }),
  Product.fromJson({
    'productName': 'Sverom chair 2',
    'productPrice': 100,
    'rates': [
      Review.fromJson({
        'reviewer_name': 'Eva Johnson',
        'rating': 5,
        'comment':
            'Absolutely love it! The quality is excellent, and delivery was super fast.',
        'timestamp': "2023-12-15/2:25 AM"
      }),
      Review.fromJson({
        'reviewer_name': 'Michael Brown',
        'rating': 3,
        'comment':
            'Solid product overall. Had a minor issue, but customer service was quick to resolve it.',
        'timestamp': "2023-12-15/2:25 AM"
      }),
      Review.fromJson({
        'reviewer_name': 'Sophie Miller',
        'rating': 2,
        'comment':
            'Impressive quality! I\'m happy with my purchase. Fast shipping too.',
        'timestamp': "2023-12-15/2:25 AM"
      }),
      Review.fromJson({
        'reviewer_name': 'David White',
        'rating': 3,
        'comment':
            'Decent product for the price. However, it took longer than expected to arrive.',
        'timestamp': "2023-12-15/2:25 AM"
      })
    ],
    'productImage': 'assets/images/products/product2.png',
    'onSale': false,
    'ProductDetails': {
      'Condition': 'new',
      'color': 'blue',
      'productListImages': [
        'assets/images/products/product2.png',
        'assets/images/products/product3.png',
        'assets/images/products/product1.png'
      ],
      'productSpecs': {
        'ablakash': 'lol',
        'fabric type': 'lol',
        'fabric density': 'bos',
        'Wood type': 'gerbnm',
      },
      'productDesc':
          'White coated chair combines a full-length React foam midsole for unrivaled comfort and a striking visual experience.',
      'productStats': {
        'Delivery': false,
        'Negotiable': false,
        'Modifiable': true
      },
      'productSeller': {'name': 'ahmed'}
    },
  }),
  Product.fromJson({
    'productName': 'Sverom chair 3',
    'productPrice': 400,
    'rates': [
      Review.fromJson({
        'reviewer_name': 'Olivia Taylor',
        'rating': 4,
        'comment':
            'Really impressed with the product. Its exactly what I was looking for. Fast delivery too!',
        'timestamp': "2023-12-15/2:25 AM"
      }),
      Review.fromJson({
        'reviewer_name': 'Daniel Harris',
        'rating': 2,
        'comment':
            'Disappointed. The product didn\'t meet my expectations. Quality could be better.',
        'timestamp': "2023-12-15/2:25 AM"
      }),
      Review.fromJson({
        'reviewer_name': 'Emma Clark',
        'rating': 5,
        'comment':
            'Fantastic product! The packaging was secure, and it arrived earlier than expected.',
        'timestamp': "2023-12-15/2:25 AM"
      }),
      Review.fromJson({
        'reviewer_name': 'Ryan Turner',
        'rating': 4,
        'comment':
            'Overall a good purchase. Some minor issues, but nothing major. Satisfied.',
        'timestamp': "2023-12-15/2:25 AM"
      }),
      Review.fromJson({
        'reviewer_name': 'Sophia Adams',
        'rating': 3,
        'comment':
            'The product is okay. Not exceptional, but it serves its purpose. Average quality.',
        'timestamp': "2023-12-15/2:25 AM"
      })
    ],
    'productImage': 'assets/images/products/product3.png',
    'onSale': false,
    'ProductDetails': {
      'Condition': 'new',
      'color': 'pink',
      'productListImages': [
        'assets/images/products/product3.png',
        'assets/images/products/product2.png',
        'assets/images/products/product1.png'
      ],
      'productSpecs': {
        'ablakash': 'asefefe',
        'fabric type': 'gsfwefg',
        'fabric density': 'fvsvsvg',
        'Wood type': 'Asvdsvbs',
      },
      'productDesc':
          'White coated chair combines a full-length React foam midsole for unrivaled comfort and a striking visual experience.',
      'productStats': {
        'Delivery': false,
        'Negotiable': false,
        'Modifiable': false
      },
      'productSeller': {'name': 'ahmed'}
    },
  }),
  Product.fromJson({
    'productName': 'Sverom chair 4',
    'productPrice': 150,
    'rates': [
      Review.fromJson({
        'reviewer_name': 'Olivia Taylor',
        'rating': 4,
        'comment':
            'Really impressed with the product. Its exactly what I was looking for. Fast delivery too!',
        'timestamp': "2023-12-15/2:25 AM"
      }),
      Review.fromJson({
        'reviewer_name': 'Daniel Harris',
        'rating': 2,
        'comment':
            'Disappointed. The product didn\'t meet my expectations. Quality could be better.',
        'timestamp': "2023-12-15/2:25 AM"
      }),
      Review.fromJson({
        'reviewer_name': 'Emma Clark',
        'rating': 5,
        'comment':
            'Fantastic product! The packaging was secure, and it arrived earlier than expected.',
        'timestamp': "2023-12-15/2:25 AM"
      }),
      Review.fromJson({
        'reviewer_name': 'Ryan Turner',
        'rating': 4,
        'comment':
            'Overall a good purchase. Some minor issues, but nothing major. Satisfied.',
        'timestamp': "2023-12-15/2:25 AM"
      }),
      Review.fromJson({
        'reviewer_name': 'Sophia Adams',
        'rating': 3,
        'comment':
            'The product is okay. Not exceptional, but it serves its purpose. Average quality.',
        'timestamp': "2023-12-15/2:25 AM"
      })
    ],
    'productImage': 'assets/images/products/product4.png',
    'onSale': false,
    'ProductDetails': {
      'Condition': 'used',
      'color': 'green',
      'productListImages': [
        'assets/images/products/product4.png',
        'assets/images/products/product2.png',
        'assets/images/products/product3.png'
      ],
      'productSpecs': {
        'ablakash': 'msscsdf',
        'fabric type': 'aappalpl',
        'fabric density': 'svsv',
        'Wood type': 'dvdvvv',
      },
      'productDesc':
          'White coated chair combines a full-length React foam midsole for unrivaled comfort and a striking visual experience.',
      'productStats': {
        'Delivery': true,
        'Negotiable': true,
        'Modifiable': true
      },
      'productSeller': {'name': 'ahmed'}
    },
  }),
];

List<Map<String, dynamic>> notificationsList = [
  {
    "title": 'The Best Title',
    "subtitle":
        "Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo",
  },
  {
    "title": 'The Best Title',
    "subtitle":
        "Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo",
  },
  {
    "title": 'The Best Title',
    "subtitle":
        "Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo",
  },
  {
    "title": 'The Best Title',
    "subtitle":
        "Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo",
  },
];
