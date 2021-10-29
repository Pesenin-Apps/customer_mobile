import 'package:customer_pesenin/core/models/product.dart';
import 'package:customer_pesenin/core/models/cart.dart';
import 'package:flutter/material.dart';

class CartVM extends ChangeNotifier {

  List<CartModel> _carts = [];

  List<CartModel> get carts=> _carts;

  set carts(List<CartModel> carts) {
    _carts = carts;
    notifyListeners();
  }

  productExist(Product product) {
    if (_carts.indexWhere((element) => element.product?.id == product.id) == -1){
      return false;
    } else {
      return true;
    }
  }

  addCart(Product product) {
    if (productExist(product)) {
      int index = _carts.indexWhere((element) => element.product?.id == product.id);
      _carts[index].qty = _carts[index].qty! +  1 ;
    } else {
      _carts.add(
        CartModel(
          id: _carts.length,
          product: product,
          qty: 1,
        ),
      );
    }
    notifyListeners();
  }

  removeCart(int id) {
    _carts.removeAt(id);
    notifyListeners();
  }

  addQty(int id) {
    _carts[id].qty = _carts[id].qty! + 1;
    notifyListeners();  
  }

  reduceQty(int id) {
    _carts[id].qty = _carts[id].qty! - 1;
    if (_carts[id].qty == 0) {
      _carts.removeAt(id);
    }
    notifyListeners();
  }

  totalItems() {
    int total = 0;
    for (var item in _carts) {
      total += item.qty!;
    }
    return total;
  }
  totalPrice() {
    int total = 0;
    for (var item in _carts) {
      total += (item.qty! * item.product!.price!);
    }
    return total;
  }

}