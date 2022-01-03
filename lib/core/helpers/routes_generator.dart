import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/ui/views/auth/check_in_screen.dart';
import 'package:customer_pesenin/ui/views/customer/orders/cart_screen.dart';
import 'package:customer_pesenin/ui/views/customer/orders/detail_screen.dart';
import 'package:customer_pesenin/ui/views/customer/orders/updated_screen.dart';
import 'package:customer_pesenin/ui/views/customer/orders/choose_product_screen.dart';
import 'package:customer_pesenin/ui/views/customer/reservations/cart_screen.dart';
import 'package:customer_pesenin/ui/views/customer/reservations/choose_product_screen.dart';
import 'package:customer_pesenin/ui/views/scanning_screen.dart';
import 'package:flutter/material.dart';

class ScreenArguments {
  final String? id;
  final String? type;
  final String? table;
  ScreenArguments({
    this.id,
    this.type,
    this.table,
  });
}

class RouteGenerator {

  static Route<dynamic> generateRoutes(RouteSettings settings) {

    final args = settings.arguments as ScreenArguments;

    switch (settings.name) {
      case CheckInScreen.routeName:
        return MaterialPageRoute(
            builder: (context) {
              return CheckInScreen(
                table: args.id!,
              );
            },
          );
      case ScanningScreen.routeName:
        return MaterialPageRoute(
            builder: (context) {
              return ScanningScreen(
                type: args.type!,
              );
            },
          );
      case CustomerOrderDetailScreen.routeName:
        return MaterialPageRoute(
            builder: (context) {
              return CustomerOrderDetailScreen(
                id: args.id,
              );
            },
          );
      case CustomerOrderUpdateScreen.routeName:
        return MaterialPageRoute(
            builder: (context) {
              return CustomerOrderUpdateScreen(
                id: args.id,
              );
            },
          );
      case ChooseProductScreen.routeName:
        return MaterialPageRoute(
            builder: (context) {
              return ChooseProductScreen(
                table: args.table,
                type: args.type,
              );
            },
          );
      case CustomerCartScreen.routeName:
        return MaterialPageRoute(
            builder: (context) {
              return CustomerCartScreen(
                table: args.table,
                type: args.type,
              );
            },
          );
      case ReservationChooseProductScreen.routeName:
        return MaterialPageRoute(
            builder: (context) {
              return ReservationChooseProductScreen(
                type: args.type,
              );
            },
          );
      case CustomerReservationCartScreen.routeName:
        return MaterialPageRoute(
            builder: (context) {
              return CustomerReservationCartScreen(
                type: args.type,
              );
            },
          );
      default:
        return _onErrorRoute();
    }

  }

  static Route<dynamic> _onErrorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return const ErrorRoute();
      } 
    );
  }

}

class ErrorRoute extends StatelessWidget {
  const ErrorRoute({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: AppBar(
        backgroundColor: transparentColor,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'An error occurred on ROUTE',
          style: primaryTextStyle,
        ),
      ),
    );
  }
}