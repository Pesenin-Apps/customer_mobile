import 'package:customer_pesenin/core/services/navigation_custom.dart';
import 'package:customer_pesenin/core/viewmodels/customer_vm.dart';
import 'package:customer_pesenin/ui/views/home_screen.dart';
import 'package:customer_pesenin/ui/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:customer_pesenin/core/helpers/providers.dart';
import 'package:customer_pesenin/core/helpers/routes.dart';
import 'package:customer_pesenin/core/helpers/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {

  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<CustomerVM>(
        builder: (context, customerVM, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: customerVM.isAuth ? const HomeScreen() : FutureBuilder(
            future: customerVM.tryAutoCheckIn(),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting ? const HomeScreen() : const SplashScreen();
            },
          ),
          navigatorKey: locator<NavigationCustom>().navigatorKey,
          routes: routesCustom,
        )
      )
    );
  }
}