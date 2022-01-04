import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/core/viewmodels/user_vm.dart';
import 'package:customer_pesenin/ui/views/customer/profiles/change_password_screen.dart';
import 'package:customer_pesenin/ui/views/customer/profiles/change_profile_screen.dart';
import 'package:customer_pesenin/ui/views/onboarding_screen.dart';
import 'package:customer_pesenin/ui/widgets/menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerProfileScreen extends StatefulWidget {
  static const routeName = '/profile-customer';
  const CustomerProfileScreen({ Key? key }) : super(key: key);

  @override
  _CustomerProfileScreenState createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {

  bool _isLoadingSignOut = false;

  @override
  void initState() {
    Provider.of<ConnectionVM>(context, listen: false).startMonitoring();
    super.initState();
  }

  void onSubmitSignOut() {
    if (mounted) setState(() => _isLoadingSignOut = true );
    Future.delayed(const Duration(seconds: 2), () async {
      final response = await Provider.of<UserVM>(context, listen: false).signOut();
      if (response) {
        Navigator.pushNamedAndRemoveUntil(context, OnBoardingScreen.routeName, (route) => false);
      } else {
        if (mounted) setState(() => _isLoadingSignOut = false );
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    Future<void> showConfirmDialogSignOut() async {
      return showDialog(
        context: context, 
        builder: (BuildContext context) => Container(
          margin: EdgeInsets.zero,
          width: MediaQuery.of(context).size.width - (2 * defaultMargin),
          child: AlertDialog(
            backgroundColor: backgroundColor3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: primaryTextColor,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.error_outline_rounded,
                    color: errorColor,
                    size: 100,
                  ),
                  const SizedBox( height: 12),
                  Text(
                    'Anda ingin Sign Out?',
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Anda harus Sign In',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    'jika ingin melakukan',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    'pemesanan kembali',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 150,
                    height: 40,
                    margin: EdgeInsets.zero,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onSubmitSignOut();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: errorColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Ya, Sign Out',
                        style: tertiaryTextStyle.copyWith(
                          fontSize: 13,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      );
    }

    Widget listMenus() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin/2,
          bottom: defaultMargin,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              MenuTile(title: 'Ubah Profil', routeName: ChangeProfileScreen.routeName),
              MenuTile(title: 'Ganti Password', routeName: ChangePasswordScreen.routeName),
            ],
          ),
        ),
      );
    }

    Widget customNavigationBar() {
      return Container(
        height: 75,
        decoration: BoxDecoration(
          color: backgroundColor3,
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              height: 35,
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin/3,
              ),
              child: TextButton(
                onPressed: () {
                  // onSubmitOrder(userVM.tableDetail.id.toString(), cartVM);
                  showConfirmDialogSignOut();
                },
                style: TextButton.styleFrom(
                  backgroundColor: errorColor,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoadingSignOut ? Container(
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
                  'Keluar',
                  style: tertiaryTextStyle.copyWith(
                    fontSize: 15,
                    fontWeight: semiBold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor3,
        appBar: AppBar(
          backgroundColor: primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          centerTitle: true,
          title: const Text('Profil'),
        ),
        body: ListView(
          children: [
            listMenus(),
          ],
        ),
        bottomNavigationBar: customNavigationBar(),
      ),
    );

  }
}