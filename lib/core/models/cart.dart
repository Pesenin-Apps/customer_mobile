import 'package:customer_pesenin/core/models/product.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'cart.g.dart';

// @JsonSerializable()
class Cart {

  String? id;
  Product? product;
  int? qty;

  Cart({
    required this.id,
    required this.product,
    required this.qty,
  });

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJson(json['product']);
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product?.toJson(),
      'qty': qty,
    };
  }

}