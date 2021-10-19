import 'dart:async';
import 'package:flutter/material.dart';
import 'package:customer_pesenin/theme.dart';

class SplashPage extends StatefulWidget {

  const SplashPage({ Key? key }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();

}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    Timer(
      const Duration(
        seconds: 3
      ),
      () => Navigator.pushNamed(context, '/home'),
    );
    super.initState();
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