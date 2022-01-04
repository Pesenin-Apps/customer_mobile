import 'dart:io';

import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/core/viewmodels/order_vm.dart';
import 'package:customer_pesenin/ui/views/guest/orders/updated_screen.dart';
import 'package:customer_pesenin/ui/views/no_inet_screen.dart';
import 'package:customer_pesenin/ui/widgets/order/order_description_tile.dart';
import 'package:customer_pesenin/ui/widgets/order/order_is_empty.dart';
import 'package:customer_pesenin/ui/widgets/order/order_item_tile.dart';
import 'package:customer_pesenin/ui/widgets/order/order_payment_status.dart';
import 'package:customer_pesenin/ui/widgets/order/order_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GuestOrderDetailScreen extends StatefulWidget {
  static const routeName = '/order-detail-guest';
  const GuestOrderDetailScreen({ Key? key }) : super(key: key);

  @override
  _GuestOrderDetailScreenState createState() => _GuestOrderDetailScreenState();
}

class _GuestOrderDetailScreenState extends State<GuestOrderDetailScreen> {
  
  bool isLoadingPage = false;

  @override
  void initState() {
    Provider.of<ConnectionVM>(context, listen: false).startMonitoring();
    setData();
    super.initState();
  }

  void setData() async {
    setState(() {
      isLoadingPage = true;
    });
    final OrderVM orderVM = Provider.of(context, listen: false);
    await orderVM.fetchGuestOrderDetail();
    setState(() {
      isLoadingPage = false;
    });
  }

  Future refreshData() async{
    if (mounted) await Provider.of<OrderVM>(context, listen: false).fetchGuestOrderDetail();
    setState(() { });
  }
  
  @override
  Widget build(BuildContext context) {

    Widget orderDetail() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        padding: const EdgeInsets.all(20),
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
        child: Consumer<OrderVM>(
          builder: (context, orderVM, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Detail Pesanan',
                    style: primaryTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: semiBold,
                    ),
                  ),
                  OrderStatus(status: orderVM.guestOrder.status),
                ],
              ),
              const SizedBox(height: 12),
              OrderDescriptionTile(title: 'Order Id', description: orderVM.guestOrder.orderNumber.toString()),
              OrderDescriptionTile(title: 'Tanggal', description: formatDateWithDay.format(
                DateTime.parse(orderVM.guestOrder.createdAt!).toLocal(),
              )),
              OrderDescriptionTile(title: 'Waktu', description: formatTime.format(
                DateTime.parse(orderVM.guestOrder.createdAt!).toLocal(),
              )),
              OrderDescriptionTile(title: 'Pelayan', description: orderVM.guestOrder.waiter!.users!.fullname.toString()),
              OrderDescriptionTile(title: 'Meja Bagian', description: orderVM.guestOrder.table!.section!.name.toString()),
              OrderDescriptionTile(title: 'Nomor Meja', description: orderVM.guestOrder.table!.number.toString()),
            ],
          ),
        ),
      ); 
    }

    Widget orderItems() {
      return Container(
        margin: EdgeInsetsDirectional.only(
          top: defaultMargin/1.5,
        ),
        child: Consumer<OrderVM>(
          builder: (context, orderVM, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Daftar Item',
                    style: primaryTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: semiBold,
                    ),
                  ),
                  orderVM.canChangedGuestOrderExist ? InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, GuestOrderUpdateScreen.routeName);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Text(
                        'Ubah Item',
                        style: themeTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                  ) : const SizedBox(),
                ],
              ),
              Column(
                children: [
                  for (var i = 0; i < orderVM.guestOrder.orderItem!.length; i++) OrderItemTile(orderItem: orderVM.guestOrder.orderItem![i]),
                  const SizedBox(height: 5),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          int count = 0;
                          Navigator.of(context).popUntil((_) => count++ >= 2);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Text(
                            '+ Tambah Item Baru',
                            style: themeTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
              ),
            ],
          ),
        ),
      );
    }

    Widget paymentDetail() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin/3,
          bottom: defaultMargin,
        ),
        padding: const EdgeInsets.all(20),
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
        child: Consumer<OrderVM>(
          builder: (context, orderVM, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Detail Pembayaran',
                    style: primaryTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: semiBold,
                    ),
                  ),
                  OrderPaymentStatus(status: orderVM.guestOrder.isPaid),
                ],
              ),
              const SizedBox(height: 12),
              OrderDescriptionTile(title: 'Subtotal', description: formatCurrency.format(orderVM.guestOrder.totalPrice)),
              OrderDescriptionTile(title: 'Pajak (PPN 10%)', description: formatCurrency.format(orderVM.guestOrder.tax)),
              const SizedBox(height: 12),
              Divider(
                thickness: 1,
                color: secondaryTextColor,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Pembayaran',
                    style: priceTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    formatCurrency.format(orderVM.guestOrder.totalOverall),
                    style: priceTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin
        ),
        children: [
          orderDetail(),
          orderItems(),
          paymentDetail(),
        ],
      );
    }

    return Consumer<ConnectionVM>(
      builder: (context, connectionVM, _) => connectionVM.isOnline != null && connectionVM.isOnline! ? SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor3,
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 0,
            title: const Text('Pesanan Saya')
          ),
          body: isLoadingPage? Center(
              child: SizedBox(
                height: 33,
                width: 33,
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
            ) : Consumer<OrderVM>(builder: (context, orderVM, _) => orderVM.isExistGuestOrder ? (Platform.isIOS ? Container() : RefreshIndicator(
              backgroundColor: backgroundColor3,
              color: primaryColor,
              onRefresh: refreshData,
              child: content(),
            )) : const OrderIsEmpty(),
          ),
        ),
      ) : const NoInternetConnectionScreen(),
    );

  }

}