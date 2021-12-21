import 'package:customer_pesenin/core/helpers/locator.dart';
import 'package:customer_pesenin/core/services/navigation_custom.dart';
import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/core/viewmodels/user_vm.dart';
import 'package:customer_pesenin/ui/views/no_inet_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/sign-in';
  const SignInScreen({ Key? key }) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  bool _isLoadingSubmit = false;

  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController = TextEditingController(text: '');

  @override
  void initState() {
    Provider.of<ConnectionVM>(context, listen: false).startMonitoring();
    super.initState();
  }

  void onSubmit() async {

    setState(() => _isLoadingSubmit = true );

    final Map<String, dynamic> signInForm = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    bool response = await Provider.of<UserVM>(context, listen: false).signIn(signInForm);

    if(response) {
      locator<NavigationCustom>().navigateReplace('/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: dangerColor,
          content: const Text(
            'Gagal, Periksa kembali Username dan Password Anda!',
          ),
        ),
      );
    }
    
    setState(() => _isLoadingSubmit = false );

  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
              'Sign In',
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              'Masukkan Email dan Password Anda',
              style: secondaryTextStyle,
            )
          ],
        ),
      );
    }

    Widget inputEmail() {
      return Container(
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email',
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
                        controller: emailController,
                        style: primaryTextStyle,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Masukkan Email',
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

    Widget inputPassword() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
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
                        controller: passwordController,
                        style: primaryTextStyle,
                        obscureText: true,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Masukkan Password',
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
          onPressed: onSubmit,
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
            'Masuk',
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
              'Belum mempunyai akun? ',
              style: subtitleTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, '/sign-up');
                print('Daftar Akun Baru Boss Ku!');
              },
              child: Text(
                'Sign Up',
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
      builder: (context, connectionVM, _) => connectionVM.isOnline != null && connectionVM.isOnline! ? Scaffold(
        backgroundColor: backgroundColor1,
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
                  inputEmail(),
                  inputPassword(),
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