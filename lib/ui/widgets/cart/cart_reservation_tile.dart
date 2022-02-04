import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/models/cart.dart';
import 'package:customer_pesenin/core/viewmodels/cart_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartReservationTile extends StatefulWidget {
  final CartModel cart;
  const CartReservationTile({
    Key? key,
    required this.cart
  }) : super(key: key);

  @override
  _CartReservationTileState createState() => _CartReservationTileState();
}

class _CartReservationTileState extends State<CartReservationTile> {
  @override
  Widget build(BuildContext context) {

    CartVM cartVM = Provider.of<CartVM>(context);

    Widget imageUrl() {
      return FadeInImage.assetNetwork(
        placeholder: 'assets/images/placeholder.jpg', 
        image: baseUrlImage + widget.cart.product!.image.toString(),
        fit: BoxFit.cover,
        width: 60,
        height: 60,
      );
    }

    // Widget imageUrl() {
    //   return Container(
    //     width: 60,
    //     height: 60,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(12),
    //       image: DecorationImage(
    //         image: NetworkImage(
    //           baseUrlImage + widget.cart.product!.image.toString(),
    //         ),
    //       ),
    //     ),
    //   );
    // }

    Widget imagePlaceholder() {
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: const DecorationImage(
            image: AssetImage(
              'assets/images/placeholder.jpg',
            ),
          ),
          color: backgroundColor3,
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(
        top: defaultMargin/3,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: backgroundColor3,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: roundedBorderColor
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            spreadRadius: 0,
            blurRadius: 5,
            color: backgroundColor4.withOpacity(0.2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              widget.cart.product!.image.toString() != 'null' ? imageUrl() : imagePlaceholder(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cart.product!.name.toString(),
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      formatCurrency.format(widget.cart.product!.price),
                      style: priceTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (mounted) cartVM.addQtyReservation(widget.cart.id!);
                    },
                    child: Image.asset(
                      'assets/icons/icon_cart_add.png',
                      width: 23,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.cart.qty.toString(),
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(height: 2),
                  InkWell(
                    onTap: () {
                      if (mounted) cartVM.reduceQtyReservation(widget.cart.id!);
                    },
                    child: Image.asset(
                      'assets/icons/icon_cart_minus.png',
                      width: 23,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {
              if (mounted) cartVM.removeCartReservation(widget.cart.id!);
            },
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/icon_cart_remove.png',
                  width: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  'Hapus',
                  style: dangerTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}