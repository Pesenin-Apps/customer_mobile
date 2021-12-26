import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:flutter/material.dart';

class OrderType extends StatefulWidget {
  final int? type;
  const OrderType({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  _OrderTypeState createState() => _OrderTypeState();
}

class _OrderTypeState extends State<OrderType> {

  String? title;
  Color? color;
  TextStyle? textStyle;
  
  @override
  Widget build(BuildContext context) {

    switch (widget.type) {
      case 1:
        setState(() {
          title = "DINE-IN";
          color = errorColor;
        });
        break;
      case 2:
        setState(() {
          title = "RESERVATION";
          color = infoColor;
        });
        break;
      default:
        setState(() {
          title = "NULL";
          color = secondaryTextColor;
        });
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 2, horizontal: 6
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Text(
            title!,
            style: tertiaryTextStyle.copyWith(
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}