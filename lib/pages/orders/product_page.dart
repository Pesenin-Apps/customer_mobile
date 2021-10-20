import 'package:customer_pesenin/providers/products/category_provider.dart';
import 'package:customer_pesenin/theme.dart';
import 'package:customer_pesenin/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {

  const ProductPage({ Key? key }) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();

}

class _ProductPageState extends State<ProductPage> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    ProductCategoryProvider productCategoryProvider = Provider.of<ProductCategoryProvider>(context);
    
    Widget category() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: 16),
              Row(
                children: productCategoryProvider.productCategories.map(
                  (productCategory) => GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = productCategoryProvider.productCategories.indexOf(productCategory).toInt();
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
                        color: currentIndex == productCategoryProvider.productCategories.indexOf(productCategory).toInt() ? primaryColor : transparentColor,
                        border: currentIndex == productCategoryProvider.productCategories.indexOf(productCategory).toInt() ? null : Border.all(
                          color: subtitleTextColor
                        ),
                      ),
                      child: Text(
                        productCategory.name.toString(),
                        style: currentIndex == productCategoryProvider.productCategories.indexOf(productCategory).toInt() ? primaryTextStyle.copyWith(
                          fontSize: 13,
                          fontWeight: medium,
                        ) : secondaryTextStyle.copyWith(
                          fontSize: 13,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ),
                ).toList(),
              ),
            ],
          ),
        ),
      );
    }

    Widget lists() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Column(
          children: const [
            ProductTile(),
            ProductTile(),
            ProductTile(),
            ProductTile(),
            ProductTile(),
            ProductTile(),
            ProductTile(),
            ProductTile(),
          ],
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
    );

  }

}