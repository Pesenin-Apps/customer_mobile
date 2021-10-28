import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/customer_vm.dart';
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

    Widget titleCartList() {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: Text(
        'Daftar Item',
        style: primaryTextStyle.copyWith(
          fontSize: 16,
          fontWeight: semiBold,
        ),
      ),
    );
  }

    Widget cartIsEmpty() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin*2.5,
          right: defaultMargin,
          left: defaultMargin,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/icon_empty_cart.png',
              width: 80,
            ),
            const SizedBox(height: 20),
            Text(
              'Opss!',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            Text(
              'Keranjang anda Kosong',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Silahkan pilih menu',
              maxLines: 2,
              style: secondaryTextStyle,
            ),
            Text(
              'yang akan anda Pesan',
              maxLines: 2,
              style: secondaryTextStyle,
            ),
          ]
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
          cartIsEmpty(),
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