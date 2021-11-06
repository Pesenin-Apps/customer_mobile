import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/ui/views/checkin/form_screen.dart';
import 'package:flutter/material.dart';

class ScreenArguments {
  final String? id;
  ScreenArguments({
    this.id,
  });
}

class RouteGenerator {

  static Route<dynamic> generateRoutes(RouteSettings settings) {

    final args = settings.arguments as ScreenArguments;

    switch (settings.name) {
      case CheckInForm.routeName:
        return MaterialPageRoute(
            builder: (context) {
              return CheckInForm(
                table: args.id!,
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