import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/models/cart.dart';
import 'package:customer_pesenin/core/viewmodels/cart_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartCard extends StatefulWidget {
  final CartModel? cart;
  const CartCard(
    this.cart, { 
    Key? key,
  }
  ) : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
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
              'https://pesenin.onggolt-dev.com/uploads/' + widget.cart!.product!.image.toString(),
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
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              widget.cart!.product!.image.toString() != 'null' ? imageUrl() : imagePlaceholder(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cart!.product!.name.toString(),
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      formatCurrency.format(widget.cart!.product!.price),
                      style: priceTextStyle,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (mounted) cartVM.addQty(widget.cart!.id!);
                    },
                    child: Image.asset(
                      'assets/icons/icon_cart_add.png',
                      width: 18,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.cart!.qty.toString(),
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(height: 2),
                  GestureDetector(
                    onTap: () {
                      if (mounted) cartVM.reduceQty(widget.cart!.id!);
                    },
                    child: Image.asset(
                      'assets/icons/icon_cart_minus.png',
                      width: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              if (mounted) cartVM.removeCart(widget.cart!.id!);
            },
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/icon_cart_remove.png',
                  width: 10,
                ),
                const SizedBox(width: 4),
                Text(
                  'Hapus',
                  style: dangerTextStyle.copyWith(
                    fontSize: 12,
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