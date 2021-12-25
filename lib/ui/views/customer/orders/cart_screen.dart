import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/cart_vm.dart';
import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/core/viewmodels/order_vm.dart';
import 'package:customer_pesenin/core/viewmodels/user_vm.dart';
import 'package:customer_pesenin/ui/views/customer/home_screen.dart';
import 'package:customer_pesenin/ui/views/no_inet_screen.dart';
import 'package:customer_pesenin/ui/widgets/cart/cart_is_empty.dart';
import 'package:customer_pesenin/ui/widgets/cart/cart_tile.dart';
import 'package:customer_pesenin/ui/widgets/order/description_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerCartScreen extends StatefulWidget {
  static const routeName = '/cart-customer';

  final String? table;
  final String? type;
  const CustomerCartScreen({
    Key? key,
    required this.table,
    required this.type,
  }) : super(key: key);

  @override
  _CustomerCartScreenState createState() => _CustomerCartScreenState();
}

class _CustomerCartScreenState extends State<CustomerCartScreen> {

  bool _isAdditional = false;
  bool _isLoadingPage = false;
  bool _isLoadingSubmit = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    Provider.of<ConnectionVM>(context, listen: false).startMonitoring();
    setState(() {
      _isLoadingPage = true;
      _isAdditional = widget.type == 'additional';
    });
    await Provider.of<UserVM>(context, listen: false).fetchTableDetail(widget.table!);
    setState(() => _isLoadingPage = false);
  }

  void onSubmitOrder(String table, CartVM cartVM) async {
    setState(() => _isLoadingSubmit = true);
    final OrderVM orderVM = Provider.of<OrderVM>(context, listen: false);
    try {
      Future.delayed(const Duration(seconds: 3), () async {
        final String response = await orderVM.createCustomerOrder(table, cartVM.carts);
        if (response == 'null') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: dangerColor,
              content: const Text(
                'Gagal, Terjadi Kesalahan!',
              ),
            ),
          );
          setState(() => _isLoadingSubmit = false);
        } else {
          if (_isAdditional) {
            int count = 0;
            await Provider.of<OrderVM>(context, listen: false).fetchCustomerOrderDetail(response);
            setState(() { });
            Navigator.of(context).popUntil((_) => count++ >= 2);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: primaryColor,
                content: const Text(
                  'Berhasil, Tambahan Item Telah Ditambahkan!',
                ),
              ),
            );
          } else {
            Navigator.pushNamedAndRemoveUntil(context, CustomerHomeScreen.routeName, (route) => false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: primaryColor,
                content: const Text(
                  'Berhasil, Pesanan Telah Ditambahkan!',
                ),
              ),
            );
          }
          cartVM.carts = [];
        }
      });
    } catch (e) {
      // print('Something Error (orderSubmit) : $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    CartVM cartVM = Provider.of<CartVM>(context);

    Widget tableInfo() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: backgroundColor3,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: roundedBorderColor
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 3),
              spreadRadius: 0,
              blurRadius: 5,
              color: backgroundColor4.withOpacity(0.2),
            ),
          ],
        ),
        child: Consumer<UserVM>(
          builder: (context, userVM, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Meja Pelanggan',
                style: primaryTextStyle.copyWith(
                  fontSize: 13,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(height: 12),
              DescriptionTile(title: 'Bagian', description: userVM.tableDetail.section!.name.toString()),
              DescriptionTile(title: 'Nomor', description: userVM.tableDetail.number.toString()),
            ],
          ),
        ),
      );
    }

    Widget cartLists() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin/1.5,
          bottom: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Column(
                  children: cartVM.carts.map((e) => CartTile(cart: e)).toList(),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        children: [
          _isAdditional ? const SizedBox() : tableInfo(),
          cartVM.carts.isEmpty ? const CartIsEmpty() : cartLists(),
        ],
      );
    }

    Widget customNavigationBar() {
      return Container(
        height: 80,
        decoration: BoxDecoration(
          color: backgroundColor3,
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Consumer<UserVM>(
              builder: (context, userVM, child) => Container(
                height: 40,
                margin: EdgeInsets.symmetric(
                  horizontal: defaultMargin/3,
                ),
                child: TextButton(
                  onPressed: () {
                    onSubmitOrder(userVM.tableDetail.id.toString(), cartVM);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pesan Sekarang',
                        style: tertiaryTextStyle.copyWith(
                          fontSize: 15,
                          fontWeight: semiBold,
                        ),
                      ),
                      _isLoadingSubmit ? Container(
                        width: 16,
                        height: 16,
                        margin: EdgeInsets.zero,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(
                            backgroundColor3,
                          ),
                        ),
                      ) : Icon(
                        Icons.arrow_forward,
                        color: backgroundColor3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Consumer<ConnectionVM>(
      builder: (context, connectionVM, _) => connectionVM.isOnline != null && connectionVM.isOnline! ? SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor3,
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 0,
            centerTitle: true,
            title: const Text('Keranjang'),
          ),
          body: _isLoadingPage ? Center(
            child: SizedBox(
              height: 33,
              width: 33,
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          ) : content(),
          bottomNavigationBar: cartVM.carts.isEmpty ? const SizedBox() : customNavigationBar(),
        ),
      ) : const NoInternetConnectionScreen(),
    );

  }

}