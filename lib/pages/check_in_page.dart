import 'package:customer_pesenin/theme.dart';
import 'package:flutter/material.dart';

class CheckInPage extends StatelessWidget {

  const CheckInPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Check In',
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold
              ),
            ),
            const SizedBox(height: 3),
            Text(
              'Masukkan Nama untuk Melanjutkan',
              style: secondaryTextStyle,
            )
          ],
        ),
      );
    }

    Widget inputName() {
      return Container(
        margin: const EdgeInsets.only(top: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/icon_user.png',
                      width: 17,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        style: primaryTextStyle,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Masukkan Nama',
                          hintStyle: secondaryTextStyle,
                        ),
                      ),
                    ),
                  ],
                )
              ),
            )
          ],
        ),
      );
    }

    Widget buttonSubmit() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30, bottom: 30),
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/product');
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )
          ),
          child: Text(
            'Lanjut',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              inputName(),
              buttonSubmit(),
            ],
          ),
        ),
      )
    );

  }
}