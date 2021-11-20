import 'dart:io';

import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/cart_vm.dart';
import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/core/viewmodels/product_vm.dart';
import 'package:customer_pesenin/ui/views/no_inet_screen.dart';
import 'package:customer_pesenin/ui/views/orders/cart_screen.dart';
import 'package:customer_pesenin/ui/widgets/product/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;
  bool _isLoadingPage = false;
  bool _isLoadingData = false;
  String _filterByCategory = '';

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    if (mounted) Provider.of<ConnectionVM>(context, listen: false).startMonitoring();
    if (mounted) setState(() => _isLoadingPage = true);
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('tokenData')) {
      final ProductVM productVM = Provider.of<ProductVM>(context, listen: false);
      if (mounted) await productVM.fetchProductCategories();
      final String firstCategory = productVM.productCategories[0].id.toString();
      if (mounted) setState(() => _filterByCategory = firstCategory);
      if (mounted) await productVM.fetchProducts(_filterByCategory);
    }
    if (mounted) setState(() => _isLoadingPage = false);
  }

  Future refreshData() async{
    if (mounted) await Provider.of<ProductVM>(context, listen: false).fetchProductCategories();
    if (mounted) await Provider.of<ProductVM>(context, listen: false).fetchProducts(_filterByCategory);
    setState(() { });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    CartVM cartVM = Provider.of<CartVM>(context);

    Widget lists() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin/3,
          bottom: defaultMargin/3,
        ),
        child: Consumer<ProductVM>(
          builder: (context, productVM, child) => Column(
            children: [
              for (var i = 0; i < productVM.product.length; i++) ProductTile(productVM.product[i])
            ],
          ),
        ),
      );
    }

    return  Consumer<ConnectionVM>(
      builder: (context, connectionVM, _) => connectionVM.isOnline != null && connectionVM.isOnline! ? SafeArea(
        child:  _isLoadingPage ? Center(
            child: SizedBox(
              height: 33,
              width: 33,
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          ) : Scaffold(
          backgroundColor: backgroundColor1,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(105.0),
            child: Column(
              children: [
                AppBar(
                  backgroundColor: transparentColor,
                  elevation: 0,
                  // centerTitle: true,
                  title: Text(
                    'PESENIN APPS',
                    style: titleApps,
                  ),
                  actions: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(3.0),
                      child: FittedBox(
                        child: Stack(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.shopping_cart_rounded),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pushNamed(context, Cart.routeName);
                              },
                            ),
                            cartVM.carts.isEmpty ? const SizedBox() : Positioned(
                              right: 11,
                              top: 5,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 15,
                                  minHeight: 15,
                                ),
                                child: Text(
                                  cartVM.carts.length.toString(),
                                  style: primaryTextStyle.copyWith(
                                    fontSize: 8
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 5.0),
                  child: Consumer<ProductVM>(
                    builder: (context, productVM, child) => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          // GestureDetector(
                          //   onTap: () {
                          //     setState(() {
                          //       _filterByCategory = '';
                          //       _currentIndex = 0;
                          //       Provider.of<ProductVM>(context, listen: false).fetchProducts(_filterByCategory);
                          //     });
                          //   },
                          //   child: Container(
                          //     margin: const EdgeInsets.only(right: 16),
                          //     padding: const EdgeInsets.symmetric(
                          //       horizontal: 12,
                          //       vertical: 10,
                          //     ),
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(12),
                          //       color: _currentIndex == 0 ? primaryColor : transparentColor,
                          //       border: _currentIndex == 0 ? null : Border.all(
                          //         color: subtitleTextColor
                          //       ),
                          //     ),
                          //     child: Text(
                          //       'Semua',
                          //       style: _currentIndex == 0 ? primaryTextStyle.copyWith(
                          //         fontSize: 13,
                          //         fontWeight: medium,
                          //       ) : secondaryTextStyle.copyWith(
                          //         fontSize: 13,
                          //         fontWeight: medium,
                          //       ),
                          //     ), 
                          //   ),
                          // ),
                          Row(
                            children: [
                              for (int i = 0; i < productVM.productCategories.length; i++) GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    _isLoadingData = true;
                                    _filterByCategory = productVM.productCategories[i].id.toString();
                                    _currentIndex = i; // i + 1
                                  });
                                  await Provider.of<ProductVM>(context, listen: false).fetchProducts(_filterByCategory);
                                  setState(() {
                                    _isLoadingData = false;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 16),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: _currentIndex == i ? primaryColor : transparentColor,
                                    border: _currentIndex == i ? null : Border.all(
                                      color: subtitleTextColor
                                    ),
                                  ),
                                  child: Text(
                                    productVM.productCategories[i].name.toString(),
                                    style: _currentIndex == i ? primaryTextStyle.copyWith(
                                      fontSize: 13,
                                      fontWeight: medium,
                                    ) : secondaryTextStyle.copyWith(
                                      fontSize: 13,
                                      fontWeight: medium,
                                    ),
                                  ),
                                ),
                              )
                            ],    
                          ),
                        ],
                      ),
                    ),
                  )
                ),
              ],
            ),
          ),
          body:  _isLoadingData ? Center(
            child: SizedBox(
              height: 33,
              width: 33,
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          ) : Platform.isIOS ? Container() : RefreshIndicator(
            backgroundColor: backgroundColor1,
            color: primaryColor,
            onRefresh: refreshData,
            child: ListView(
              children: [
                lists(),
              ]
            ),
          ),
        ),
      ) : const NoInternetConnectionScreen(),
    );

  }

}