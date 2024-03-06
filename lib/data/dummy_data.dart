import 'package:furniture_store/features/home/model/banners_model.dart';
import 'package:furniture_store/features/home/model/category_model.dart';
import 'package:furniture_store/utils/constants/image_strings.dart';

class DummyData {
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
