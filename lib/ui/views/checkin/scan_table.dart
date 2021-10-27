import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/customer_vm.dart';
import 'package:customer_pesenin/ui/views/checkin/form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'dart:io' show Platform;

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
  bool findCode = false;

  @override
  void initState() {
    getTable();
    super.initState();
  }  

  getTable() async {
    await Provider.of<CustomerVM>(context, listen: false).fetchTableDetail('');
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  // @override
  // void reassemble() async {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     await controller!.pauseCamera();
  //   }
  //   controller!.resumeCamera();
  // }
  
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

  Widget contentHeader() {
    return Container(
       padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor2,
      ),
      child: findCode ? Consumer<CustomerVM>(
        builder: (context, customerVM, child) => customerVM.tableDetail.name != null ? Column(
          children: [
            Text(
              '${customerVM.tableDetail.section?.name} No. ${customerVM.tableDetail.number}',
              maxLines: 2,
              style: primaryTextStyle,
            ),
            Text(
              customerVM.tableDetail.used == true ? 'Status : Meja Telah Terisi' : 'Status : Meja Kosong',
              style: primaryTextStyle,
            ),
          ],
        ) : Text(
          'QR CODE FAILED',
          style: primaryTextStyle,
        ),
      ) : Text(
       'SCAN QR CODE',
        style: primaryTextStyle,
      ),
    );
  }

  Widget contentFooter() {
    return findCode ? Consumer<CustomerVM>(
      builder: (context, customerVM, child) => customerVM.tableDetail.used == true ? Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor2,
        ),
        child: Column(
          children: [
            Text(
              'Mohon maaf,',
              style: primaryTextStyle,
            ),
            Text(
              'meja telah diisi oleh pelanggan lain.',
              style: primaryTextStyle,
            ),
            Text(
              'Silahkan pilih meja yang lain.',
              style: primaryTextStyle,
            ),
          ],
        ),
      ) : customerVM.tableDetail.name != null ? Container(
        margin: EdgeInsets.zero,
        child: TextButton(
          onPressed: () {
            // Navigator.popAndPushNamed(context, CheckInForm.routeName, arguments: { customerVM.tableDetail.id },);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckInForm(table: customerVM.tableDetail.id.toString())
              ),
            );
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
            style: primaryTextStyle,
          ),
        ),
      ) : Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor2,
        ),
        child: Text(
          'Kode bukan bagian dari Pesenin Apps.',
          style: primaryTextStyle,
        ),
      )
    ) : Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor2,
      ),
      child: Text(
       'Pindai kode yang terletak dimeja Anda.',
        style: primaryTextStyle,
      ),
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
    controller.scannedDataStream.listen((qr) { 
      setState(() {
        this.qr = qr;
        Provider.of<CustomerVM>(context, listen: false).fetchTableDetail(this.qr!.code);
        controller.stopCamera();
        findCode = true;
      }); 
    });
  }

}