import 'package:customer_pesenin/core/helpers/routes_generator.dart';
import 'package:customer_pesenin/core/models/order.dart';
import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/ui/views/customer/orders/detail_screen.dart';
import 'package:customer_pesenin/ui/widgets/order/order_type.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  const OrderTile({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor3,
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
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context, 
            CustomerOrderDetailScreen.routeName,
            arguments: ScreenArguments(
              id: order.id.toString(), 
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDateWithDay.format(
                    DateTime.parse(order.createdAt!).toLocal(),
                  ),
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: semiBold
                  ),
                ),
                Text(
                  formatTime.format(
                    DateTime.parse(order.createdAt!).toLocal(),
                  ),
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: semiBold
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    order.table == null ? Text(
                      'Menunggu Nomor Meja',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ) : Text(
                      '${order.table!.section!.name} No. ${order.table!.number}',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      order.orderNumber.toString(),
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      formatCurrency.format(order.totalOverall),
                      style: priceTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
                OrderType(type: order.type!),
              ],
            ),
          ],
        ),
      ),
    );
  }
}