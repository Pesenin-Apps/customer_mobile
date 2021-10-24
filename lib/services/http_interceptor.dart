import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:customer_pesenin/locator.dart';
import 'package:customer_pesenin/services/dialog_error.dart';
import 'package:customer_pesenin/services/dio_exceptions.dart';
import 'package:customer_pesenin/services/navigation_custom.dart';

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
    if (DioExceptions.fromDioError(err).getStatusCode() == 401) {
      // implement logout
      await SharedPreferences.getInstance();
      locator<NavigationCustom>().navigateReplace('/');
    }
    final errorMessage = DioExceptions.fromDioError(err).toString();
    // final statusCode = DioExceptions.fromDioError(dioError).getStatusCode();
    // print('errormessage: $errorMessage');
    if (DioExceptions.fromDioError(err).getStatusCode() != 404) {
      _dialogError!.showErrorDialog(errorMessage);
    }
    
    super.onError(err, handler);

  }
  
}