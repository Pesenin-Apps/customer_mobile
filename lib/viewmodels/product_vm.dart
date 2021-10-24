import 'package:flutter/material.dart';
import 'package:customer_pesenin/models/product.dart';
import 'package:customer_pesenin/services/api.dart';
import 'package:customer_pesenin/locator.dart';

class ProductVM extends ChangeNotifier {
  
  Api api = locator<Api>();
  List<ProductCategory> _productCategories = [];

  List<ProductCategory> get productCategories {
    return [..._productCategories];
  }

  Future fetchProductCategories() async {
    _productCategories = await api.getProductCategories();
    notifyListeners();
  }

}