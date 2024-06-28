
import 'package:decordash/features/personalization/models/user_model.dart';

class NewProduct {
  UserModel? creator;
  String? title;
  int? price;
  String? description;
  List<Images>? images;
  int? rate;
  Details? details;
  String? createdAt;
  NewProduct({
    this.creator,
    this.title,
    this.price,
    this.description,
    this.images,
    this.rate,
    this.details,
    this.createdAt,
  });

  NewProduct.fromJson(Map<String, dynamic> json) {
    creator =
        json['creator'] != null ? UserModel.fromJson(json['creator']) : null;
    title = json['title'];
    price = json['price'];
    description = json['description'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    rate = json['rate'];
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
    // createdAt = json['createdAt'] != null
    //     ? CreatedAt.fromJson(json['createdAt'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (creator != null) {
      data['creator'] = creator!.toJson();
    }
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['rate'] = rate;
    if (details != null) {
      data['details'] = details!.toJson();
    }
    if (createdAt != null) {
      data['createdAt'] = createdAt;
    }

    return data;
  }
}

class Images {
  String? imageUrl;

  Images({
    this.imageUrl,
  });

  Images.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageUrl'] = imageUrl;

    return data;
  }
}

class Details {
  String wood;
  String abalakach;
  String cloth;
  String condition;
  String color;
  bool delevary;
  bool negotiable;
  bool modefiable;

  Details(
      {this.wood = "n",
      this.abalakach = "n",
      this.cloth = "n",
      this.condition = "1",
      this.color = "ffffffff",
      this.delevary = false,
      this.negotiable = false,
      this.modefiable = false});

  Details.fromJson(Map<String, dynamic> json)
      : wood = json['wood']??"n",
        abalakach = json['abalakach']??"n",
        cloth = json['cloth']??"n",
        condition = json['condition']??"n",
        color = json['color']??"n",
        delevary = json['delevary']??false,
        negotiable = json['negotiable']??false,
        modefiable = json['modefiable']??false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wood'] = wood;
    data['abalakach'] = abalakach;
    data['cloth'] = cloth;
    data['condition'] = condition;
    data['color'] = color;
    data['delevary'] = delevary;
    data['negotiable'] = negotiable;
    data['modefiable'] = modefiable;
    return data;
  }
}
