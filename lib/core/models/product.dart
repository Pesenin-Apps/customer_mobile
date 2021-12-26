import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: '_id')
  String? id;
  String? name;
  int? price;
  @JsonKey(name: 'is_ready')
  bool? isReady;
  @JsonKey(name: 'image_url')
  String? image;
  ProductCategory? category;
  ProductType? type;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.isReady,
    this.image,
    required this.category,
    required this.type,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

}

@JsonSerializable()
class ProductCategory {
  
  @JsonKey(name: '_id')
  String? id;
  String? name;

  ProductCategory({
    required this.id,
    required this.name,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) => _$ProductCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryToJson(this);

}

@JsonSerializable()
class ProductType {
  
  @JsonKey(name: '_id')
  String? id;
  String? name;
  int? belong;

  ProductType({
    required this.id,
    required this.name,
    required this.belong,
  });

  factory ProductType.fromJson(Map<String, dynamic> json) => _$ProductTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ProductTypeToJson(this);

}