import 'dart:convert';
import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/product_vm.dart';
import 'package:customer_pesenin/ui/views/orders/cart.dart';
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

  int currentIndex = 0;
  bool _isLoadingPage = false;
  String filterByCategory = '';
  String name = '';

  @override
  void initState() {
    setData();
    refreshData();
    super.initState();
  }

  void setData() async {
    if (mounted) setState(() => _isLoadingPage = true);
    final ProductVM productVM = Provider.of<ProductVM>(context, listen: false);
    await productVM.fetchProductCategories();
    await productVM.fetchProducts(filterByCategory);
    if (mounted) setState(() => _isLoadingPage = false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Widget cartButtonWithBadge() {
      return Container(
        margin: EdgeInsets.zero,
        child: FittedBox(
          child: Stack(
            alignment: const Alignment(1.3, -1.8),
            children: [
              Container(
                height: 45.0,
                width: 45.0,
                margin: EdgeInsets.zero,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Cart.routeName);
                  },
                  backgroundColor: primaryColor,
                  child: Image.asset(
                    'assets/icons/icon_cart.png',
                    width: 21,
                  ),
                ),
              ),
              Container(             
                padding: const EdgeInsets.all(3),
                constraints: const BoxConstraints(minHeight: 23, minWidth: 23),
                decoration: BoxDecoration( // This controls the shadow
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.red  // This would be color of the Badge
                ),
                child: Center(
                  child: Text(
                    '0',
                    style: primaryTextStyle.copyWith(
                      fontSize: 10
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget lists() {
      return Container(
        margin: EdgeInsets.only(
          top: 20.0,
          bottom: defaultMargin*2.3,
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

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor1,
        appBar: PreferredSize(
          preferredSize: const Size(71, 71),
          child: Container(
            margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Consumer<ProductVM>(
              builder: (context, productVM, child) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          filterByCategory = '';
                          currentIndex = 0;
                          Provider.of<ProductVM>(context, listen: false).fetchProducts(filterByCategory);
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
                          color: currentIndex == 0 ? primaryColor : transparentColor,
                          border: currentIndex == 0 ? null : Border.all(
                            color: subtitleTextColor
                          ),
                        ),
                        child: Text(
                          'Semua',
                          style: currentIndex == 0 ? primaryTextStyle.copyWith(
                            fontSize: 13,
                            fontWeight: medium,
                          ) : secondaryTextStyle.copyWith(
                            fontSize: 13,
                            fontWeight: medium,
                          ),
                        ), 
                      ),
                    ),
                    Row(
                      children: [
                        for (int i = 0; i < productVM.productCategories.length; i++) GestureDetector(
                          onTap: () {
                            setState(() {
                              filterByCategory = productVM.productCategories[i].id.toString();
                              currentIndex = i+1;
                              Provider.of<ProductVM>(context, listen: false).fetchProducts(filterByCategory);
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
                              color: currentIndex == i+1 ? primaryColor : transparentColor,
                              border: currentIndex == i+1 ? null : Border.all(
                                color: subtitleTextColor
                              ),
                            ),
                            child: Text(
                              productVM.productCategories[i].name.toString(),
                              style: currentIndex == i+1 ? primaryTextStyle.copyWith(
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
        ),
        body: _isLoadingPage ? Center(
          child: SizedBox(
            height: 33,
            width: 33,
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          ),
        ) : ListView(
          children: [
            lists(),
          ]
        ),
        floatingActionButton: cartButtonWithBadge(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      ),
    );

  }

  Future refreshData() async {
    final prefs = await SharedPreferences.getInstance();
    final extractData = jsonDecode(prefs.getString('customerNewData')!);
    setState(() {
      name = extractData['name'];
    });
  }

}