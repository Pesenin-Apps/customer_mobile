import 'package:customer_pesenin/core/helpers/routes_generator.dart';
import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/ui/views/auth/sign_in_screen.dart';
import 'package:customer_pesenin/ui/views/no_inet_screen.dart';
import 'package:customer_pesenin/ui/views/scanning_screen.dart';
import 'package:flutter/material.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatefulWidget {
  static const routeName = '/onboarding';
  const OnBoardingScreen({ Key? key }) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    Provider.of<ConnectionVM>(context, listen: false).startMonitoring();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Widget header() {
      return Container(
        margin: const EdgeInsets.only(
          top: 60,
        ),
        child: Center(
          child: Image.asset(
            'assets/images/onboarding.png',
            width: 223,
            height: 320,
          ),
        ),
      );
    }

    Widget title() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pesenin App',
              style: primaryTextStyle.copyWith(
                fontSize: 28,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Pesenin merupakan sebuah aplikasi pemesanan makanan pada restoran favorit anda secara virtual dengan quick response (qr) code.',
              style: primaryTextStyle.copyWith(
                fontSize: 10,
                fontWeight: regular,
              ),
            ),
          ],
        ),
      );
    }

    Widget buttonAction() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin/2,
          bottom: defaultMargin,
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    margin: EdgeInsets.zero,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context, 
                          ScanningScreen.routeName,
                          arguments: ScreenArguments(
                            type: 'checkin', 
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: backgroundColor2,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Check In',
                            style: primaryTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ), 
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Container(
                    height: 45,
                    margin: EdgeInsets.zero,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Sign In',
                        style: tertiaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                  ), 
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Consumer<ConnectionVM>(
      builder: (context, connectionVM, _) => connectionVM.isOnline != null && connectionVM.isOnline! ? SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor3,
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header(),
                  title(),
                  buttonAction(),
                ],
              ),
            ),
          ),
        ),
      ) : const NoInternetConnectionScreen(),
    );
  }
}