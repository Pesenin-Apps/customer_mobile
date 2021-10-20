import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:customer_pesenin/models/product_category_model.dart';

class ProductCategoryService {

  String baseUrl = 'https://pesenin.onggolt-dev.com/api/v1';

  Future<List<ProductCategoryModel>> getProductCategories() async {

    // var url = Uri.https(baseUrl, '/products/categories');
    var url = '$baseUrl/products/categories';
    var headers = { 'Accept' : 'application/json' };
    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {

      List data = jsonDecode(response.body)['data'];
      List<ProductCategoryModel> productCategories = [];

      for (var item in data) {
        productCategories.add(ProductCategoryModel.fromJson(item));
      }

      return productCategories;
      
    } else {
      throw Exception('Gagal Get ProductCategories!');
    }

  }

}