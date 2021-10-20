import 'package:customer_pesenin/pages/home_page.dart';
import 'package:customer_pesenin/pages/orders/product_page.dart';
import 'package:customer_pesenin/pages/splash_page.dart';
import 'package:customer_pesenin/providers/products/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {

  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductCategoryProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => const HomePage(),
          '/product': (context) => const ProductPage(),
        },
      ),
    );
  }
}