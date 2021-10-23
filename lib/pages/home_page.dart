import 'package:customer_pesenin/theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget iconQR() {
      return Image.asset(
        'assets/images/qr_code.png',
        width: 80,
      );
    }

    Widget scanningButton() {
      return Container(
        margin: const EdgeInsets.only(
          top: 0,
        ),
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/scanner');
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
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        color: backgroundColor3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconQR(),
            const SizedBox(height: 20),
            scanningButton(),
          ],
        ),
      );
    }

    return content();

  }

}

