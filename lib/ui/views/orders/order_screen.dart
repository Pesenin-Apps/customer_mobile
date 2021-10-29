import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/my-order';
  const OrderScreen({ Key? key }) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: AppBar(
        backgroundColor: backgroundColor1,
        elevation: 0,
        centerTitle: true,
        title: const Text('Pesanan Saya')
      ),
      body: Container(),
    );
  }
}