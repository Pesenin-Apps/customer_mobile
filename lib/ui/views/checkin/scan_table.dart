import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/ui/views/checkin/form.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io' show Platform;

class ScanTable extends StatefulWidget {
  static const routeName = '/scan-table';
  const ScanTable({ Key? key }) : super(key: key);

  @override
  _ScanTableState createState() => _ScanTableState();
}

class _ScanTableState extends State<ScanTable> {

  Barcode? qr;
  QRViewController? controller;
  final qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: transparentColor,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
          color: primaryTextColor,
        ),
        elevation: 0,
      ),
      body: Stack(
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
      ),
    );
  }

  Widget tableInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor2,
      ),
      child: Column(
        children: [
          Text(
            'Photobooth Baru No. 14',
            maxLines: 3,
            style: primaryTextStyle,
          ),
          Text(
            'Status : Meja Kosong',
            maxLines: 3,
            style: primaryTextStyle,
          ),
        ],
      ),
    );
  }

  Widget contentHeader() {
    return qr != null ? tableInfo() : const Text('');
  }

  Widget placeholderScanning() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor2,
      ),
      child: Text(
       'Pindai kode yang terletak dimeja Anda.',
        maxLines: 3,
        style: primaryTextStyle,
      ),
    );
  }

  Widget buttonNext() {
    return Container(
      margin: EdgeInsets.zero,
      child: TextButton(
        onPressed: () {
          // Navigator.pushNamed(context, '/check-in');
          Navigator.popAndPushNamed(context, CheckInForm.routeName);
          // Navigator.pushNamedAndRemoveUntil(context, '/check-in', (route) => false);
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(12),
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Lanjut',
          style: primaryTextStyle,
        ),
      ),
    );
  }

  Widget contentFooter() {
    return qr == null ? buttonNext() : placeholderScanning();
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
    controller.scannedDataStream.listen((qr) { 
      setState(() {
        this.qr = qr;
      }); 
    });
  }

}