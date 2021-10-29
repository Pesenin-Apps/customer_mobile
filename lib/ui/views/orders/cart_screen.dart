import 'dart:async';

import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/cart_vm.dart';
import 'package:customer_pesenin/core/viewmodels/customer_vm.dart';
import 'package:customer_pesenin/ui/views/onboarding_screen.dart';
import 'package:customer_pesenin/ui/views/orders/order_screen.dart';
import 'package:customer_pesenin/ui/widgets/cart/cart_card.dart';
import 'package:customer_pesenin/ui/widgets/cart/cart_is_empty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  static const routeName = '/cart';
  const Cart({ Key? key }) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  bool isLoadingCheckOut = false;

  @override
  void initState() {
    if (mounted) getUser();
    super.initState();
  }

  getUser() async {
    await Provider.of<CustomerVM>(context, listen: false).fetchCustomer();
  }

  void checkOutAction() {
    setState(() {
      isLoadingCheckOut = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      Provider.of<CustomerVM>(context, listen: false).checkOut();
      Navigator.pushNamedAndRemoveUntil(context, OnBoardingScreen.routeName, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    CartVM cartVM = Provider.of<CartVM>(context);

    Future<void> showConfirmDialog() async {
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
                    child: GestureDetector(
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
                    'Anda ingin Check Out?',
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Anda harus Check In ulang',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    'jika ingin melakukan',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    'pemesanan kembali',
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
                        checkOutAction();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: alertColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Check Out',
                        style: primaryTextStyle.copyWith(
                          fontSize: 13,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                  )
                  // GestureDetector(
                  //   onTap: checkOutAction,
                  //   child: Container(
                  //     width: 150,
                  //     height: 40,
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 12,
                  //       vertical: 10,
                  //     ),
                  //     decoration:  BoxDecoration(
                  //       borderRadius: BorderRadius.circular(12),
                  //       color: alertColor,
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         isLoadingCheckOut ? Container(
                  //           width: 16,
                  //           height: 16,
                  //           margin: EdgeInsets.zero,
                  //           child: CircularProgressIndicator(
                  //             strokeWidth: 2,
                  //             valueColor: AlwaysStoppedAnimation(
                  //               primaryTextColor,
                  //             ),
                  //           ),
                  //         ) : const SizedBox(),
                  //         isLoadingCheckOut ? const SizedBox(width: 8) : const SizedBox(),
                  //         Text(
                  //           'Check Out',
                  //           style: primaryTextStyle.copyWith(
                  //             fontSize: 13,
                  //             fontWeight: semiBold,
                  //           ),
                  //           textAlign: TextAlign.center,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        )
      );
    }

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
                      '${customerVM.customer?.checkInNumber}',
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: bold,
                      ),
                    ),
                    Text(
                      '${customerVM.customer?.name}',
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
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
            ),
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
                        Navigator.pushNamed(context, OrderScreen.routeName);
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
                        showConfirmDialog();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: alertColor,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isLoadingCheckOut ? Container(
                        width: 16,
                        height: 16,
                        margin: EdgeInsets.zero,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(
                            primaryTextColor,
                          ),
                        ),
                      ) : Row(
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