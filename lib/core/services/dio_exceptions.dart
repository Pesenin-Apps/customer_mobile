import 'package:dio/dio.dart';

class DioExceptions implements Exception {

  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = 'Request to server was cancelled';
        statusCode = 700;
        break;
      case DioErrorType.connectTimeout:
        message = 'Connection timeout with server';
        statusCode = 710;
        break;
      case DioErrorType.other:
        message = 'No Internet Connection';
        statusCode = 720;
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with server";
        statusCode = 730;
        break;
      case DioErrorType.response:
        switch (dioError.response!.statusCode) {
          case 400:
            message = "Bad Request Receive";
            statusCode = dioError.response!.statusCode;
            break;
          case 401:
            message = "Your token expired or Unauthorized";
            statusCode = dioError.response!.statusCode;
            break;
          case 403:
            message = "Your Request is forbidden";
            statusCode = dioError.response!.statusCode;
            break;
          case 404:
            message = "Your Request not found this time. Please Try again!";
            statusCode = dioError.response!.statusCode;
            break;
          case 408:
            message = "Request timeout";
            statusCode = dioError.response!.statusCode;
            break;
          case 500:
            message = "Internal Server Error";
            statusCode = dioError.response!.statusCode;
            break;
          default:
            message = 'error encounter';
            statusCode = 499;
        }
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with server";
        statusCode = 750;
        break;
      default:
        message = 'OK';
        statusCode = 200;
    }
  }

  String? message;
  int? statusCode;

  @override
  String toString() => message!;

  int getStatusCode() => statusCode!;
  
}