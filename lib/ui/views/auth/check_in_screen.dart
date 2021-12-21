import 'dart:io';
import 'package:customer_pesenin/core/helpers/locator.dart';
import 'package:customer_pesenin/core/services/navigation_custom.dart';
import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/core/viewmodels/user_vm.dart';
import 'package:customer_pesenin/ui/views/no_inet_screen.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckInScreen extends StatefulWidget {
  static const routeName = '/check-in';
  final String table;

  const CheckInScreen({
    Key? key,
    required this.table,
  }) : super(key: key);

  @override
  _CheckInScreenState createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {

  bool _isLoadingSubmit = false;
  String deviceDetection = '';
  final TextEditingController nameController = TextEditingController(text: '');

  @override
  void initState() {
    Provider.of<ConnectionVM>(context, listen: false).startMonitoring();
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

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void submitForm() async {

    setState(() => _isLoadingSubmit = true);

    final Map<String, dynamic> checkInForm = {
      'table' : widget.table,
      'device_detection': deviceDetection,
      'name' : nameController.text
    };

    bool response = await Provider.of<UserVM>(context, listen: false).checkIn(checkInForm);

    if(response) {
      locator<NavigationCustom>().navigateReplace('/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: dangerColor,
          content: const Text(
            'Gagal Check In!',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    setState(() => _isLoadingSubmit = false);

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
                fontWeight: semiBold,
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
        margin: const EdgeInsets.only(top: 50),
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
        height: 45,
        width: double.infinity,
        margin: EdgeInsets.only(
          top: defaultMargin,
          bottom: defaultMargin,
        ),
        child: TextButton(
          onPressed: submitForm,
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            )
          ),
          child: _isLoadingSubmit ? Container(
            width: 16,
            height: 16,
            margin: EdgeInsets.zero,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(
                backgroundColor3,
              ),
            ),
          ) : Text(
            'Check In',
            style: tertiaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold
            ),
          ),
        ),
      );
    }

    return Consumer<ConnectionVM>(
      builder: (context, connectionVM, _) => connectionVM.isOnline != null && connectionVM.isOnline! ? Scaffold(
        backgroundColor: backgroundColor1,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
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
          ),
        )
      ) : const NoInternetConnectionScreen(),
    );
    
  }
}