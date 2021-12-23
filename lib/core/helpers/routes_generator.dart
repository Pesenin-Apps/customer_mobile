import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/ui/views/auth/check_in_screen.dart';
import 'package:customer_pesenin/ui/views/customer/orders/detail_screen.dart';
import 'package:customer_pesenin/ui/views/scanning_screen.dart';
import 'package:flutter/material.dart';

class ScreenArguments {
  final String? id;
  final String? type;
  ScreenArguments({
    this.id,
    this.type,
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
      backgroundColor: backgroundColor1,
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