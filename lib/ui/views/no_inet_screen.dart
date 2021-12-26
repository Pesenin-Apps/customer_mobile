import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class NoInternetConnectionScreen extends StatefulWidget {
  const NoInternetConnectionScreen({ Key? key }) : super(key: key);

  @override
  State<NoInternetConnectionScreen> createState() => _NoInternetConnectionScreenState();
}

class _NoInternetConnectionScreenState extends State<NoInternetConnectionScreen> {

  @override
  void initState() {
    Provider.of<ConnectionVM>(context, listen: false).startMonitoring();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor3,
        body: Container(
          margin: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 128,
                width: 128,
                margin: const EdgeInsets.only(
                  bottom: 25,
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/no_internet_connection.png',
                      
                    ),
                  ),
                ),
              ),
              Text(
                'Tidak Ada Sambungan Internet',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'Anda tidak terhubung dengan Internet, silahkan hubungkan Handphone anda dengan Internet.',
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: medium
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}