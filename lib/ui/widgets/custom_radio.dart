import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {

  final Widget label;
  final Widget? additionalLabel;
  final EdgeInsets padding;
  final dynamic groupValue;
  final dynamic value;
  final Function onChanged;

  const CustomRadio({
    Key? key,
    required this.label,
    required this.padding,
    required this.groupValue,
    required this.onChanged,
    required this.value,
    this.additionalLabel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Padding(
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.zero,
              height: 20,
              width: 20,
              // margin: EdgeInsets.only(right: 5),
              child: Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: value,
                groupValue: groupValue,
                onChanged: (dynamic newValue) {
                  onChanged(newValue);
                },
                activeColor: primaryColor,
              ),
            ),
            const SizedBox(width: 10),
            label,
            if (additionalLabel != null) const Spacer(),
            if (additionalLabel != null) additionalLabel!,
          ],
        ),
      ),
    );
  }
}
