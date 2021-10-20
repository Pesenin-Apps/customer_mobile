import 'package:flutter/material.dart';
import 'package:customer_pesenin/models/product_category_model.dart';
import 'package:customer_pesenin/services/products/category_service.dart';

class ProductCategoryProvider with ChangeNotifier {

  List<ProductCategoryModel> _productCategories = [];
  List<ProductCategoryModel> get productCategories => _productCategories;

  set productCategories(List<ProductCategoryModel> productCategories) {
    _productCategories = productCategories;
    notifyListeners();
  }

  Future<void> getProductCategories() async {
    try {
      List<ProductCategoryModel> productCategories = await ProductCategoryService().getProductCategories();
      _productCategories = productCategories;
    } catch (e) {
      print('Error : $e');
    }
  }

}