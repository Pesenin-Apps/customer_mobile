import 'dart:convert';
import 'package:customer_pesenin/core/models/guest.dart';
import 'package:customer_pesenin/core/models/order.dart';
import 'package:customer_pesenin/core/models/table.dart';
import 'package:customer_pesenin/core/models/user.dart';
import 'package:dio/dio.dart';
import 'package:customer_pesenin/core/models/product.dart';
import 'package:customer_pesenin/core/models/cart.dart';
import 'package:customer_pesenin/core/services/http_interceptor.dart';
import 'package:customer_pesenin/core/services/http_option.dart';

class Api {
  
  final Dio _dio = Dio(baseOptions)..interceptors.add(HttpInterceptors());

  /* ========= START API GUEST & CUSTOMER ========= */

  Future<GuestModel?> getGuest() async {
    try {
      var response = await _dio.get(
        '/guest/me',
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );
      return GuestModel.fromJson(response.data['data']);
    } catch (e) {
      // print('Something Error (Me Guest) : $e');
      return null;
    }
  }

  Future<UserModel?> getCustomer() async {
    try {
      var response = await _dio.get(
        '/users/me',
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );
      return UserModel.fromJson(response.data['data']);
    } catch (e) {
      // print('Something Error (Me User) : $e');
      return null;
    }
  }

  Future<bool> signUp(Map<String, dynamic> inputForm) async {
    try {
      await _dio.post(
        '/auth/signup',
        data: inputForm,
      );
      return true;
    } catch (e) {
      // print('Something Error (signUp) : $e');
      return false;
    }
  }

  Future<bool> checkOut() async {
    try {
      await _dio.post(
        '/guest/check-out',
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );
      return true;
    } catch (e) {
      // print('Something Error (Checkout Guest) : $e');
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await _dio.post(
        '/auth/signout',
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );
      return true;
    } catch (e) {
      // print('Something Error (Sign Out) : $e');
      return false;
    }
  }

  Future<bool> postUpdateProfileCustomer(Map<String, dynamic> changedForm) async {
    try {
      await _dio.post(
        '/users/change-profile',
        data: changedForm,
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );
      return true;
    } catch (e) {
      // print('Something Error (postProfile) : $e');
      return false;
    }
  }

  Future<bool> postChangePassword(Map<String, dynamic> changedPasswordForm) async {
    try {
      await _dio.post(
        '/users/change-password',
        data: changedPasswordForm,
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );
      return true;
    } catch (e) {
      // print('Something Error (postPassword) : $e');
      return false;
    }
  }

  /* ========= START API Guest & CUSTOMER ========= */


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
          'status': null,
          'section': TableSection.fromJson({
            'id': null,
            'name': null,
          }),
        }
      });
    }
  }

  /* ========= END API TABLE ========= */
  
  
  /* ========= START API ORDER ========= */

  // Gu


  // [START] Customer //

  Future<List<Order>> getCustomerOrders(Map<String, dynamic> queryParams) async {
    try {
      var response = await _dio.get(
        '/customers/orders',
        queryParameters: queryParams,
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );
      return (response.data['data'] as List<dynamic>).map((e) {
        return Order.fromJson(e);
      }).toList();
    } catch (e) {
      return [];
    }
  }

  Future<Order?> getOrder(String id) async {
    try {
      var response = await _dio.get(
        '/orders/$id',
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );
      return Order.fromJson(response.data['data']);
    } catch (e) {
      // print('Something Error (getOrder) : $e');
      return null;
    }
  }

  Future<String> postCustomerOrder(String table, List<CartModel> carts) async {
    try {
      var body = jsonEncode({
        'table': table,
        'orders': carts.map((cart) => {
          'item': cart.product!.id,
          'qty': cart.qty,
        }).toList(),
      });
      var response = await _dio.post(
        '/customers/orders',
        data: body,
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );
      return response.data['data']['_id'];
    } catch (e) {
      // print('Something Error (postOrder) : $e');
      return 'null';
    }
  }

  Future<bool> postCancelCustomerOrder(String id) async {
    try {
      await _dio.post(
        '/customers/orders/cancel/$id',
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );
      return true;
    } catch (e) {
      // print('Something Error (postCancelCustomerOrder) : $e');
      return false;
    }
  }

  Future<bool> patchCustomerOrderItem(String orderId, Map<String, dynamic> updatedForm) async {
    try {
      await _dio.patch(
        '/customers/orders/$orderId',
        data: updatedForm,
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );
      return true;
    } catch (e) {
      // print('Something Error (patchCustomerOrderItem) : $e');
      return false;
    }
  }

  Future<bool> deleteCustomerOrderItem(String orderId, Map<String, dynamic> deletedForm) async {
    try {
      await _dio.delete(
        '/customers/orders/$orderId',
        data: deletedForm,
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );
      return true;
    } catch (e) {
      // print('Something Error (deleteCustomerOrderItem) : $e');
      return false;
    }
  }

  Future<bool> postCustomerReservation(Map<String, dynamic> createForm) async {
    try {
      await _dio.post(
        '/customers/reservations',
        data: createForm,
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );
      return true;
    } catch (e) {
      // print('Something Error (postCancelCustomerOrder) : $e');
      return false;
    }
  }

  Future<bool> patchCustomerReservation(String orderId, Map<String, dynamic> updateForm) async {
    try {
      await _dio.patch(
        '/customers/reservations/$orderId',
        data: updateForm,
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );
      return true;
    } catch (e) {
      // print('Something Error (postCancelCustomerOrder) : $e');
      return false;
    }
  }

  Future<bool> patchReservation(String reservationId, Map<String, dynamic> updatedForm) async {
    try {
      await _dio.patch(
        '/orders/reservations/$reservationId',
        data: updatedForm,
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );
      return true;
    } catch (e) {
      // print('Something Error (patchCustomerOrderItem) : $e');
      return false;
    }
  }

  // [END] Customer //


  // [START] Guest //

  Future<Order?> getGuestOrders() async {
    try {
      var response = await _dio.get(
        '/guest/orders',
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );
      return Order.fromJson({
        ...response.data['data']
      });
    } catch (e) {
      return null;
    }
  }

  Future<bool> postGuestOrder(List<CartModel> carts)  async {
    try {
      var body = jsonEncode({
        'orders': carts.map((cart) => {
          'item': cart.product!.id,
          'qty': cart.qty,
        }).toList(),
      });
      await _dio.post(
        '/guest/orders',
        data: body,
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> patchGuestOrderItem(String orderId, Map<String, dynamic> updatedForm) async {
    try {
      await _dio.patch(
        '/guest/orders/$orderId',
        data: updatedForm,
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );
      return true;
    } catch (e) {
      // print('Something Error (patchCustomerOrderItem) : $e');
      return false;
    }
  }

  Future<bool> deleteGuestOrderItem(String orderId, Map<String, dynamic> deletedForm) async {
    try {
      await _dio.delete(
        '/guest/orders/$orderId',
        data: deletedForm,
        options: Options(
          headers: {
            'requiresToken': true,
          },
        ),
      );
      return true;
    } catch (e) {
      // print('Something Error (deleteCustomerOrderItem) : $e');
      return false;
    }
  }

  // [END] Guest //


  /* ========= END API ORDER ========= */

}