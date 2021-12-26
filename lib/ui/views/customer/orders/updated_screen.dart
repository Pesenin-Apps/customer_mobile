import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/core/viewmodels/order_vm.dart';
import 'package:customer_pesenin/ui/views/no_inet_screen.dart';
import 'package:customer_pesenin/ui/widgets/order/order_item_tile_edited.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerOrderUpdateScreen extends StatefulWidget {
  static const routeName = '/order-update';

  final String? id;
  const CustomerOrderUpdateScreen({ 
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _CustomerOrderUpdateScreenState createState() => _CustomerOrderUpdateScreenState();
}

class _CustomerOrderUpdateScreenState extends State<CustomerOrderUpdateScreen> {

  bool _isLoadingPage = false;

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

  Future refreshData() async{
    if (mounted) await Provider.of<OrderVM>(context, listen: false).fetchCustomerOrderDetail(widget.id!);
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {

    Widget orderItemLists() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin/1.5,
          bottom: defaultMargin,
        ),
        child: Consumer<OrderVM>(
          builder: (context, orderVM, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < orderVM.order.orderItem!.length; i++) 
                orderVM.order.orderItem![i].status! <= orderItemStatusNew 
                ? OrderItemTileEdited(orderId: widget.id!, orderItem : orderVM.order.orderItem![i])
                : const SizedBox(),
            ],
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
            orderItemLists(),
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
            elevation: 0,
            centerTitle: true,
            title: const Text('Ubah Item'),
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