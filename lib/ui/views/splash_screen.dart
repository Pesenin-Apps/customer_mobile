import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/ui/views/no_inet_screen.dart';
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
    Provider.of<ConnectionVM>(context, listen: false).startMonitoring();
    onBoarding();
    super.initState();
  }

  onBoarding() async {
    await Provider.of<ProductVM>(context, listen: false).fetchProducts('');
    if (mounted) Navigator.pushReplacementNamed(context, OnBoardingScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectionVM>(
      builder: (context, connectionVM, _) => connectionVM.isOnline != null && connectionVM.isOnline! ? Scaffold(
        backgroundColor: backgroundColor3,
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
              const SizedBox(height: 20),
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
      ) : const NoInternetConnectionScreen(),
    );
  }
  
}