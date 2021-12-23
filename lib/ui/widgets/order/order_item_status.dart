import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:flutter/material.dart';

class OrderItemStatus extends StatefulWidget {
  final int? status;
  const OrderItemStatus({
    Key? key,
    required this.status
  }) : super(key: key);

  @override
  State<OrderItemStatus> createState() => _OrderItemStatusState();
}

class _OrderItemStatusState extends State<OrderItemStatus> {
  @override
  Widget build(BuildContext context) {

    String? title;
    TextStyle? textStyle;

    switch (widget.status) {
      case 1:
        setState(() {
          title = "Menunggu Verifikasi Pelayan";
          textStyle = errorTextStyle;
        });
        break;
      case 2:
        setState(() {
          title = "Sedang Diproses";
          textStyle = warningTextStyle;
        });
        break;
      case 3:
        setState(() {
          title = "Sedang Diproses";
          textStyle = warningTextStyle;
        });
        break;
      case 4:
        setState(() {
          title = "Telah Selesai";
          textStyle = infoTextStyle;
        });
        break;
      default:
        setState(() {
          title = "Null";
          textStyle = secondaryTextStyle;
        });
    }

    return Text(
      title!,
      style: textStyle!.copyWith(
        fontSize: 10,
      ),
    );

  }
}