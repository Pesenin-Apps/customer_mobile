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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: routesCustom,
      ),
    );
  }
}