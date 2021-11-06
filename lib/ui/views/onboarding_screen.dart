import 'package:flutter/material.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/ui/views/checkin/scan_table_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  static const routeName = '/onboarding';
  const OnBoardingScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}