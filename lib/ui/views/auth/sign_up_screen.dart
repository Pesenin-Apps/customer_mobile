import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/core/viewmodels/user_vm.dart';
import 'package:customer_pesenin/ui/views/no_inet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign-out';
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool _isLoadingSubmit = false;

  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController _fullname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void initState() {
    Provider.of<ConnectionVM>(context, listen: false).startMonitoring();
    _fullname.addListener(onChangeControl);
    _email.addListener(onChangeControl);
    _phone.addListener(onChangeControl);
    _password.addListener(onChangeControl);
    super.initState();
  }

  void onChangeControl() {
    setState(() { });
  }

  @override
  void dispose() {
    _fullname.removeListener(onChangeControl);
    _fullname.dispose();
    _email.removeListener(onChangeControl);
    _email.dispose();
    _phone.removeListener(onChangeControl);
    _phone.dispose();
    _password.removeListener(onChangeControl);
    _password.dispose();
    super.dispose();
  }

  void onSubmit() async {
    setState(() => _isLoadingSubmit = true );

    final Map<String, dynamic> signUpForm = {
      'fullname': _fullname.text,
      'email': _email.text,
      'phone': _phone.text,
      'password': _password.text,
      'role': 'customer',
    };

    bool response = await Provider.of<UserVM>(context, listen: false).signUp(signUpForm);

    if (response) {
      FocusManager.instance.primaryFocus?.unfocus();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: primaryColor,
          content: const Text(
            'Berhasil, Akun telah Terdaftar!',
          ),
        ),
      );
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: errorColor,
          content: const Text(
            'Gagal, terjadi kesalahan!',
          ),
        ),
      );
    }

    setState(() => _isLoadingSubmit = false );
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
              'Sign Up',
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              'Lengkapi Data Diri Anda',
              style: secondaryTextStyle,
            )
          ],
        ),
      );
    }

    Widget formInput() {
      return Container(
        margin: const EdgeInsets.only(
          top: 30,
        ),
        child: Form(
          key: formGlobalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fullname
              Text(
                'Nama',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium
                ),
              ),
              const SizedBox(height: 10),
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
                          controller: _fullname,
                          decoration: InputDecoration.collapsed(
                            hintText: 'Masukkan Nama',
                            hintStyle: secondaryTextStyle,
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ],
                  )
                ),
              ),
              const SizedBox(height: 20),
              // Email
              Text(
                'Email',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium
                ),
              ),
              const SizedBox(height: 10),
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
                        'assets/icons/icon_email.png',
                        width: 17,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Masukkan Email Anda';
                            }
                            return null;
                          },
                          controller: _email,
                          style: primaryTextStyle,
                          decoration: InputDecoration.collapsed(
                            hintText: 'Masukkan Email',
                            hintStyle: secondaryTextStyle,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ],
                  )
                ),
              ),
              const SizedBox(height: 20),
              // Phone
              Text(
                'Nomor Handphone',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium
                ),
              ),
              const SizedBox(height: 10),
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
                      Icon(
                        Icons.local_phone_rounded ,
                        color: primaryColor,
                        size: 17,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Masukkan Nomor Handphone Anda';
                            }
                            return null;
                          },
                          controller: _phone,
                          style: primaryTextStyle,
                          decoration: InputDecoration.collapsed(
                            hintText: 'Masukkan Nomor Handphone',
                            hintStyle: secondaryTextStyle,
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(14),
                            // FilteringTextInputFormatter.deny(RegExp(r'^0+'))
                          ],
                        ),
                      ),
                    ],
                  )
                ),
              ),
              const SizedBox(height: 20),
              // Password
              Text(
              'Password',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium
                ),
              ),
              const SizedBox(height: 10),
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
                        'assets/icons/icon_password.png',
                        width: 17,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Masukkan Password Anda';
                            }
                            return null;
                          },
                          controller: _password,
                          style: primaryTextStyle,
                          obscureText: true,
                          decoration: InputDecoration.collapsed(
                            hintText: 'Masukkan Password',
                            hintStyle: secondaryTextStyle,
                          ),
                          textInputAction: TextInputAction.go,
                        ),
                      ),
                    ],
                  )
                ),
              )
            ],
          ),
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
          onPressed: () {
            if (formGlobalKey.currentState!.validate()) {
              formGlobalKey.currentState!.save();
              onSubmit();
            }
          },
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
            'Daftar',
            style: tertiaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium
            ),
          ),
        ),
      );
    }

    Widget footer() {
      return Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sudah mempunyai akun? ',
              style: subtitleTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                'Sign In',
                style: themeTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: medium,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Consumer<ConnectionVM>(
      builder: (context, connectionVM, _) => connectionVM.isOnline != null && connectionVM.isOnline! ? SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor3,
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header(),
                  formInput(),
                  buttonSubmit(),
                  footer(),
                ],
              ),
            ),
          ),
        ),
      ) : const NoInternetConnectionScreen(),
    );
    
  }

}