import 'package:customer_pesenin/core/helpers/locator.dart';
import 'package:customer_pesenin/core/services/navigation_custom.dart';
import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/customer_vm.dart';
import 'package:customer_pesenin/ui/widgets/components/loading_button.dart';
import 'package:device_info/device_info.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckInForm extends StatefulWidget {
  static const routeName = '/checkin-form';
  final String table;

  const CheckInForm({
    Key? key,
    required this.table
  }) : super(key: key);

  @override
  _CheckInFormState createState() => _CheckInFormState();
}

class _CheckInFormState extends State<CheckInForm> {

  String deviceDetection = '';
  final TextEditingController nameController = TextEditingController(text: '');
  bool _isLoading = false;

  @override
  void initState() {
    getDeviceInfo();
    super.initState();
  }  

  getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo build = await deviceInfo.androidInfo;
      setState(() {
        deviceDetection = build.model + ' ' +  build.androidId;
      });
    }
  }

  void submitForm() async {
    
    setState(() {
      _isLoading = true;
    });

    final Map<String, dynamic> checkInForm = {
      'table' : widget.table,
      'device_detection': deviceDetection,
      'name' : nameController.text
    };

    bool response = await Provider.of<CustomerVM>(context, listen: false).checkIn(checkInForm);

    if(response) {
      locator<NavigationCustom>().navigateReplace('/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: alertColor,
          content: const Text(
            'Gagal Check In!',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });

  }

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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Masukkan Nama Anda';
                          }
                          return null;
                        },
                        style: primaryTextStyle,
                        controller: nameController,
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
          onPressed: submitForm,
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )
          ),
          child: Text(
            'Check In',
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
              _isLoading ? const LoadingButton() : buttonSubmit(),
            ],
          ),
        ),
      )
    );

  }
}