import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:customer_pesenin/core/helpers/locator.dart';
import 'package:customer_pesenin/core/models/guest.dart';
import 'package:customer_pesenin/core/models/table.dart';
import 'package:customer_pesenin/core/models/user.dart';
import 'package:customer_pesenin/core/services/api.dart';
import 'package:customer_pesenin/core/services/http_option.dart';
import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:customer_pesenin/core/services/navigation_custom.dart';

class UserVM extends ChangeNotifier {

  final Dio _dio = Dio(baseOptions);
  Api api = locator<Api>();
  String? _token;
  String? _role;
  UserModel? customer;
  GuestModel? guest;
  TableModel? _tableDetail;

  bool get isAuth {
    return token != null;
  }

  bool get isGuest {
    return role == roleGuest;
  }

  bool get isCustomer {
    return role == roleCustomer;
  }

  // GuestModel get guestDetail {
  //   return guest!;
  // }

  // UserModel get customerDetail {
  //   return customer!;
  // }

  String? get token {
    // print('Token is : $_token');
    if (_token != null) {
      return _token!;
    }
    return null;
  }

  String? get role {
    // print('Role is : $_role');
    switch (_role) {
      case roleCustomer:
        return roleCustomer;
      default:
        return roleGuest;
    }
  }

  UserModel get customerDetail {
    return customer!;
  }

  TableModel get tableDetail {
    return _tableDetail!;
  }

  Future fetchGuest() async {
    guest = await api.getGuest();
    notifyListeners();
  }

  Future fetchCustomer() async {
    customer = await api.getCustomer();
    notifyListeners();
  }

  Future<bool> checkIn(Map<String, dynamic> checkInForm) async {
    try {

      var response = await _dio.post(
        '/guest/check-in',
        data: checkInForm
      );
      // print(response.data['token']);

      _token = response.data['token'];
      _role = roleGuest;
      notifyListeners();

      final tokenData = jsonEncode({
        'token': _token,
      });

      final roleData = jsonEncode({
        'role': _role,
      });

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('tokenData', tokenData);
      await prefs.setString('roleData', roleData);

      guest = await api.getGuest();
      final userData = jsonEncode(guest);

      await prefs.setString('userData', userData);
      notifyListeners();

      locator<NavigationCustom>().navigateReplace('/');
      return true;

    } catch (e) {
      // print('response error : $e');
      return false;
    }
  }

  Future<bool> signIn(Map<String, dynamic> signInForm) async {
    try {

      var response = await _dio.post(
        '/auth/signin',
        data: signInForm,
      );

      if (response.data['user']['role'] != 'customer') {
        return false;
      }
      
      _token = response.data['token'];
      _role = roleCustomer;
      notifyListeners();

      final tokenData = jsonEncode({
        'token': _token,
      });

      final roleData = jsonEncode({
        'role': _role,
      });

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('tokenData', tokenData);
      await prefs.setString('roleData', roleData);

      customer = await api.getCustomer();
      final userData = jsonEncode(customer);

      await prefs.setString('userData', userData);
      notifyListeners();

      locator<NavigationCustom>().navigateReplace('/');
      return true;

    } catch (e) {
      return false;
    }
  }

  Future<bool> tryAutoCheckInAndSignIn() async {
    try {

      final prefs = await SharedPreferences.getInstance();

      if (!prefs.containsKey('tokenData')) {
        return false;
      } if (!prefs.containsKey('userData')) {
        return false;
      } if (!prefs.containsKey('roleData')) {
        return false;
      }

      final extractedToken = json.decode(prefs.getString('tokenData')!);
      final extractUserData = json.decode(prefs.getString('userData')!);
      final extractRole = json.decode(prefs.getString('roleData')!);

      final token = extractedToken['token'];
      final role = extractRole['role'];
      _token = token;
      _role = role;

      locator<NavigationCustom>().navigateReplace('/');
      // print(extractUserData);
      notifyListeners();

      if (role == roleCustomer) {
        customer = UserModel.fromJson(extractUserData);
      } else {
        guest = GuestModel.fromJson(extractUserData);
      }

      notifyListeners();
      return true;

    } catch (e) {
      throw e;
    }
  }

  Future<bool> checkOut() async {

    final response = await api.checkOut();

    if (response) {

      notifyListeners();

      _token = null;
      _role = null;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      prefs.remove('userData');
      prefs.remove('tokenData');
      prefs.remove('roleData');
      guest = null;

      // locator<NavigationCustom>().navigateReplace('/');
      // print('destroy preferences');

      return true;

    } else {
      // print('Something Is Wrong');
      return false;
    }
  }

  Future<bool> signOut() async {
    final response = await api.signOut();
    if (response) {

      notifyListeners();

      _token = null;
      _role = null;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      prefs.remove('userData');
      prefs.remove('tokenData');
      prefs.remove('roleData');
      customer = null;

      // locator<NavigationCustom>().navigateReplace('/');
      // print('destroy preferences');

      return true;

    } else {
      // print('Something Is Wrong');
      return false;
    }
  }

  Future<bool> changeProfileCustomer(Map<String, dynamic> changedProfileForm) async {
    final response = await api.postUpdateProfileCustomer(changedProfileForm);
    notifyListeners();
    if (response) {
      return true;
    } else {
      return false;
    }
  }

  Future fetchTableDetail(String id) async {
    _tableDetail = await api.getTable(id);
    notifyListeners();
  }
  
}