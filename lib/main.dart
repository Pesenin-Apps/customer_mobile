import 'package:customer_pesenin/locator.dart';
import 'package:customer_pesenin/pages/check_in_page.dart';
import 'package:customer_pesenin/pages/home_page.dart';
import 'package:customer_pesenin/pages/orders/product_page.dart';
import 'package:customer_pesenin/pages/scanner_page.dart';
import 'package:customer_pesenin/pages/splash_page.dart';
import 'package:customer_pesenin/providers/product_provider.dart';
import 'package:customer_pesenin/providers/products/category_provider.dart';
import 'package:customer_pesenin/viewmodels/product_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductCategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<ProductVM>(create: (context) => ProductVM()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => const HomePage(),
          '/scanner': (context) => const ScannerPage(),
          '/check-in': (context) => const CheckInPage(),
          '/product': (context) => const ProductPage(),
        },
      ),
    );
  }
}