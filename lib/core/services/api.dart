import 'package:customer_pesenin/core/models/customer.dart';
import 'package:customer_pesenin/core/models/table.dart';
import 'package:dio/dio.dart';
import 'package:customer_pesenin/core/models/product.dart';
import 'package:customer_pesenin/core/services/http_interceptor.dart';
import 'package:customer_pesenin/core/services/http_option.dart';

class Api {
  
  final Dio _dio = Dio(baseOptions)..interceptors.add(HttpInterceptors());

  /* ========= START API CUSTOMER ========= */

  Future<Customer?> getCustomer() async {
    try {
      var response = await _dio.get(
        '/customers/me',
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );
      return Customer.fromJson(response.data['customer']);
    } on DioError catch (e) {
      print('error: $e');
      return null;
    }
  }

  Future<bool> checkOut() async {
    try {
      await _dio.post(
        '/customers/check-out',
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );
      return true;
    } catch (e) {
      print('error: $e');
      return false;
    }
  }

  /* ========= START API CUSTOMER ========= */


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


  /* ========= START API TABLE ========= */
  
  Future<TableModel?> getTable(String id) async {
    try {
      var response = await _dio.get(
        '/tables/$id',
      );
      return TableModel.fromJson({
        ...response.data['data']
      });
    } catch (e) {
      return TableModel.fromJson({
        'data': {
          'id': null,
          'name': null,
          'number': null,
          'used': null,
          'section': TableSection.fromJson({
            'id': null,
            'name': null,
            'code': null,
          }),
        }
      });
    }
  }

  /* ========= END API TABLE ========= */

}