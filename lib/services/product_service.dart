import 'dart:convert';
import 'package:customer_pesenin/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {

  String baseUrl = 'https://pesenin.onggolt-dev.com/api/v1';

  Future<List<ProductModel>> getProducts() async {

    // Map<String, String> queryParams = {
    //   'period': 'all',
    // };

    // var url = Uri.https(baseUrl, '/products', queryParams);
    var url = '$baseUrl/products';
    var urlParse = Uri.parse(url).replace(query: 'period=all');
    var headers = { 'Accept' : 'application/json' };
    var response = await http.get(urlParse, headers: headers);

    // print(urlParse);

    if (response.statusCode == 200) {

      List data = jsonDecode(response.body)['data'];
      List<ProductModel> products = [];

      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }

      return products;
      
    } else {
      throw Exception('Error : Get Products Failed!');
    }

  }

}