import 'package:flutter/material.dart';

class PageRefresh extends StatelessWidget {

  final Color bgColor;
  final Color circularColor;

  const PageRefresh({
    Key? key,
    required this.bgColor,
    required this.circularColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
          child: SizedBox(
            height: 33,
            width: 33,
            child: CircularProgressIndicator(
              color: circularColor,
            ),
          ),
        ),
    );
  }
}