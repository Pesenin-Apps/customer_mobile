import 'package:customer_pesenin/providers/product_provider.dart';
import 'package:customer_pesenin/providers/products/category_provider.dart';
import 'package:customer_pesenin/theme.dart';
import 'package:customer_pesenin/viewmodels/product_vm.dart';
import 'package:customer_pesenin/widgets/product_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {

  const ProductPage({ Key? key }) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();

}

class _ProductPageState extends State<ProductPage> {

  int currentIndex = 0;
  bool _isLoading = false;
  String filterByCategory = '';

  @override
  void initState() {
    setTime();
    super.initState();
  }

  void setTime() async {

    setState(() => _isLoading = true );

    final ProductVM productVM = Provider.of<ProductVM>(context, listen: false);
    await productVM.fetchProductCategories();

    setState(() => _isLoading = false );

  }

  @override
  Widget build(BuildContext context) {

    ProductProvider productProvider = Provider.of<ProductProvider>(context);

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
                  onPressed: () { },
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
    
    Widget category() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Consumer<ProductVM>(
          builder: (context, productVM, child) => _isLoading ? Center(
            child: SizedBox(
              height: 33,
              width: 33,
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          ) : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      filterByCategory = '';
                      currentIndex = 0;
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
      );
    }

    Widget lists() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          bottom: defaultMargin*2.3,
        ),
        child: Column(
          children: productProvider.products.map((product) => ProductTile(product)).toList(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: ListView(
        children: [
          category(),
          lists(),
        ]
      ),
      floatingActionButton: cartButtonWithBadge(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
    );

  }

}