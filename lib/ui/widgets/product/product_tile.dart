import 'package:flutter/material.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/models/product.dart';

class ProductTile extends StatelessWidget {

  final Product product;
  const ProductTile(
    this.product, { 
      Key? key 
    }
  ) : super(key: key);


  @override
  Widget build(BuildContext context) {

    Widget imageUrl() {
      return Image.network(
        'https://pesenin.onggolt-dev.com/uploads/' + product.image.toString(),
        width: 90,
        height: 90,
        fit: BoxFit.cover,
      );
    }

    Widget imagePlaceholder() {
      return  Image.asset(
        'assets/images/placeholder.jpg',
        width: 90,
        height: 90,
        fit: BoxFit.cover,
      );
    }

    Widget productReady() {
      return GestureDetector(
        onTap: () {
          print('product ${product.id} add to cart');
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
      );
    }

    Widget productNotReady() {
      return  GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: alertColor,
              content: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(text: 'Maaf, '),
                    TextSpan(text: '${product.name} ', style: const TextStyle(fontWeight: FontWeight.w700)),
                    const TextSpan(text: 'tidak tersedia saat ini!'),
                  ],
                ),
              )
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: alertColor
            ),
          ),
          child: Icon(
            Icons.block,
            color: alertColor,
            size: 16,
          ),
        ),
      );
    }

    Widget isReady() {
      return product.isReady.toString() == 'true' ? productReady() : productNotReady();
    }

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
            child: product.image.toString() != 'null' ? imageUrl() : imagePlaceholder(),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${product.category?.name}',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  product.name.toString(),
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  formatCurrency.format(product.price),
                  style: priceTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          isReady(),
        ],
      ),
    );

  }

}