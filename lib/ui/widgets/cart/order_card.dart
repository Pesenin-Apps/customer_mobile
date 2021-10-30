import 'package:customer_pesenin/core/models/order.dart';
import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final OrderItem orderItem;
  const OrderCard(
    this.orderItem, { 
      Key? key 
    }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget imageUrl() {
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(
              'https://pesenin.onggolt-dev.com/uploads/' + orderItem.product!.image.toString(),
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
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          orderItem.product!.image.toString() != 'null' ? imageUrl() : imagePlaceholder(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderItem.product!.name.toString(),
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  orderItemStatusStr(orderItem.status!),
                  style: warningTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  formatCurrency.format(orderItem.product!.price),
                  style: priceTextStyle,
                ),
              ],
            ),
          ),
          const SizedBox( width: 12),
          Text(
            '${orderItem.qty} qty',
            style: secondaryTextStyle.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}