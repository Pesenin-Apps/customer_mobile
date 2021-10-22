import 'package:customer_pesenin/models/product_category_model.dart';
import 'package:customer_pesenin/models/product_type_model.dart';

class ProductModel {

  String? id;
  String? name;
  int? price;
  bool? isReady;
  String? image;
  ProductCategoryModel? category;
  ProductTypeModel? type;
  String? createdAt;
  String? updatedAt;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.isReady,
    this.image,
    this.category,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    price = json['price'];
    isReady = json['is_ready'];
    image = json['image_url'];
    category = ProductCategoryModel.fromJson(json['category']);
    type = ProductTypeModel.fromJson(json['type']);
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'isReady': isReady,
      'image': image,
      'category': category?.toJson(),
      'type': type?.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

}