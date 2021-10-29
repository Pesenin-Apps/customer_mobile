import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/product_vm.dart';
import 'package:customer_pesenin/ui/views/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    onBoarding();
    // Timer(
    //   const Duration(
    //     seconds: 4
    //   ),
    //   () => Navigator.pushReplacementNamed(context, OnBoardingScreen.routeName),
    // );
    super.initState();
  }

  onBoarding() async {
    await Provider.of<ProductVM>(context, listen: false).fetchProducts('');
    Navigator.pushReplacementNamed(context, OnBoardingScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 128,
              height: 128,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/logo_no_text.png'
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'P E L A N G G A N   P E S E N I N', 
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold
              ),
            ),
          ],
        )
      ),
    );
  }
  
}