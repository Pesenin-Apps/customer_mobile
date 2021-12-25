import 'package:customer_pesenin/ui/views/auth/sign_in_screen.dart';
import 'package:customer_pesenin/ui/views/customer/home_screen.dart';
import 'package:customer_pesenin/ui/views/customer/orders/histories_screen.dart';
import 'package:customer_pesenin/ui/views/customer/profile_screen.dart';
import 'package:customer_pesenin/ui/views/customer/profiles/change_password_screen.dart';
import 'package:customer_pesenin/ui/views/customer/profiles/change_profile_screen.dart';
import 'package:customer_pesenin/ui/views/home_screen.dart';
import 'package:customer_pesenin/ui/views/orders/cart_screen.dart';
import 'package:customer_pesenin/ui/views/orders/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:customer_pesenin/ui/views/onboarding_screen.dart';

final Map<String, Widget Function(BuildContext)> routesCustom = {
  OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  CustomerHomeScreen.routeName: (context) => const CustomerHomeScreen(),
  CustomerProfileScreen.routeName: (context) => const CustomerProfileScreen(),
  ChangeProfileScreen.routeName: (context) => const ChangeProfileScreen(),
  ChangePasswordScreen.routeName: (context) => const ChangePasswordScreen(),
  CustomerOrderHistoryScreen.routeName: (context) => const CustomerOrderHistoryScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  Cart.routeName: (context) => const Cart(),
  OrderScreen.routeName: (context) => const OrderScreen(),
};