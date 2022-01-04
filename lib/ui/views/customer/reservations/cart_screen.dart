import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/cart_vm.dart';
import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/ui/views/no_inet_screen.dart';
import 'package:customer_pesenin/ui/widgets/cart/cart_is_empty.dart';
import 'package:customer_pesenin/ui/widgets/cart/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerReservationCartScreen extends StatefulWidget {
  static const routeName = '/cart-customer-reservation';

  final String? type;
  const CustomerReservationCartScreen({ 
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  _CustomerReservationCartScreenState createState() => _CustomerReservationCartScreenState();
}

class _CustomerReservationCartScreenState extends State<CustomerReservationCartScreen> {

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    Provider.of<ConnectionVM>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    
    CartVM cartVM = Provider.of<CartVM>(context);

    Widget cartLists() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin/1.5,
          bottom: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Column(
                  children: cartVM.carts.map((e) => CartTile(cart: e)).toList(),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        children: [
          cartVM.carts.isEmpty ? const CartIsEmpty() : cartLists(),
        ],
      );
    }

    Widget customNavigationBar() {
      return Container(
        height: 75,
        decoration: BoxDecoration(
          color: backgroundColor3,
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              height: 35,
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin/3,
              ),
              child: TextButton(
                onPressed: () {
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 2);
                },
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Selesai',
                  style: tertiaryTextStyle.copyWith(
                    fontSize: 15,
                    fontWeight: semiBold,
                  ),
                ),
              ),
            ),
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
            title: const Text('Keranjang'),
          ),
          body: content(),
          bottomNavigationBar: cartVM.carts.isEmpty ? const SizedBox() : customNavigationBar(),
        ),
      ) : const NoInternetConnectionScreen(),
    );

  }
  
}