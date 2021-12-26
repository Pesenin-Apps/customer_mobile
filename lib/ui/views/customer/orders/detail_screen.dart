import 'package:customer_pesenin/core/helpers/routes_generator.dart';
import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/core/viewmodels/order_vm.dart';
import 'package:customer_pesenin/ui/views/customer/orders/choose_product_screen.dart';
import 'package:customer_pesenin/ui/views/customer/orders/updated_screen.dart';
import 'package:customer_pesenin/ui/views/no_inet_screen.dart';
import 'package:customer_pesenin/ui/widgets/order/description_tile.dart';
import 'package:customer_pesenin/ui/widgets/order/order_item_tile.dart';
import 'package:customer_pesenin/ui/widgets/order/order_payment_status.dart';
import 'package:customer_pesenin/ui/widgets/order/order_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerOrderDetailScreen extends StatefulWidget {
  static const routeName = '/order-detail';

  final String? id;
  const CustomerOrderDetailScreen({ 
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _CustomerOrderDetailScreenState createState() => _CustomerOrderDetailScreenState();
}

class _CustomerOrderDetailScreenState extends State<CustomerOrderDetailScreen> {

  bool _isLoadingPage = false;
  bool _isLoadingCancel = false;

   @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    Provider.of<ConnectionVM>(context, listen: false).startMonitoring();
    setState(() => _isLoadingPage = true );
    await Provider.of<OrderVM>(context, listen: false).fetchCustomerOrderDetail(widget.id!);
    setState(() => _isLoadingPage = false );
  }

  void onSubmitCancel() {
    setState(() => _isLoadingCancel = true );
    Future.delayed(const Duration(seconds: 2), () async {
      final response =  await Provider.of<OrderVM>(context, listen: false).cancelCustomerOrder(widget.id!);
      if (response) {
        // refresh data
        await Provider.of<OrderVM>(context, listen: false).fetchOnGoingCustomerOrders();
        await Provider.of<OrderVM>(context, listen: false).fetchHistoryCustomerOrders();
        setState(() { });
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Berhasil, Pesanan telah di Batalkan!',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: errorColor,
            content: const Text(
              'Gagal, Terjadi Kesalahan!',
            ),
          ),
        );
        setState(() => _isLoadingCancel = false );
      }
    });
  }

  Future refreshData() async {
    if (mounted) await Provider.of<OrderVM>(context, listen: false).fetchCustomerOrderDetail(widget.id!);
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {

    Future<void> showConfirmDialogCancel() async {
      return showDialog(
        context: context, 
        builder: (BuildContext context) => Container(
          margin: EdgeInsets.zero,
          width: MediaQuery.of(context).size.width - (2 * defaultMargin),
          child: AlertDialog(
            backgroundColor: backgroundColor3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: primaryTextColor,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.error_outline_rounded,
                    color: primaryColor,
                    size: 100,
                  ),
                  const SizedBox( height: 12),
                  Text(
                    'Pesanan Ini Dibatalkan?',
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Pesanan ini akan di Batalkan',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    'secara permanen',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 150,
                    height: 40,
                    margin: EdgeInsets.zero,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onSubmitCancel();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: errorColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Ya, Batalkan',
                        style: tertiaryTextStyle.copyWith(
                          fontSize: 13,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      );
    }

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
                  OrderStatus(status: orderVM.order.status),
                ],
              ),
              const SizedBox(height: 12),
              DescriptionTile(title: 'Order Id', description: orderVM.order.orderNumber.toString()),
              DescriptionTile(title: 'Jenis', description: orderVM.order.type == typeDineIn ? 'DINE-IN' : 'RESERVATION'),
              DescriptionTile(title: 'Tanggal', description: formatDateWithDay.format(
                DateTime.parse(orderVM.order.createdAt!).toLocal(),
              )),
              DescriptionTile(title: 'Waktu', description: formatTime.format(
                DateTime.parse(orderVM.order.createdAt!).toLocal(),
              )),
              DescriptionTile(title: 'Pelayan', description: orderVM.order.waiter!.users!.fullname),
              DescriptionTile(title: 'Meja Bagian', description: orderVM.order.table!.section!.name.toString()),
              DescriptionTile(title: 'Nomor Meja', description: orderVM.order.table!.number.toString()),
            ],
          ),
        ),
      );
    }

    Widget orderItems() {
      return Container(
        margin: EdgeInsets.only(
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
                  orderVM.canChangedOrderExist ? InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context, 
                        CustomerOrderUpdateScreen.routeName,
                        arguments: ScreenArguments(
                          id: widget.id!, 
                        ),
                      );
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
                  for (var i = 0; i < orderVM.order.orderItem!.length; i++) OrderItemTile(orderItem : orderVM.order.orderItem![i]),
                  const SizedBox(height: 5),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context, 
                            ChooseProductScreen.routeName,
                            arguments: ScreenArguments(
                              table: orderVM.order.table!.id,
                              type: 'additional',
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: orderVM.orderIsPaid ? const SizedBox() : Text(
                            '+ Tambah Item',
                            style: themeTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
                  OrderPaymentStatus(status: orderVM.order.isPaid),
                ],
              ),
              const SizedBox(height: 12),
              DescriptionTile(title: 'Subtotal', description: formatCurrency.format(orderVM.order.totalPrice)),
              DescriptionTile(title: 'Pajak (PPN 10%)', description: formatCurrency.format(orderVM.order.tax)),
              const SizedBox(height: 12),
              Divider(
                thickness: 1,
                color: secondaryTextColor,
                // color: Color(0xff463F32),
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
                    formatCurrency.format(orderVM.order.totalOverall),
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

    Widget buttonSubmit() {
      return Consumer<OrderVM>(
        builder: (context, orderVM, child) => orderVM.canNotChangedOrderExist ? SizedBox(height: defaultMargin) : Container(
          height: 35,
          width: double.infinity,
          margin: EdgeInsets.only(
            top: defaultMargin,
            bottom: defaultMargin,
          ),
          child: TextButton(
            onPressed: () {
              showConfirmDialogCancel();
            },
            style: TextButton.styleFrom(
              backgroundColor: errorColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )
            ),
            child: _isLoadingCancel ? Container(
              width: 16,
              height: 16,
              margin: EdgeInsets.zero,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(
                  backgroundColor3,
                ),
              ),
            ) : Text(
              'Batalkan Pesanan',
              style: tertiaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: semiBold
              ),
            ),
          ),
        ),
      );
    }

    Widget content() {
      return RefreshIndicator(
        backgroundColor: backgroundColor3,
        color: primaryColor,
        onRefresh: refreshData,
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin
          ),
          children: [
            orderDetail(),
            orderItems(),
            paymentDetail(),
            buttonSubmit(),
          ],
        ),
      );
    }
    
    return Consumer<ConnectionVM>(
      builder: (context, connectionVM, _) => connectionVM.isOnline != null && connectionVM.isOnline! ? SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor3,
          appBar: AppBar(
            backgroundColor: primaryColor,
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            elevation: 0,
            centerTitle: true,
            title: const Text('Pesanan'),
          ),
          body: _isLoadingPage ? Center(
            child: SizedBox(
              height: 33,
              width: 33,
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          ) : content(),
        ),
      ) : const NoInternetConnectionScreen(),
    );

  }

}