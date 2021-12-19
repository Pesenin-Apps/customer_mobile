import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/models/cart.dart';
import 'package:customer_pesenin/core/viewmodels/cart_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartTile extends StatefulWidget {
  final CartModel cart;
  const CartTile({
    Key? key,
    required this.cart
  }) : super(key: key);

  @override
  _CartTileState createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
 @override
  Widget build(BuildContext context) {

    CartVM cartVM = Provider.of<CartVM>(context);

    Widget imageUrl() {
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(
              'https://api-pesenin.onggolt-dev.com/uploads/' + widget.cart.product!.image.toString(),
            ),
          ),
        ),
      );
    }

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
        color: backgroundColor2,
        borderRadius: BorderRadius.circular(12),
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
                      style: priceTextStyle,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (mounted) cartVM.addQty(widget.cart.id!);
                    },
                    child: Image.asset(
                      'assets/icons/icon_cart_add.png',
                      width: 20,
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
                      if (mounted) cartVM.reduceQty(widget.cart.id!);
                    },
                    child: Image.asset(
                      'assets/icons/icon_cart_minus.png',
                      width: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {
              if (mounted) cartVM.removeCart(widget.cart.id!);
            },
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/icon_cart_remove.png',
                  width: 12,
                ),
                const SizedBox(width: 4),
                Text(
                  'Hapus',
                  style: dangerTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: light,
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