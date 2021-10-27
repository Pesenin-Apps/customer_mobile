import 'package:customer_pesenin/core/helpers/locator.dart';
import 'package:customer_pesenin/core/services/navigation_custom.dart';
import 'package:flutter/material.dart';

class DialogError {
  void showErrorDialog(String message) {
    showDialog(
      context: locator<NavigationCustom>().navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return Container();
      }
    );
  }
}