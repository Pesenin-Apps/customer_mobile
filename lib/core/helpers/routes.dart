// import 'package:customer_pesenin/ui/views/checkin/form.dart';
import 'package:customer_pesenin/ui/views/home_screen.dart';
import 'package:customer_pesenin/ui/views/orders/cart.dart';
import 'package:flutter/material.dart';
// import 'package:customer_pesenin/ui/views/splash_screen.dart';
import 'package:customer_pesenin/ui/views/onboarding_screen.dart';
import 'package:customer_pesenin/ui/views/checkin/scan_table.dart';

final Map<String, Widget Function(BuildContext)> routesCustom = {
  // SplashScreen.routeName: (context) => const SplashScreen(),
  OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
  ScanTable.routeName: (context) => const ScanTable(),
  // CheckInForm.routeName: (context) => const CheckInForm(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  Cart.routeName: (context) => const Cart(),
};