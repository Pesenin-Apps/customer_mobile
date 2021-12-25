import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  final String? title;
  final String? routeName;

  const MenuTile({ 
    Key? key,
    required this.title,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: transparentColor,
      hoverColor: transparentColor,
      focusColor: transparentColor,
      highlightColor: transparentColor,
      onTap: () {
        Navigator.pushNamed(context, routeName!);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title!,
              style: primaryTextStyle.copyWith(
                fontSize: 15,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: primaryTextColor,
            ),
          ],
        ),
      ),
    );
  }
}