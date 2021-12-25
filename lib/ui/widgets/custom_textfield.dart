import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {

  final String hintText;
  final bool obscureText;
  final String inputName;
  final String? helperText;
  final TextEditingController controller;
  final TextInputAction actionKeyboard;
  final FocusNode? focusNode;
  final TextInputType actionType;
  final Function onSubmitField;
  final bool isValidate;
  final Color fillColor;
  final bool isBorder;
  final EdgeInsets contentPadding;
  final Widget? prefixIcon;
  final Function onChange;
  final List<TextInputFormatter>? inputFormatter;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.inputName,
    required this.controller,
    required this.onSubmitField,
    required this.onChange,
    this.focusNode,
    this.helperText,
    this.obscureText = false,
    this.actionKeyboard = TextInputAction.next,
    this.actionType = TextInputType.text,
    this.isValidate = true,
    this.fillColor = Colors.transparent,
    this.isBorder = false,
    this.prefixIcon,
    this.inputFormatter,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatter,
      obscureText: obscureText,
      controller: controller,
      focusNode: focusNode,
      textInputAction: actionKeyboard,
      keyboardType: actionType,
      autovalidateMode: isValidate ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Anda belum mengisi $inputName';
        }
        return null;
      },
      onChanged: (value) {
        onChange(value);
      },
      onFieldSubmitted: (value) {
        // ignore: void_checks
        return onSubmitField();
      },
      style: primaryTextStyle,
      decoration: InputDecoration(
        isDense: true,
        helperText: helperText,
        helperMaxLines: 2,
        helperStyle: secondaryTextStyle,
        hintText: hintText,
        hintStyle: secondaryTextStyle,
        contentPadding: contentPadding,
        fillColor: fillColor,
        filled: true,
        prefixIcon: prefixIcon,
        border: isBorder ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: subtitleTextColor,
          ),
        ) : UnderlineInputBorder(
          borderSide: BorderSide(
            color: subtitleTextColor,
          ),
        ),
        errorBorder: isBorder ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: errorColor,
          ),
        ) : UnderlineInputBorder(
          borderSide: BorderSide(
            color: errorColor,
          ),
        ),
        enabledBorder: isBorder ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: tertiaryColor,
          ),
        ) : UnderlineInputBorder(
          borderSide: BorderSide(
            color: tertiaryColor,
          ),
        ),
        focusedBorder: isBorder ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: primaryTextColor,
          ),
        ) : UnderlineInputBorder(
          borderSide: BorderSide(
            color: primaryTextColor,
          ),
        ),
      ),
    );
  }
}