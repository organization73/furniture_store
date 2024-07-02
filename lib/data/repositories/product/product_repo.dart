import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decordash/data/repositories/authentication/api_services.dart';
import 'package:decordash/features/home/controllers/home_page_controller.dart';
import 'package:decordash/features/home/model/vendor_model.dart';
import 'package:decordash/utils/constants/enums.dart';
import 'package:decordash/utils/logging/logger.dart';
import 'package:flutter/services.dart';
import 'package:decordash/common/widgets/loaders/loaders.dart';
import 'package:decordash/data/services/cloud_storage/firebase_storage_service.dart';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:decordash/utils/exceptions/firebase_exceptions.dart';
import 'package:decordash/utils/exceptions/platform_exceptions.dart';
import 'package:decordash/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductRepo extends GetxController {
  static ProductRepo get instance => Get.find();
  static int pagenumber = 1;
  final _db = FirebaseFirestore.instance;

  // Future<List<ProductModel>> fetchProducts() async {
  //   try {
  //     final snapshot = await _db.collection('Products').get();

  //     final list = snapshot.docs
  //         .map((document) => ProductModel.fromFirebaseDocument(document))
  //         .toList();

  //     return list;
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.code).message;
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong, Please try again';
  //   }
  // }

  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      // Fetch a larger set of documents
      final snapshot = await _db.collection('Products').get();

      // Filter documents on the client side
      final list = snapshot.docs
          .where((document) => document['productName']
              .toLowerCase()
              .contains(query.toLowerCase()))
          .map((document) => ProductModel.fromFirebaseDocument(document))
          .toList();

      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<List<ProductModel>> fetchFeaturedProducts() async {
    if (StartPageController.instance.products.isNotEmpty) {
      return StartPageController.instance.products;
      // .where((e) => e.isFeatured ?? false)
      // .toList();
    } else {
      var l = await fetchProductsFromServer(1);
      return l;
      // .where((e) => e.isFeatured ?? false).toList();
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('isFeatured', isEqualTo: true)
          .get();

      final list = snapshot.docs
          .map((document) => ProductModel.fromFirebaseDocument(document))
          .toList();

      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromFirebaseDocument(doc))
          .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<List<ProductModel>> getFavouriteProducts(
      List<String> productIds) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      return snapshot.docs
          .map((querySnapshot) =>
              ProductModel.fromFirebaseDocument(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  Future<List<ProductModel>> getProductsForVendor(
      {required String vendorId, int limit = -1}) async {
    try {
      var r = await HttpService.instance.getProductOfUser(vendorId);
      print("eeeeeeeeeeeeeeeeeeeerrrrr");

      print(r);
      return r
          // TODO product mapping
          .map((m) => ProductModel(
              id: m['_id'],
              productName: m['title'],
              categoryId: mapingTheCategories(m['images']),
              productImage: m['images'][0]['imageUrl'],
              productPrice:
                  (m['price']).toDouble(), // Ensure key name consistency
              productDetails: ProductDetails(
                  condition: m['details']['condition'],
                  color: m['details']['color'], //TODO map the color
                  productListImages: fromImage(m['images']),
                  productSpecs: {
                    'ablakash': m['details']['abalakach'],
                    'fabric type': m['details']['cloth'],
                    'wood type': m['details']['wood'],
                  },
                  productDesc: m['description'],
                  productStats: ProductStats(
                      delivery: m['details']['delevary'],
                      negotiable: m['details']['negotiable'],
                      modifiable: m['details']['modefiable']),
                  productSeller: VendorModel(
                      name:
                          "${m['creator']['firstName']} ${m['creator']['lastName']}",
                      location: "Egypt",
                      id: m['creator']['_id'],
                      image: m['creator']['imageUrl'] ??
                          "https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg",
                      isFeatured: m['creator']['type'] == "Gallery",
                      productsCount: 0,
                      accountType: mapType(m['creator']['type'])))))
          .toList();
    } catch (e) {
      print("rrrrrrrrrrrrrrrrrrrrrrrrr$e");
      return [];
    }
  }

  Future<List<ProductModel>> getProductsForCategory(
      {required String categoryId, int limit = -1}) async {
    var clas = categoryId == '11'
        ? "chair"
        : categoryId == '12'
            ? "swivelchair"
            : categoryId == '21'
                ? "sofa"
                : categoryId == '31'
                    ? "bed"
                    : "table";
    print(clas);
    var p = await HttpService.instance.getProductsbyQyery(1, clas);
    print(p);
    return p
        .map((m) => ProductModel(
            id: m['_id'],
            productName: m['title'],
            categoryId: mapingTheCategories(m['images']),
            productImage: m['images'][0]['imageUrl'],
            productPrice:
                (m['price']).toDouble(), // Ensure key name consistency
            productDetails: ProductDetails(
                condition: m['details']['condition'],
                color: m['details']['color'], //TODO map the color
                productListImages: fromImage(m['images']),
                productSpecs: {
                  'ablakash': m['details']['abalakach'],
                  'fabric type': m['details']['cloth'],
                  'wood type': m['details']['wood'],
                },
                productDesc: m['description'],
                productStats: ProductStats(
                    delivery: m['details']['delevary'],
                    negotiable: m['details']['negotiable'],
                    modifiable: m['details']['modefiable']),
                productSeller: VendorModel(
                    name:
                        "${m['creator']['firstName']} ${m['creator']['lastName']}",
                    location: "Egypt",
                    id: m['creator']['_id'],
                    image: m['creator']['imageUrl'] ??
                        "https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg",
                    isFeatured: m['creator']['type'] == "Gallery",
                    productsCount: 0,
                    accountType: mapType(m['creator']['type'])))))
        .toList();
  }

  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Uploading Data...', 'assets/animations/animation-of-docer.json');

      final storage = Get.put(FirebaseStorageServices());

      for (var product in products) {
        final mainImageFile =
            await storage.getImageDatafromAssets(product.productImage);

        final mainImageUrl = await storage.uploadImageData(
            'Products', mainImageFile, product.productImage);
        product.productImage = mainImageUrl;

        for (var imagePath in product.productDetails.productListImages) {
          final imageFile = await storage.getImageDatafromAssets(imagePath);
          final imageUrl =
              await storage.uploadImageData('Products', imageFile, imagePath);

          product.productDetails.productListImages = product
              .productDetails.productListImages
              .map((path) => path == imagePath ? imageUrl : path)
              .toList();
        }

        await _db.collection('Products').doc(product.id).set(product.toJson());
      }

      FullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
          title: 'Uploading Completed',
          message: 'All categories data has been uploaded to firestore');
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      LoggerHelper.error('error', e);
      throw 'Something went wrong, Please try again';
    }
  }

  Future<void> uploadProductToDatabase(ProductModel product) async {
    try {
      final storage = Get.put(FirebaseStorageServices());

      for (var imagePath in product.productDetails.productListImages) {
        final imageFile = await storage.getImageDatafromAssets(imagePath);
        final imageUrl =
            await storage.uploadImageData('Products', imageFile, imagePath);
        // imagePath = imageUrl;
        product.productDetails.productListImages = product
            .productDetails.productListImages
            .map((path) => path == imagePath ? imageUrl : path)
            .toList();
      }
      print(product.productDetails.productListImages);
      await HttpService.instance.addProduct(product);
      // hereeeer
    } catch (e) {
      LoggerHelper.error('error', e);
      rethrow;
    }
  }

  Future<List<ProductModel>> fetchProductsFromServer(int page) async {
    try {
      print("ssssssssssssssssssssssss");
      var products = await HttpService.instance
          .getProducts(page, GetStorage().read('token'));
      print(products);

      print("price");
      print("price");
      print("price");
      // print("${(products[0]['price'] as double).toDouble()}");
      print("price");
      print("price");

      var prods = products
          // TODO product mapping
          .map((m) => ProductModel(
              id: m['_id'],
              productName: m['title'],
              categoryId: mapingTheCategories(m['images']),
              productImage: m['images'][0]['imageUrl'],
              productPrice:
                  (m['price']).toDouble(), // Ensure key name consistency
              productDetails: ProductDetails(
                  condition: m['details']['condition'],
                  color: m['details']['color'], //TODO map the color
                  productListImages: fromImage(m['images']),
                  productSpecs: {
                    'ablakash': m['details']['abalakach'],
                    'fabric type': m['details']['cloth'],
                    'wood type': m['details']['wood'],
                  },
                  productDesc: m['description'],
                  productStats: ProductStats(
                      delivery: m['details']['delevary'],
                      negotiable: m['details']['negotiable'],
                      modifiable: m['details']['modefiable']),
                  productSeller: VendorModel(
                      name:
                          "${m['creator']['firstName']} ${m['creator']['lastName']}",
                      location: "Egypt",
                      id: m['creator']['_id'],
                      image: m['creator']['imageUrl'] ??
                          "https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg",
                      isFeatured: m['creator']['type'] == "Gallery",
                      productsCount: 0,
                      accountType: mapType(m['creator']['type'])))))
          .toList();
      for (var i = 0; i < prods.length; i++) {
        // double p = (products[i]['price'] as int).toDouble();
        // print(products[i]['price']);
        // print("pppppppppp");

        // prods[i].productPrice = p;
      }
      for (var element in prods) {
        print(element.id);
        print(element.categoryId);
      }
      return prods;
    } catch (e) {
      LoggerHelper.warning(e.toString());
      return [];
    }
  }

  String mapingTheCategories(List listImages) {
    int count11 = 0;
    int count12 = 0;
    int count21 = 0;
    int count31 = 0;
    int count41 = 0;

    for (var e in listImages) {
      switch (e['class']) {
        // Ensure correct key name
        case "chair":
          count11++;
          break;
        case "swivelchair":
          count12++;
          break;
        case "sofa":
          count21++;
          break;
        case "bed":
          count31++;
          break;
        case "table":
          count41++;
          break;
        default:
          count11++;
          break;
      }
    }

    int maxCount = 0;
    String res = "11";
    if (count11 > maxCount) {
      maxCount = count11;
      res = "11";
    }
    if (count12 > maxCount) {
      maxCount = count12;
      res = "12";
    }
    if (count21 > maxCount) {
      maxCount = count21;
      res = "21";
    }
    if (count31 > maxCount) {
      maxCount = count31;
      res = "31";
    }
    if (count41 > maxCount) {
      maxCount = count41;
      res = "41";
    }
    return res;
  }

  List<String> fromImage(List listImages) {
    return listImages
        .map((e) => e['imageUrl'] as String)
        .toList(); // Ensure correct key name and type
  }

  AccountType mapType(String type) {
    switch (type) {
      case "Client":
        return AccountType.regular;
      case "Gallary":
        return AccountType.vendor;
      default:
        return AccountType.regular;
    }
  }
}
