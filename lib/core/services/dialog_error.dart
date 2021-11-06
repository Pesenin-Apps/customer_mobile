import 'package:customer_pesenin/core/helpers/locator.dart';
import 'package:customer_pesenin/core/services/navigation_custom.dart';
import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:flutter/material.dart';

class DialogError {
  void showErrorDialog(String message) {
    showDialog(
      context: locator<NavigationCustom>().navigatorKey.currentContext!,
      builder: (BuildContext context) => Container(
        margin: EdgeInsets.zero,
        width: MediaQuery.of(context).size.width - (2 * defaultMargin),
        child: AlertDialog(
          backgroundColor: backgroundColor3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: primaryTextColor,
                    ),
                  ),
                ),
                Icon(
                  Icons.error_outline_rounded,
                  color: dangerColor,
                  size: 100,
                ),
                const SizedBox( height: 12),
                Text(
                  message,
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}