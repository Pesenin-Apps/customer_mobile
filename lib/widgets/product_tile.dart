import 'package:customer_pesenin/theme.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {

  const ProductTile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(
        left: defaultMargin,
        right: defaultMargin,
        bottom: (defaultMargin)/3,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/ikan_bakar_sample.jpg',
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ikan Bakar',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Ikan Bakar Ter Enak',
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Rp. 55.000',
                  style: priceTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              print('add to cart!!!');
            },
            child: Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: primaryColor
                ),
              ),
              child: Image.asset(
                'assets/icons/icon_add_to_cart.png',
                width: 16,
              ),
            ),
          ),
        ],
      ),
    );

  }

}