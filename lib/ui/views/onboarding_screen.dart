import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/ui/views/no_inet_screen.dart';
import 'package:flutter/material.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/ui/views/checkin/scan_table_screen.dart';
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
    return Consumer<ConnectionVM>(
      builder: (context, connectionVM, _) => connectionVM.isOnline != null && connectionVM.isOnline! ? Container(
        width: double.infinity,
        color: backgroundColor3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/qr_code.png',
              width: 80,
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(
                top: 0,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, ScanTable.routeName);
                //  print('test');
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Mulai Memesan',
                  style: primaryTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: medium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ) : const NoInternetConnectionScreen(),
    );
  }
}