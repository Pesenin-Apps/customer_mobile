import 'package:customer_pesenin/models/product.dart';
import 'package:customer_pesenin/services/http_interceptor.dart';
import 'package:customer_pesenin/services/http_option.dart';
import 'package:dio/dio.dart';

class Api {
  
  final Dio _dio = Dio(baseOptions)..interceptors.add(HttpInterceptors());

  /* ========= START API PRODUCTS ========= */

  Future<List<ProductCategory>> getProductCategories() async {
    try {
      var response = await _dio.get(
        '/products/categories',
        // options: Options(
        //   headers: {
        //     'requiresToken': true,
        //   }
        // ),
      );
      // print(response.data['data']);
      return (response.data['data'] as List<dynamic>).map((e) {
        return ProductCategory.fromJson(e);
      }).toList();
    } catch (e) {
      // print(e);
      return [];
    }
  }

  Future<List<Product>> getProducts(String category) async {
    try {
      var response = await _dio.get(
        '/products?period=all&category=$category',
        // options: Options(
        //   headers: {
        //     'requiresToken': true,
        //   }
        // ),
      );
      // print(response.data['data']);
      return (response.data['data'] as List<dynamic>).map((e) {
        return Product.fromJson(e);
      }).toList();
    } catch (e) {
      // print(e);
      return [];
    }
  }

  /* ========= END API PRODUCTS ========= */

}