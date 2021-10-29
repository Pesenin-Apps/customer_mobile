import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/cart_vm.dart';
import 'package:customer_pesenin/core/viewmodels/customer_vm.dart';
import 'package:customer_pesenin/ui/widgets/cart/cart_card.dart';
import 'package:customer_pesenin/ui/widgets/cart/cart_is_empty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  static const routeName = '/cart';
  const Cart({ Key? key }) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    await Provider.of<CustomerVM>(context, listen: false).fetchCustomer();
  }

  @override
  Widget build(BuildContext context) {
    
    CartVM cartVM = Provider.of<CartVM>(context);

    Widget customerInfo() {
      return Container(
        margin: const EdgeInsets.only(top: 20.0),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: backgroundColor1,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/icons/icon_avatar.png',
                width: 50,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Consumer<CustomerVM>(
                builder: (context, customerVM, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${customerVM.customer?.name}',
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: bold,
                      ),
                    ),
                    Text(
                      '${customerVM.customer?.checkInNumber}',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: bold,
                      ),
                    ),
                    Text(
                      '${customerVM.customer?.table?.name}',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: semiBold
                      ),
                    ),
                    Text(
                      '${customerVM.customer?.deviceDetection}',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget buttonOrder() {
      return Container(
        height: 40,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30, bottom: 30),
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )
          ),
          child: Text(
            'Pesan Sekarang',
            style: primaryTextStyle.copyWith(
              fontSize: 13,
              fontWeight: semiBold
            ),
          ),
        ),
      );
    }

    Widget cartLists() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daftar Item',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 10),
                Column(
                  children: cartVM.carts.map((e) => CartCard(e)).toList(),
                ),
                buttonOrder(),
                const SizedBox(height: 20),
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
          customerInfo(),
          cartVM.carts.isEmpty ? const CartIsEmpty() : cartLists(),
        ],
      );
    }

    Widget customNavigationBar() {
      return Container(
        height: 80,
        decoration: BoxDecoration(
          color: backgroundColor1,
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    margin: EdgeInsets.symmetric(
                      horizontal: defaultMargin/3,
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, '/checkout');
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: secondaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Pesanan Saya',
                            style: primaryTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: semiBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ), 
                ),
                // it hidden if is a order processed
                Expanded(
                  child: Container(
                    height: 40,
                    margin: EdgeInsets.symmetric(
                      horizontal: defaultMargin/3,
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, '/checkout');
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: alertColor,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.logout,
                            color: primaryTextColor,
                            size: 16,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Check Out',
                              style: primaryTextStyle.copyWith(
                                fontSize: 13,
                                fontWeight: semiBold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ), 
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: backgroundColor1,
        elevation: 0,
        centerTitle: true,
        title: const Text('Keranjang'),
      ),
      body: content(),
      bottomNavigationBar: customNavigationBar(),
    );

  }
}