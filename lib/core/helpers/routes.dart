import 'package:customer_pesenin/ui/views/auth/sign_in_screen.dart';
import 'package:customer_pesenin/ui/views/auth/sign_up_screen.dart';
import 'package:customer_pesenin/ui/views/customer/home_screen.dart';
import 'package:customer_pesenin/ui/views/customer/orders/histories_screen.dart';
import 'package:customer_pesenin/ui/views/customer/profile_screen.dart';
import 'package:customer_pesenin/ui/views/customer/profiles/change_password_screen.dart';
import 'package:customer_pesenin/ui/views/customer/profiles/change_profile_screen.dart';
import 'package:customer_pesenin/ui/views/guest/home_screen.dart';
import 'package:customer_pesenin/ui/views/guest/orders/cart_screen.dart';
import 'package:customer_pesenin/ui/views/guest/orders/detail_screen.dart';
import 'package:customer_pesenin/ui/views/guest/orders/updated_screen.dart';
import 'package:flutter/material.dart';
import 'package:customer_pesenin/ui/views/onboarding_screen.dart';

final Map<String, Widget Function(BuildContext)> routesCustom = {
  OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  CustomerHomeScreen.routeName: (context) => const CustomerHomeScreen(),
  CustomerProfileScreen.routeName: (context) => const CustomerProfileScreen(),
  ChangeProfileScreen.routeName: (context) => const ChangeProfileScreen(),
  ChangePasswordScreen.routeName: (context) => const ChangePasswordScreen(),
  CustomerOrderHistoryScreen.routeName: (context) => const CustomerOrderHistoryScreen(),
  GuestHomeScreen.routeName: (context) => const GuestHomeScreen(),
  GuestCartScreen.routeName: (context) => const GuestCartScreen(),
  GuestOrderDetailScreen.routeName: (context) => const GuestOrderDetailScreen(),
  GuestOrderUpdateScreen.routeName: (context) => const GuestOrderUpdateScreen(),
};