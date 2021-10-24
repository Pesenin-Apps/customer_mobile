import 'package:flutter/material.dart';
import 'package:customer_pesenin/models/product.dart';
import 'package:customer_pesenin/services/api.dart';
import 'package:customer_pesenin/locator.dart';

class ProductVM extends ChangeNotifier {
  
  Api api = locator<Api>();
  List<Product> _products = [];
  List<ProductCategory> _productCategories = [];

  List<Product> get product {
    return [..._products];
  }

  List<ProductCategory> get productCategories {
    return [..._productCategories];
  }

  Future fetchProducts(String category) async {
    _products = await api.getProducts(category);
    notifyListeners();
  }

  Future fetchProductCategories() async {
    _productCategories = await api.getProductCategories();
    notifyListeners();
  }

}