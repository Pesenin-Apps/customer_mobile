import 'dart:io';

import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/core/viewmodels/order_vm.dart';
import 'package:customer_pesenin/core/viewmodels/user_vm.dart';
import 'package:customer_pesenin/ui/widgets/order/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerOrderHistoryScreen extends StatefulWidget {
  static const routeName = '/order-history  ';
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
    if (mounted) setState(() => _isLoadingPage = true );
    if (mounted) await Provider.of<OrderVM>(context, listen: false).fetchHistoryCustomerOrders();
    if (mounted) setState(() => _isLoadingPage = false );
  }

  Future refreshData() async{
    if (mounted) await Provider.of<OrderVM>(context, listen: false).fetchHistoryCustomerOrders();
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {

    Widget orderHistoryLists() {
      return Consumer<OrderVM>(
        builder: (context, orderVM, child) => orderVM.historyCustomerOrders.isEmpty ? const SizedBox() : Container(
          margin: EdgeInsets.symmetric(
            vertical: defaultMargin,
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

    return SafeArea(
      child: _isLoadingPage ? Scaffold(
        body: Center(
            child: SizedBox(
              height: 33,
              width: 33,
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          ),
      ) : Scaffold(
        backgroundColor: backgroundColor1,
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          title: const Text('Riwayat Pesanan'),
        ),
        body: Platform.isIOS ? Container() : RefreshIndicator(
          backgroundColor: backgroundColor1,
          color: primaryColor,
          onRefresh: refreshData,
          child: ListView(
            children: [
              orderHistoryLists(),
            ],
          ),
        ),
      ),
    );

  }

}