// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['_id'] as String?,
    name: json['name'] as String?,
    price: json['price'] as int?,
    isReady: json['is_ready'] as bool?,
    image: json['image_url'] as String?,
    category: json['category'] == null
        ? null
        : ProductCategory.fromJson(json['category'] as Map<String, dynamic>),
    type: json['type'] == null
        ? null
        : ProductType.fromJson(json['type'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'is_ready': instance.isReady,
      'image_url': instance.image,
      'category': instance.category,
      'type': instance.type,
    };

ProductCategory _$ProductCategoryFromJson(Map<String, dynamic> json) {
  return ProductCategory(
    id: json['_id'] as String?,
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$ProductCategoryToJson(ProductCategory instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };

ProductType _$ProductTypeFromJson(Map<String, dynamic> json) {
  return ProductType(
    id: json['_id'] as String?,
    name: json['name'] as String?,
    belong: json['belong'] as int?,
  );
}

Map<String, dynamic> _$ProductTypeToJson(ProductType instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'belong': instance.belong,
    };
