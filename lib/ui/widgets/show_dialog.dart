import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:flutter/material.dart';

Future<void> showDialogCustom(BuildContext context, int dialogTheme, IconData icons, String strTitle, bool hasDescription, String strDescription, bool hasButton, String strButton, void funcAction) async {

  Color? color;

  switch (dialogTheme) {
    case dangerTheme:
      color = errorColor;
      break;
    default:
      color = primaryColor;
      break;
  }

  return showDialog(
    context: context, 
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
                child: InkWell(
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
                icons,
                color: color,
                size: 100,
              ),
              const SizedBox( height: 12),
              Text(
                strTitle,
                style: primaryTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: semiBold,
                ),
                textAlign: TextAlign.center,
              ),
              hasDescription ? Column(
                children: [
                  const SizedBox(height: 12),
                  Text(
                    strDescription.toString(),
                    style: secondaryTextStyle.copyWith(
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ) : const SizedBox(),
              hasButton ? Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    width: 150,
                    height: 40,
                    margin: EdgeInsets.zero,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        funcAction;
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        strButton,
                        style: tertiaryTextStyle.copyWith(
                          fontSize: 13,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                  ),
                ],
              ) : const SizedBox(),
            ],
          ),
        ),
      ),
    )
  );
  
}