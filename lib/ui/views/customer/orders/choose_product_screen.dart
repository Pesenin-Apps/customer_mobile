import 'dart:io';

import 'package:customer_pesenin/core/helpers/routes_generator.dart';
import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/cart_vm.dart';
import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/core/viewmodels/product_vm.dart';
import 'package:customer_pesenin/ui/views/customer/orders/cart_screen.dart';
import 'package:customer_pesenin/ui/views/no_inet_screen.dart';
import 'package:customer_pesenin/ui/widgets/product/product_tile.dart';
import 'package:customer_pesenin/ui/widgets/refresh/page_refresh.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseProductScreen extends StatefulWidget {
  static const routeName = '/choose-product';

  final String? table;
  final String? type;
  const ChooseProductScreen({ 
    Key? key,
    required this.table,
    required this.type,
  }) : super(key: key);

  @override
  _ChooseProductScreenState createState() => _ChooseProductScreenState();
}

class _ChooseProductScreenState extends State<ChooseProductScreen> {

  int currentTabIndex = 0;
  bool _isLoadingPage = false;
  bool _isLoadingDataProduct = false; // if moving tab
  String filterByCategory = '';

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    Provider.of<ConnectionVM>(context, listen: false).startMonitoring();
    if (mounted) setState(() => _isLoadingPage = true);
    final ProductVM productVM = Provider.of<ProductVM>(context, listen: false);
    await productVM.fetchProductCategories();
    final String firstCategory =  productVM.productCategories[0].id.toString();
    setState(() {
      filterByCategory = firstCategory;
    });
    await productVM.fetchProducts(filterByCategory);
    if (mounted) setState(() => _isLoadingPage = false);
  }

  Future refreshData() async{
    if (mounted) await Provider.of<ProductVM>(context, listen: false).fetchProductCategories();
    if (mounted) await Provider.of<ProductVM>(context, listen: false).fetchProducts(filterByCategory);
    setState(() { });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    CartVM cartVM = Provider.of<CartVM>(context);

    Widget listProducts() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin/6,
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

    return Consumer<ConnectionVM>(
      builder: (context, connectionVM, _) => connectionVM.isOnline != null && connectionVM.isOnline! ? SafeArea(
        child: _isLoadingPage ? PageRefresh(bgColor: backgroundColor3, circularColor: primaryColor) : Scaffold(
          backgroundColor: backgroundColor3,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(110.0),
            child: Column(
              children: [
                AppBar(
                  backgroundColor: primaryColor,
                  leading: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      cartVM.carts = [];
                      Navigator.pop(context);
                    },
                  ),
                  elevation: 0,
                  centerTitle: true,
                  title: const Text('Menu'),
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
                                Navigator.pushNamed(
                                  context, 
                                  CustomerCartScreen.routeName,
                                  arguments: ScreenArguments(
                                    table: widget.table,
                                    type: widget.type,
                                  ),
                                );
                              },
                            ),
                            cartVM.carts.isEmpty ? const SizedBox() : Positioned(
                              right: 11,
                              top: 5,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: errorColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 15,
                                  minHeight: 15,
                                ),
                                child: Text(
                                  cartVM.carts.length.toString(),
                                  style: tertiaryTextStyle.copyWith(
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
                  margin: const EdgeInsets.only(
                    top: 9.0,
                    bottom: 3.0,
                  ),
                  child: Consumer<ProductVM>(
                    builder: (context, productVM, child) => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Row(
                            children: [
                              for (int i = 0; i < productVM.productCategories.length; i++) GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    _isLoadingDataProduct = true;
                                    filterByCategory = productVM.productCategories[i].id.toString();
                                    currentTabIndex = i; // i + 1
                                  });
                                  await Provider.of<ProductVM>(context, listen: false).fetchProducts(filterByCategory);
                                  setState(() {
                                    _isLoadingDataProduct = false;
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
                                    color: currentTabIndex == i ? primaryColor : transparentColor,
                                    border: currentTabIndex == i ? Border.all(
                                      color: primaryColor
                                    ) : Border.all(
                                      color: secondaryTextColor
                                    ),
                                  ),
                                  child: Text(
                                    productVM.productCategories[i].name.toString(),
                                    style: currentTabIndex == i ? tertiaryTextStyle.copyWith(
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
          body: _isLoadingDataProduct ? Center(
            child: SizedBox(
              height: 33,
              width: 33,
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          ) :  Platform.isIOS ? Container() : RefreshIndicator(
            backgroundColor: backgroundColor3,
            color: primaryColor,
            onRefresh: refreshData,
            child: ListView(
              children: [
                listProducts(),
              ]
            ),
          ),
        ),
      ) : const NoInternetConnectionScreen(),
    );

  }

}