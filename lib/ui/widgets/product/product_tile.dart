import 'package:customer_pesenin/core/viewmodels/cart_vm.dart';
import 'package:flutter/material.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/models/product.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatelessWidget {

  final Product product;
  const ProductTile(
    this.product, { 
      Key? key 
    }
  ) : super(key: key);


  @override
  Widget build(BuildContext context) {

    CartVM cartVM = Provider.of<CartVM>(context);

    Widget imageUrl() {
      return FadeInImage.assetNetwork(
        placeholder: 'assets/images/placeholder.jpg', 
        image: baseUrlImage + product.image.toString(),
        fit: BoxFit.cover,
        width: 90,
        height: 90,
      );
      // return Image.network(
      //   'https://pesenin.onggolt-dev.com/uploads/' + product.image.toString(),
      //   width: 90,
      //   height: 90,
      //   fit: BoxFit.cover,
      // );
    }

    Widget imagePlaceholder() {
      return  Image.asset(
        'assets/images/placeholder.jpg',
        width: 90,
        height: 90,
        fit: BoxFit.cover,
      );
    }

    Widget productIsReady() {
      return InkWell(
        onTap: () {
          cartVM.addCart(product);
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

    Widget productAlredyExistInCart() {
      return Container(
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: infoColor
          ),
        ),
        child: Icon(
          Icons.add_task_rounded,
          color: infoColor,
          size: 16,
        ),
      );
    }

    Widget productIsNotReady() {
      return  InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: errorColor,
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
              color: errorColor
            ),
          ),
          child: Icon(
            Icons.block,
            color: errorColor,
            size: 16,
          ),
        ),
      );
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
          const SizedBox(width: 7),
          product.isReady.toString() == 'true' ? ( cartVM.productExist(product) ? productAlredyExistInCart() : productIsReady() ) : productIsNotReady(),
        ],
      ),
    );

  }

}