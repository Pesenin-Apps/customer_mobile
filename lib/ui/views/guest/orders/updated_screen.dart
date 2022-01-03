import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/core/viewmodels/order_vm.dart';
import 'package:customer_pesenin/ui/views/no_inet_screen.dart';
import 'package:customer_pesenin/ui/widgets/order/order_item_tile_edited_guest.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GuestOrderUpdateScreen extends StatefulWidget {
  static const routeName = '/order-update-guest';
  const GuestOrderUpdateScreen({ Key? key }) : super(key: key);

  @override
  _GuestOrderUpdateScreenState createState() => _GuestOrderUpdateScreenState();
}

class _GuestOrderUpdateScreenState extends State<GuestOrderUpdateScreen> {

  bool _isLoadingPage = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    Provider.of<ConnectionVM>(context, listen: false).startMonitoring();
    setState(() => _isLoadingPage = true );
    await Provider.of<OrderVM>(context, listen: false).fetchGuestOrderDetail();
    setState(() => _isLoadingPage = false );
  }

  Future refreshData() async{
    if (mounted) await Provider.of<OrderVM>(context, listen: false).fetchGuestOrderDetail();
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
              for (var i = 0; i < orderVM.guestOrder.orderItem!.length; i++) 
                orderVM.guestOrder.orderItem![i].status! <= orderItemStatusNew 
                ? OrderItemTileEditedGuest(orderId: orderVM.guestOrder.id, orderItem : orderVM.guestOrder.orderItem![i])
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