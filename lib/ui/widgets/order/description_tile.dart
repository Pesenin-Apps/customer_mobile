import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:flutter/material.dart';

class DescriptionTile extends StatelessWidget {

  final String? title;
  final String? description;

  const DescriptionTile({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title!,
          style: secondaryTextStyle.copyWith(
            fontSize: 12,
          ),
        ),
        Text(
          description!,
          style: primaryTextStyle.copyWith(
            fontWeight: medium,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}