import 'package:customer_pesenin/core/helpers/routes_generator.dart';
import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/core/viewmodels/user_vm.dart';
import 'package:customer_pesenin/ui/views/auth/check_in_screen.dart';
import 'package:customer_pesenin/ui/views/no_inet_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanningScreen extends StatefulWidget {
  static const routeName = '/scanning';
  final String type;

  const ScanningScreen({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  _ScanningScreenState createState() => _ScanningScreenState();
}

class _ScanningScreenState extends State<ScanningScreen> {

  Barcode? qr;
  QRViewController? controller;
  bool findCode = false;
  final qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    connectionChecking();
    super.initState();
  }  

  connectionChecking() {
    Provider.of<ConnectionVM>(context, listen: false).startMonitoring();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Widget tableInfo(String tableSectionName, String tableNumber, int tableStatus) {
      return Column(
        children: [
          Text(
            '$tableSectionName No. $tableNumber',
            maxLines: 2,
            style: tertiaryTextStyle,
          ),
          Text(
            tableStatusStr(tableStatus),
            style: tertiaryTextStyle,
          ),
        ],
      );
    }

    Widget boxDescription(Widget widget) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor4,
        ),
        child: widget,
      );
    }

    Widget tableHasUsed() {
      return Column(
        children: [
          Text(
            'Mohon maaf,',
            style: tertiaryTextStyle,
          ),
          Text(
            'meja telah diisi oleh pelanggan lain.',
            style: tertiaryTextStyle,
          ),
          Text(
            'Silahkan pilih meja yang lain.',
            style: tertiaryTextStyle,
          ),
        ],
      );
    }

    Widget tableHasReserved() {
      return Column(
        children: [
          Text(
            'Mohon maaf,',
            style: tertiaryTextStyle,
          ),
          Text(
            'meja telah direservasi.',
            style: tertiaryTextStyle,
          ),
          Text(
            'Silahkan pilih meja yang lain.',
            style: tertiaryTextStyle,
          ),
        ],
      );
    }

    Widget tableIsNotPart() {
      return Text(
        'Kode bukan bagian dari Pesenin Apps.',
        style: dangerTextStyle,
      );
    }

    Widget placeholder() {
      return Text(
        'Pindai kode yang terletak dimeja Anda.',
        style: tertiaryTextStyle,
      );
    }    

    Widget buttonUseTheTable(String tableId) {
      return Container(
        margin: EdgeInsets.zero,
        child: TextButton(
          onPressed: () {
            if (widget.type == 'checkin') {
              Navigator.popAndPushNamed(
                context, 
                CheckInScreen.routeName,
                arguments: ScreenArguments(
                  id: tableId, 
                ),
              );
            } else {
              print('For Create Order Customer');
            }
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(12),
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Gunakan Meja Ini',
            style: tertiaryTextStyle,
          ),
        ),
      );
    }

    Widget contentHeader() {
      return Container(
        padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor4,
        ),
        child: findCode ? Consumer<UserVM>(
          builder: (context, userVM, child) => userVM.tableDetail.name != null ? 
            tableInfo(userVM.tableDetail.section!.name!, userVM.tableDetail.number.toString(), userVM.tableDetail.status!) : Text(
            'QR CODE FAILED',
            style: dangerTextStyle,
          ),
        ) : Text(
        'SCAN QR CODE',
          style: tertiaryTextStyle,
        ),
      );
    }

    Widget contentFooter() {
      return findCode ? Consumer<UserVM>(
        builder: (context, userVM, child) => userVM.tableDetail.status == tableUsed ? 
          boxDescription(tableHasUsed()) : userVM.tableDetail.status == tableReserved ? 
          boxDescription(tableHasReserved()) : userVM.tableDetail.name != null ? 
          buttonUseTheTable(userVM.tableDetail.id!) : boxDescription(tableIsNotPart())
      ) : boxDescription(placeholder());
    }

    Widget body() {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          buildQrView(context),
          Positioned(
            bottom: 30,
            child: contentFooter(),
          ),
          Positioned(
            top: 100,
            child: contentHeader(),
          ),
        ]
      );
    }

    return Consumer<ConnectionVM>(
      builder: (context, connectionVM, _) => connectionVM.isOnline != null && connectionVM.isOnline! ? Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: transparentColor,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
            color: backgroundColor2,
          ),
          elevation: 0,
          actions: [
            findCode ? IconButton(
              icon: const Icon(Icons.refresh_rounded),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  controller!.resumeCamera();
                  findCode = false;
                });
              },
            ) : const SizedBox(),
          ],
        ),
        body: body(),
      ) : const NoInternetConnectionScreen(),
    );

  }

  Widget buildQrView(BuildContext context) => QRView(
    key: qrKey, 
    onQRViewCreated: onQRViewCreated,
    overlay: QrScannerOverlayShape(
      borderWidth: 10,
      borderLength: 20,
      borderRadius: 12,
      borderColor: primaryColor,
      cutOutSize: MediaQuery.of(context).size.width * 0.8,
    ),
  );

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((qr) async { 
      setState(() {
        this.qr = qr;
        controller.pauseCamera();
      }); 
      if (mounted) await Provider.of<UserVM>(context, listen: false).fetchTableDetail(this.qr!.code);
      setState(() {
        findCode = true;
      });
    });
  }

}