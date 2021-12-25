import 'dart:io';

import 'package:customer_pesenin/core/helpers/routes_generator.dart';
import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/core/viewmodels/order_vm.dart';
import 'package:customer_pesenin/core/viewmodels/user_vm.dart';
import 'package:customer_pesenin/ui/views/customer/orders/histories_screen.dart';
import 'package:customer_pesenin/ui/views/customer/profile_screen.dart';
import 'package:customer_pesenin/ui/views/no_inet_screen.dart';
import 'package:customer_pesenin/ui/views/scanning_screen.dart';
import 'package:customer_pesenin/ui/widgets/order/order_tile.dart';
import 'package:customer_pesenin/ui/widgets/refresh/page_refresh.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerHomeScreen extends StatefulWidget {
  static const routeName = '/home-customer';
  const CustomerHomeScreen({ Key? key }) : super(key: key);

  @override
  _CustomerHomeScreenState createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {

  bool _isLoadingPage = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    Provider.of<ConnectionVM>(context, listen: false).startMonitoring();
    if (mounted) setState(() => _isLoadingPage = true );
    if (mounted) await Provider.of<UserVM>(context, listen: false).fetchCustomer();
    if (mounted) await Provider.of<OrderVM>(context, listen: false).fetchOnGoingCustomerOrders();
    if (mounted) await Provider.of<OrderVM>(context, listen: false).fetchHistoryCustomerOrders();
    if (mounted) setState(() => _isLoadingPage = false );
  }

  Future refreshData() async{
    if (mounted) await Provider.of<UserVM>(context, listen: false).fetchCustomer();
    if (mounted) await Provider.of<OrderVM>(context, listen: false).fetchOnGoingCustomerOrders();
    if (mounted) await Provider.of<OrderVM>(context, listen: false).fetchHistoryCustomerOrders();
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {

    Widget customerInfo() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Consumer<UserVM>(
          builder: (context, userVM, child) => Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hai, ${userVM.customer?.fullname}',
                      style: primaryTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      userVM.customer!.email.toString(),
                      style: secondaryTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, CustomerProfileScreen.routeName);
                },
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/icons/icon_avatar.png'
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: backgroundColor4.withOpacity(0.3),
                        offset: const Offset(0, 1),
                        blurRadius: 5,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget buttonAction() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                    //   boxShadow: [
                    //     BoxShadow(
                    //       offset: const Offset(0, 3),
                    //       spreadRadius: 0,
                    //       blurRadius: 5,
                    //       color: backgroundColor4.withOpacity(0.2),
                    //     ),
                    //   ],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xffc0f2ed),
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
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context, 
                          ScanningScreen.routeName,
                          arguments: ScreenArguments(
                            type: 'order', 
                          ),
                        );
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
                          Icon(
                            Icons.qr_code_scanner_rounded ,
                            color: backgroundColor3,
                            size: 16,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Pesan',
                            style: tertiaryTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: regular,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ), 
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Container(
                    height: 40,
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                    //   boxShadow: [
                    //     BoxShadow(
                    //       offset: const Offset(0, 3),
                    //       spreadRadius: 0,
                    //       blurRadius: 5,
                    //       color: backgroundColor4.withOpacity(0.2),
                    //     ),
                    //   ],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xffffe4b3),
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
                    child: TextButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.confirmation_number_outlined,
                            color: backgroundColor3,
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Reservasi',
                            style: tertiaryTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: regular,
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

    Widget orderOnGoing() {
      return Consumer<OrderVM>(
        builder: (context, orderVM, child) => orderVM.onGoingCustomerOrders.isEmpty ? const SizedBox() : Container(
          margin: EdgeInsets.only(
            top: defaultMargin,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sedang Berlangsung',
                style: primaryTextStyle.copyWith(
                  fontSize: 13,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(height: 5),
              Column(
                children: [
                  for (var i = 0; i < orderVM.onGoingCustomerOrders.length; i++) 
                    OrderTile(order: orderVM.onGoingCustomerOrders[i]),
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget orderHistory() {
      return Consumer<OrderVM>(
        builder: (context, orderVM, child) => orderVM.historyCustomerOrderLimits.isEmpty ? const SizedBox(height: 30) : Container(
          margin: EdgeInsets.only(
            top: defaultMargin,
            bottom: defaultMargin,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Riwayat',
                    style: primaryTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: semiBold,
                    ),
                  ),
                  orderVM.isLimited ? InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, CustomerOrderHistoryScreen.routeName);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Text(
                        'Lihat Semua',
                        style: themeTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                  ) : const SizedBox() ,
                ],
              ),
              const SizedBox(height: 5),
              Column(
                children: [
                  for (var i = 0; i < orderVM.historyCustomerOrderLimits.length; i++) 
                    OrderTile(order: orderVM.historyCustomerOrderLimits[i]),
                ],
              ),
            ],
          ),
        )
      );
    }

    return Consumer<ConnectionVM>(
      builder: (context, connectionVM, _) => connectionVM.isOnline != null && connectionVM.isOnline! ? SafeArea(
        child:  _isLoadingPage ? PageRefresh(bgColor: backgroundColor3, circularColor: primaryColor) : Scaffold(
          backgroundColor: backgroundColor3,
          body: Platform.isIOS ? Container() : RefreshIndicator(
            backgroundColor: backgroundColor3,
            color: primaryColor,
            onRefresh: refreshData,
            child: ListView(
              children: [
                customerInfo(),
                buttonAction(),
                orderOnGoing(),
                orderHistory(),
              ],
            ),
          ),
        ),
      ) : const NoInternetConnectionScreen(),
    );

  }
}