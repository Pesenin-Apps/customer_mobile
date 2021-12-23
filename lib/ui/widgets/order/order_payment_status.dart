import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:flutter/material.dart';

class OrderPaymentStatus extends StatelessWidget {

  final bool? status;

  const OrderPaymentStatus({
    Key? key,
    required this.status
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case true:
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: infoColor,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.circle,
                size: 5,
                color: infoColor,
              ),
              const SizedBox(width: 6),
              Text(
                'Sudah Bayar',
                style: infoTextStyle.copyWith(
                  fontSize: 9,
                ),
              ),
            ],
          ),
        );
      default:
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: errorColor,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.circle,
                size: 5,
                color: errorColor,
              ),
              const SizedBox(width: 6),
              Text(
                'Bulum Bayar',
                style: dangerTextStyle.copyWith(
                  fontSize: 9,
                ),
              ),
            ],
          ),
        );
    }
  }
}