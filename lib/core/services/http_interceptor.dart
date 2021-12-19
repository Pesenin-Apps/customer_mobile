import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:customer_pesenin/core/helpers/locator.dart';
import 'package:customer_pesenin/core/services/dialog_error.dart';
import 'package:customer_pesenin/core/services/dio_exceptions.dart';
import 'package:customer_pesenin/core/services/navigation_custom.dart';

class HttpInterceptors extends Interceptor {

  DialogError? _dialogError;
  HttpInterceptors() {
    _dialogError = DialogError();
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    
    if (options.headers.containsKey('requiresToken')) {
      // print('token');
      //remove the auxiliary header
      options.headers.remove('requiresToken');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // print(prefs.getString('tokenData')! is String);
      var extractedToken = json.decode(prefs.getString('tokenData')!);
      var token = extractedToken['token'];
      // print('token: $token');
      options.headers.addAll({'Authorization': 'Bearer $token'});
      // print('token_done');
    }
    super.onRequest(options, handler);

  }

  @override
  Future<dynamic> onError(DioError err, ErrorInterceptorHandler handler) async {
    
    // print(err.response!.statusCode);
    final errorMessage = DioExceptions.fromDioError(err).toString();
    if (DioExceptions.fromDioError(err).getStatusCode() == 401) {
      // implement logout
      // await SharedPreferences.getInstance();
      final prefs = await SharedPreferences.getInstance();
      // prefs.remove('customerNewData');
      prefs.remove('tokenData');
      prefs.remove('userData');
      prefs.remove('roleData');
      locator<NavigationCustom>().navigateReplace('/onboarding');
    } else if ([400, 402, 403, 404].contains(DioExceptions.fromDioError(err).getStatusCode())) {
      _dialogError!.showErrorDialog(jsonDecode(err.response!.toString())['message']);
    } else if (DioExceptions.fromDioError(err).getStatusCode() == 720) {
      print('No Internet Connection');
    } else {
      _dialogError!.showErrorDialog(errorMessage);
    }
    // final statusCode = DioExceptions.fromDioError(dioError).getStatusCode();
    // print('errormessage: $errorMessage');
    // if (DioExceptions.fromDioError(err).getStatusCode() != 404) {
    //   _dialogError!.showErrorDialog(jsonDecode(err.response!.toString())['message']);
    // }
    
    super.onError(err, handler);

  }
  
}