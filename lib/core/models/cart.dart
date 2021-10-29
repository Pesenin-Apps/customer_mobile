import 'package:customer_pesenin/core/models/product.dart';

class CartModel {

  int? id;
  Product? product;
  int? qty;

  CartModel({
    this.id,
    this.product,
    this.qty,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
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