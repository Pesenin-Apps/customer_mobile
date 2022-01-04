import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/core/viewmodels/user_vm.dart';
import 'package:customer_pesenin/ui/views/no_inet_screen.dart';
import 'package:customer_pesenin/ui/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = '/change-password';
  const ChangePasswordScreen({ Key? key }) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final formGlobalKey = GlobalKey<FormState>();
  final TextEditingController _passwordOld = TextEditingController();
  final TextEditingController _passwordNew = TextEditingController();

  bool _isLoadingSubmited = false;

  @override
  void initState() {
    Provider.of<ConnectionVM>(context, listen: false).startMonitoring();
    _passwordOld.addListener(onChangeControl);
    _passwordNew.addListener(onChangeControl);
    super.initState();
  }

  void onChangeControl() {
    setState(() { });
  }

  @override
  void dispose() {
    _passwordOld.removeListener(onChangeControl);
    _passwordOld.dispose();
    _passwordNew.removeListener(onChangeControl);
    _passwordNew.dispose();
    super.dispose();
  }

  void _onSubmit() async {
    setState(() => _isLoadingSubmited = true );
    final Map<String, dynamic> changedPasswordForm = {
      'oldpassword': _passwordOld.text,
      'newpassword': _passwordNew.text,
    };
    bool response = await Provider.of<UserVM>(context, listen: false).changePasswordCustomer(changedPasswordForm);
    if (response) {
      FocusManager.instance.primaryFocus?.unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: primaryColor,
          content: const Text(
            'Berhasil, Password telah Diperbarui!',
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
    setState(() => _isLoadingSubmited = false );
  }

  @override
  Widget build(BuildContext context) {

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
              // Password Old
              Text(
                'Password Lama',
                style: primaryTextStyle,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hintText: 'Masukkan Password Lama', 
                inputName: 'Password Lama', 
                controller: _passwordOld, 
                onSubmitField: () {
                  print('');
                }, 
                onChange: (value) {
                  print('');
                },
                obscureText: true,
                isBorder: true,
              ),
              const SizedBox(height: 20),
              // Password New
              Text(
                'Password Baru',
                style: primaryTextStyle,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hintText: 'Masukkan Password Baru', 
                inputName: 'Password Baru', 
                controller: _passwordNew, 
                onSubmitField: () {
                  print('');
                }, 
                onChange: (value) {
                  print('');
                },
                obscureText: true,
                isBorder: true,
              ),
            ],
          ),
        ),
      );
    }

    Widget buttonSubmit() {
      return Container(
        height: 40,
        width: double.infinity,
        margin: EdgeInsets.only(
          top: defaultMargin,
          bottom: defaultMargin,
        ),
        child: TextButton(
          onPressed: () {
            if (formGlobalKey.currentState!.validate()) {
              formGlobalKey.currentState!.save();
              _onSubmit();
            }
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )
          ),
          child: _isLoadingSubmited ? Container(
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
            'Simpan',
            style: tertiaryTextStyle.copyWith(
              fontSize: 14,
              fontWeight: semiBold
            ),
          ),
        ),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            formInput(),
            buttonSubmit(),
          ],
        ),
      );
    }

    return Consumer<ConnectionVM>(
      builder: (context, connectionVM, _) => connectionVM.isOnline != null && connectionVM.isOnline! ? SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor1,
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 0,
            title: const Text('Ganti Password'),
          ),
          body: SingleChildScrollView(
            child: content()
          ),
        ),
      ) : const NoInternetConnectionScreen(),
    );

  }

}