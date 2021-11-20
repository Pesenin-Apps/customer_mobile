import 'dart:io';
import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/core/viewmodels/order_vm.dart';
import 'package:customer_pesenin/ui/views/no_inet_screen.dart';
import 'package:customer_pesenin/ui/widgets/order/order_tile.dart';
import 'package:customer_pesenin/ui/widgets/order/order_description_tile.dart';
import 'package:customer_pesenin/ui/widgets/order/order_is_empty.dart';
import 'package:customer_pesenin/ui/widgets/order/order_payment_status.dart';
import 'package:customer_pesenin/ui/widgets/order/order_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/my-order';
  const OrderScreen({ Key? key }) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

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
    await orderVM.fetchOrderDetail();
    setState(() {
      isLoadingPage = false;
    });
  }

  Future refreshData() async{
    if (mounted) await Provider.of<OrderVM>(context, listen: false).fetchOrderDetail();
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
          color: backgroundColor2,
          borderRadius: BorderRadius.circular(12),
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
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  OrderStatus(status: orderVM.orderDetail.status),
                ],
              ),
              const SizedBox(height: 12),
              OrderDescriptionTile(title: 'Order Id', description: orderVM.orderDetail.orderNumber.toString()),
              OrderDescriptionTile(title: 'Tanggal', description: formatDateWithDay.format(
                DateTime.parse(orderVM.orderDetail.createdAt!).toLocal(),
              )),
              OrderDescriptionTile(title: 'Waktu', description: formatTime.format(
                DateTime.parse(orderVM.orderDetail.createdAt!).toLocal(),
              )),
              OrderDescriptionTile(title: 'Pelayan', description: orderVM.orderDetail.waiter!.users!.fullname.toString()),
              OrderDescriptionTile(title: 'Meja Bagian', description: orderVM.orderDetail.table!.section!.name.toString()),
              OrderDescriptionTile(title: 'Nomor Meja', description: orderVM.orderDetail.table!.number.toString()),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daftar Pesanan',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            Consumer<OrderVM>(
              builder: (context, orderVM, child) => Column(
                children: [
                  for (var i = 0; i < orderVM.orderDetail.orderItem!.length; i++) OrderTile(orderItem: orderVM.orderDetail.orderItem![i]),
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
                            '+ Tambah Pesanan Baru',
                            style: primaryTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
              ),
            ),
          ],
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
          color: backgroundColor2,
          borderRadius: BorderRadius.circular(12),
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
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  OrderPaymentStatus(status: orderVM.orderDetail.isPaid),
                ],
              ),
              const SizedBox(height: 12),
              OrderDescriptionTile(title: 'Subtotal', description: formatCurrency.format(orderVM.orderDetail.totalPrice)),
              OrderDescriptionTile(title: 'Pajak (PPN 10%)', description: formatCurrency.format(orderVM.orderDetail.tax)),
              const SizedBox(height: 12),
              const Divider(
                thickness: 1,
                color: Color(0xff463F32),
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
                    formatCurrency.format(orderVM.orderDetail.totalOverall),
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
      builder: (context, connectionVM, _) => connectionVM.isOnline != null && connectionVM.isOnline! ? Scaffold(
        backgroundColor: backgroundColor1,
        appBar: AppBar(
          backgroundColor: backgroundColor3,
          elevation: 0,
          centerTitle: true,
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
          ) : Consumer<OrderVM>(builder: (context, orderVM, _) => orderVM.isExist ? (Platform.isIOS ? Container() : RefreshIndicator(
            backgroundColor: backgroundColor1,
            color: primaryColor,
            onRefresh: refreshData,
            child: content(),
          )) : const OrderIsEmpty(),
        ),
      ) : const NoInternetConnectionScreen(),
    );

  }

}