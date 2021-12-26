import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:flutter/material.dart';

class CartIsEmpty extends StatelessWidget {
  const CartIsEmpty({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: defaultMargin*2.5,
        right: defaultMargin,
        left: defaultMargin,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/icon_empty_cart.png',
            width: 80,
          ),
          const SizedBox(height: 20),
          Text(
            'Keranjang anda Kosong',
            style: primaryTextStyle.copyWith(
              fontSize: 14,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Silahkan pilih menu',
            maxLines: 2,
            style: secondaryTextStyle.copyWith(
              fontSize: 12,
            ),
          ),
          Text(
            'yang akan anda Pesan',
            maxLines: 2,
            style: secondaryTextStyle.copyWith(
              fontSize: 12,
            ),
          ),
        ]
      ),
    );
  }
}