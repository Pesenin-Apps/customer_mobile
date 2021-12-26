import 'package:customer_pesenin/core/helpers/routes_generator.dart';
import 'package:customer_pesenin/core/services/navigation_custom.dart';
import 'package:customer_pesenin/core/viewmodels/user_vm.dart';
import 'package:customer_pesenin/ui/views/customer/home_screen.dart';
import 'package:customer_pesenin/ui/views/home_screen.dart';
import 'package:customer_pesenin/ui/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:customer_pesenin/core/helpers/providers.dart';
import 'package:customer_pesenin/core/helpers/routes.dart';
import 'package:customer_pesenin/core/helpers/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  await setupLocator();
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {

  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<UserVM>(
        builder: (context, userVM, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: userVM.isAuth ? ( userVM.isGuest ? const HomeScreen() : const CustomerHomeScreen() ) : FutureBuilder(
            future: userVM.tryAutoCheckInAndSignIn(),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting ? ( userVM.isGuest ? const HomeScreen() : const CustomerHomeScreen() ) : const SplashScreen();
            },
          ),
          navigatorKey: locator<NavigationCustom>().navigatorKey,
          routes: routesCustom,
          onGenerateRoute: RouteGenerator.generateRoutes,
        )
      )
    );
  }
}