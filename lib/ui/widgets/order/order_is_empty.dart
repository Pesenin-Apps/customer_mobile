import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:flutter/material.dart';

class OrderIsEmpty extends StatelessWidget {
  const OrderIsEmpty({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: primaryColor,
            size: 100,
          ),
          const SizedBox(height: 20),
          Text(
            'Tidak Ada Pesanan',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Anda belum melakukan Pemesanan',
            style: secondaryTextStyle,
          ),
        ],
      ),
    );
  }
}