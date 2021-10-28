import 'dart:convert';
import 'package:customer_pesenin/core/helpers/locator.dart';
import 'package:customer_pesenin/core/models/customer.dart';
import 'package:customer_pesenin/core/services/api.dart';
import 'package:customer_pesenin/core/models/table.dart';
import 'package:customer_pesenin/core/services/http_option.dart';
import 'package:customer_pesenin/core/services/navigation_custom.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerVM extends ChangeNotifier {
  
  final Dio _dio = Dio(baseOptions);
  Api api = locator<Api>();
  TableModel? _tableDetail;
  String? _token;
  Customer? customer;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_token != null) {
      return _token!;
    }
    // print('token is: $_token');
    return null;
  }

  TableModel get tableDetail {
    return _tableDetail!;
  }

  Future fetchTableDetail(String id) async {
    _tableDetail = await api.getTable(id);
    notifyListeners();
  }

  Future fetchCustomer() async {
    customer = await api.getCustomer();
    notifyListeners();
  }

  Future<bool> checkIn(Map<String, dynamic> checkInForm) async {
    try {
      var response = await _dio.post(
        '/customers/check-in',
        data: checkInForm
      );
      // print(response.data['token']);
      _token = response.data['token'];
      notifyListeners();
      final tokenData = jsonEncode({
        'token': _token,
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('tokenData', tokenData);
      // print('success set token');
      customer = await api.getCustomer();
      // print('hello');
      await prefs.setString('customerNewData', jsonEncode(customer));
      notifyListeners();
      locator<NavigationCustom>().navigateReplace('/');
      return true;
    } catch (e) {
      // print('response error : $e');
      return false;
    }
  }

  Future<bool> tryAutoCheckIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('tokenData')) {
        return false;
      }
      if (!prefs.containsKey('customerNewData')) {
        return false;
      }
      final extractDataUser = json.decode(prefs.getString('customerNewData')!);
      final extractedToken = json.decode(prefs.getString('tokenData')!);
      final token = extractedToken['token'];
      _token = token;

      locator<NavigationCustom>().navigateReplace('/');
      // print(extractDataUser);
      notifyListeners();
      customer = Customer.fromJson(extractDataUser);
      notifyListeners();
      return true;
    } catch (e) {
      throw e;
    }
  }
  
}