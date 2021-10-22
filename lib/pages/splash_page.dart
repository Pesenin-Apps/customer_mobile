import 'dart:async';
import 'package:customer_pesenin/models/product_model.dart';
import 'package:customer_pesenin/providers/product_provider.dart';
import 'package:customer_pesenin/providers/products/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:customer_pesenin/theme.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {

  const SplashPage({ Key? key }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();

}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    getInit();
    // Timer(
    //   const Duration(
    //     seconds: 3
    //   ),
    //   () => Navigator.pushNamed(context, '/home'),
    // );
    super.initState();
  }

  getInit() async {
    await Provider.of<ProductCategoryProvider>(context, listen: false).getProductCategories();
    await Provider.of<ProductProvider>(context, listen: false).getProducts();
    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {

    Widget logo() {
      return Container(
        width: 128,
        height: 128,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/logo_no_text.png'
            ),
          ),
        ),
      );
    }

    Widget textTitle() {
      return Text(
        'P E L A N G G A N   P E S E N I N', 
        style: primaryTextStyle.copyWith(
          fontSize: 16,
          fontWeight: bold
        ),
      );
    }

    Widget content() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logo(),
            const SizedBox(height: 12),
            textTitle(),
          ],
        )
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: content(),
    );

  }
  
}