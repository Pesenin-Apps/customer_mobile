import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:flutter/material.dart';

class OrderStatus extends StatefulWidget {

  final int? status;
  final bool? addCircle;
  const OrderStatus({
    Key? key,
    required this.status,
    this.addCircle = true,
  }) : super(key: key);

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {

  String? title;
  Color? color;
  TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {

    switch (widget.status) {
      case 1:
        setState(() {
          title = "NEW";
          color = dangerColor;
          textStyle = dangerTextStyle;
        });
        break;
      case 2:
        setState(() {
          title = "PROCESSED";
          color = warningColor;
          textStyle = warningTextStyle;
        });
        break;
      case 3:
        setState(() {
          title = "FINISHED";
          color = infoColor;
          textStyle = infoTextStyle;
        });
        break;
      default:
        setState(() {
          title = "NULL";
          color = secondaryTextColor;
          textStyle = secondaryTextStyle;
        });
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 2, horizontal: 6
      ),
      decoration: widget.addCircle! ? BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color!,
        ),
      ) : BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: color!,
        ),
      ),
      child: Row(
        children: [
          widget.addCircle! ? Icon(
            Icons.circle,
            size: 5,
            color: color!,
          ) : const SizedBox(),
          widget.addCircle! ? const SizedBox(width: 6) : const SizedBox(),
          Text(
            title!,
            style: textStyle!.copyWith(
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
    
  }

}