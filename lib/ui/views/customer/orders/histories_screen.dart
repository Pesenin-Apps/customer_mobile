import 'dart:io';

import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/core/viewmodels/order_vm.dart';
import 'package:customer_pesenin/ui/views/no_inet_screen.dart';
import 'package:customer_pesenin/ui/widgets/order/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerOrderHistoryScreen extends StatefulWidget {
  static const routeName = '/order-history';
  const CustomerOrderHistoryScreen({ Key? key }) : super(key: key);

  @override
  _CustomerOrderHistoryScreenState createState() => _CustomerOrderHistoryScreenState();
}

class _CustomerOrderHistoryScreenState extends State<CustomerOrderHistoryScreen> {

  bool _isLoadingPage = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    Provider.of<ConnectionVM>(context, listen: false).startMonitoring();
    setState(() => _isLoadingPage = true );
    await Provider.of<OrderVM>(context, listen: false).fetchHistoryCustomerOrders();
    setState(() => _isLoadingPage = false );
  }

  Future refreshData() async{
    await Provider.of<OrderVM>(context, listen: false).fetchHistoryCustomerOrders();
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {

    Widget orderHistoryLists() {
      return Consumer<OrderVM>(
        builder: (context, orderVM, child) => orderVM.historyCustomerOrders.isEmpty ? const SizedBox() : Container(
          margin: EdgeInsets.only(
            top: defaultMargin/1.5,
            bottom: defaultMargin,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  for (var i = 0; i < orderVM.historyCustomerOrders.length; i++) 
                    OrderTile(order: orderVM.historyCustomerOrders[i]),
                ],
              ),
            ],
          ),
        )
      );
    }

    return Consumer<ConnectionVM>(
      builder: (context, connectionVM, _) => connectionVM.isOnline != null && connectionVM.isOnline! ? SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor3,
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 0,
            title: const Text('Riwayat Pesanan'),
          ),
          body: _isLoadingPage ? Center(
            child: SizedBox(
              height: 33,
              width: 33,
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          ) : Platform.isIOS ? Container() : RefreshIndicator(
            backgroundColor: backgroundColor3,
            color: primaryColor,
            onRefresh: refreshData,
            child: ListView(
              children: [
                orderHistoryLists(),
              ],
            ),
          ),
        )
      ) : const NoInternetConnectionScreen(),
    ); 
  }

}