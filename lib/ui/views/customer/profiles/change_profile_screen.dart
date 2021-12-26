import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/core/viewmodels/user_vm.dart';
import 'package:customer_pesenin/ui/views/no_inet_screen.dart';
import 'package:customer_pesenin/ui/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeProfileScreen extends StatefulWidget {
  static const routeName = '/change-profile';
  const ChangeProfileScreen({ Key? key }) : super(key: key);

  @override
  _ChangeProfileScreenState createState() => _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends State<ChangeProfileScreen> {

  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController _fullname = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();

  bool _isLoadingPage = false;
  bool _isLoadingSubmited = false;

  @override
  void initState() {
    Provider.of<ConnectionVM>(context, listen: false).startMonitoring();
    getData();
    _fullname = TextEditingController(
      text: Provider.of<UserVM>(context, listen: false).customerDetail.fullname,
    );
    _fullname.addListener(onChangeControl);
    _phoneNumber = TextEditingController(
      text: Provider.of<UserVM>(context, listen: false).customerDetail.phone,
    );
    _phoneNumber.addListener(onChangeControl);
    super.initState();
  }
  
  void getData() async {
    setState(() => _isLoadingPage = true );
    await Provider.of<UserVM>(context, listen: false).fetchCustomer();
    setState(() => _isLoadingPage = false );
  }

  void onChangeControl() {
    setState(() { });
  }

  @override
  void dispose() {
    _fullname.removeListener(onChangeControl);
    _fullname.dispose();
    _phoneNumber.removeListener(onChangeControl);
    _phoneNumber.dispose();
    super.dispose();
  }

   void _onSubmit() async {
    setState(() => _isLoadingSubmited = true );
    final Map<String, dynamic> changedProfileForm = {
      'fullname': _fullname.text,
      'phone': _phoneNumber.text,
    };
    bool response = await Provider.of<UserVM>(context, listen: false).changeProfileCustomer(changedProfileForm);
    if (response) {
      await Provider.of<UserVM>(context, listen: false).fetchCustomer();
      setState(() { });
      FocusManager.instance.primaryFocus?.unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: primaryColor,
          content: const Text(
            'Berhasil, Profil telah Diperbarui!',
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
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Form(
          key: formGlobalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              Text(
                'Nama',
                style: primaryTextStyle,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hintText: 'Masukkan Nama Anda', 
                inputName: 'Nama', 
                controller: _fullname,
                onSubmitField: () {
                  print('');
                }, 
                onChange: (value) {
                  print('');
                },
                isBorder: true,
              ),
              const SizedBox(height: 10),
              // Phone
              Text(
                'Nomor Handphone',
                style: primaryTextStyle,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hintText: 'Masukkan Nomor Handphone Anda', 
                inputName: 'Nomor Handphone', 
                controller: _phoneNumber,
                onSubmitField: () {
                  print('');
                }, 
                onChange: (value) {
                  print('');
                },
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
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(
                top: defaultMargin
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/icons/icon_avatar.png'
                  ) 
                ),
                boxShadow: [
                  BoxShadow(
                    color: backgroundColor4.withOpacity(0.3),
                    offset: const Offset(0, 1),
                    blurRadius: 5,
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              Provider.of<UserVM>(context, listen: false).customerDetail.email.toString(),
              style: primaryTextStyle.copyWith(
                fontSize: 15,
              ),
            ),
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
            title: const Text('Ubah Profil'),
          ),
          body: _isLoadingPage ? Center(
            child: SizedBox(
              height: 33,
              width: 33,
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          ) : SingleChildScrollView(
            child: content()
          ),
        ),
      ) : const NoInternetConnectionScreen(),
    );
    
  }
  
}