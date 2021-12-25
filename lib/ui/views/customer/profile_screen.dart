import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/ui/views/customer/profiles/change_password_screen.dart';
import 'package:customer_pesenin/ui/views/customer/profiles/change_profile_screen.dart';
import 'package:customer_pesenin/ui/widgets/menu_tile.dart';
import 'package:flutter/material.dart';

class CustomerProfileScreen extends StatefulWidget {
  static const routeName = '/profile-customer';
  const CustomerProfileScreen({ Key? key }) : super(key: key);

  @override
  _CustomerProfileScreenState createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  @override
  Widget build(BuildContext context) {

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
      ),
    );

  }
}