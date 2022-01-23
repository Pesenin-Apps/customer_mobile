import 'package:customer_pesenin/core/models/product.dart';
import 'package:customer_pesenin/core/models/cart.dart';
import 'package:flutter/material.dart';

class CartVM extends ChangeNotifier {

  List<CartModel> _carts = [];
  List<CartModel> _cartReservations = [];

  List<CartModel> get carts => _carts;
  List<CartModel> get cartReservations => _cartReservations;

  set carts(List<CartModel> carts) {
    _carts = carts;
    notifyListeners();
  }

  set cartReservations(List<CartModel> cartReservations) {
    _cartReservations = cartReservations;
    notifyListeners();
  }

  productExist(Product product) {
    if (_carts.indexWhere((element) => element.product?.id == product.id) == -1){
      return false;
    } else {
      return true;
    }
  }

  productExistInReservation(Product product) {
    if (_cartReservations.indexWhere((element) => element.product?.id == product.id) == -1){
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
          id: product.id,
          product: product,
          qty: 1,
        ),
      );
    }
    notifyListeners();
  }

  addCartReservation(Product product, int quantity) {
    if (productExistInReservation(product)) {
      int index = _cartReservations.indexWhere((element) => element.product?.id == product.id);
      _cartReservations[index].qty = _cartReservations[index].qty! +  1 ;
    } else {
      _cartReservations.add(
        CartModel(
          id: product.id,
          product: product,
          qty: quantity,
        ),
      );
    }
    notifyListeners();
  }

  removeCart(String id) {
    int index = _carts.indexWhere((element) => element.id == id);
    _carts.removeAt(index);
    notifyListeners();
  }

  removeCartReservation(String id) {
    int index = _cartReservations.indexWhere((element) => element.id == id);
    _cartReservations.removeAt(index);
    notifyListeners();
  }

  addQty(String id) {
    int index = _carts.indexWhere((element) => element.id == id);
    _carts[index].qty = _carts[index].qty! + 1;
    notifyListeners();  
  }

  addQtyReservation(String id) {
    int index = _cartReservations.indexWhere((element) => element.id == id);
    _cartReservations[index].qty = _cartReservations[index].qty! + 1;
    notifyListeners();  
  }

  reduceQty(String id) {
    int index = _carts.indexWhere((element) => element.id == id);
    _carts[index].qty = _carts[index].qty! - 1;
    if (_carts[index].qty == 0) {
      _carts.removeAt(index);
    }
    notifyListeners();
  }

  reduceQtyReservation(String id) {
    int index = _cartReservations.indexWhere((element) => element.id == id);
    _cartReservations[index].qty = _cartReservations[index].qty! - 1;
    if (_cartReservations[index].qty == 0) {
      _cartReservations.removeAt(index);
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