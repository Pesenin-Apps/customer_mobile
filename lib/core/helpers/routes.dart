import 'package:customer_pesenin/ui/views/home_screen.dart';
import 'package:customer_pesenin/ui/views/orders/cart_screen.dart';
import 'package:customer_pesenin/ui/views/orders/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:customer_pesenin/ui/views/onboarding_screen.dart';
import 'package:customer_pesenin/ui/views/checkin/scan_table_screen.dart';

final Map<String, Widget Function(BuildContext)> routesCustom = {
  OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
  ScanTable.routeName: (context) => const ScanTable(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  Cart.routeName: (context) => const Cart(),
  OrderScreen.routeName: (context) => const OrderScreen(),
};