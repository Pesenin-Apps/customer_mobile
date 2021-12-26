import 'package:customer_pesenin/core/models/order.dart';
import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/order_vm.dart';
import 'package:customer_pesenin/ui/widgets/order/order_item_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderItemTileEditedCustomer extends StatefulWidget {
  final String? orderId;
  final OrderItem? orderItem;

  const OrderItemTileEditedCustomer({
    Key? key,
    required this.orderId,
    required this.orderItem,
  }) : super(key: key);

  @override
  _OrderItemTileEditedCustomerState createState() => _OrderItemTileEditedCustomerState();
}

class _OrderItemTileEditedCustomerState extends State<OrderItemTileEditedCustomer> {

  int _currentlyQty = 0;
  bool _isLoadingUpdate = false;
  bool _isLoadingRemove = false;

  @override
  void initState() {
    _currentlyQty = widget.orderItem!.qty!;
    super.initState();
  }

  void onSubmitUpdate(String orderId, String orderItemId, int qty) {
    setState(() => _isLoadingUpdate = true );
    Future.delayed(const Duration(seconds: 2), () async {
      final Map<String, dynamic> formUpdate = {
        'items': [
          { 
            'item': orderItemId,
            'qty': qty,
          }
        ],
      };
      final bool response = await Provider.of<OrderVM>(context, listen: false).updateCustomerOrderItem(orderId, formUpdate);

      if (response) {
        // refresh data
        await Provider.of<OrderVM>(context, listen: false).fetchCustomerOrderDetail(orderId);
        setState(() { });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Berhasil, Item telah di Ubah!',
            ),
          ),
        );
        setState(() => _isLoadingUpdate = false );
      } else {
        setState(() {
          _currentlyQty = widget.orderItem!.qty!;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: errorColor,
            content: const Text(
              'Gagal, Terjadi Kesalahan!',
            ),
          ),
        );
        setState(() => _isLoadingUpdate = false );
      }
      
    });
  }

  void onSubmitRemove(String orderId, String orderItemId) {
    setState(() => _isLoadingRemove = true );
    Future.delayed(const Duration(seconds: 2), () async {
      final Map<String, dynamic> formRemove = {
        'items': [
          { 
            'item': orderItemId,
          }
        ],
      };
      final bool response = await Provider.of<OrderVM>(context, listen: false).removeCustomerOrderItem(orderId, formRemove);

      if (response) {
        // refresh data
        await Provider.of<OrderVM>(context, listen: false).fetchCustomerOrderDetail(orderId);
        setState(() { });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: const Text(
              'Berhasil, Item telah di Hapus!',
            ),
          ),
        );
        setState(() => _isLoadingRemove = false );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: errorColor,
            content: const Text(
              'Gagal, Terjadi Kesalahan!',
            ),
          ),
        );
        setState(() => _isLoadingRemove = false );
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {

    Future<void> showConfirmDialogRemove() async {
      return showDialog(
        context: context, 
        builder: (BuildContext context) => Container(
          margin: EdgeInsets.zero,
          width: MediaQuery.of(context).size.width - (2 * defaultMargin),
          child: AlertDialog(
            backgroundColor: backgroundColor3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: primaryTextColor,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.error_outline_rounded,
                    color: primaryColor,
                    size: 100,
                  ),
                  const SizedBox( height: 12),
                  Text(
                    'Item Ini Dihapus?',
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Item akan dihapus secara',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    'PERMANEN',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 150,
                    height: 40,
                    margin: EdgeInsets.zero,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onSubmitRemove(widget.orderId!, widget.orderItem!.id!);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: errorColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Ya, Hapus',
                        style: tertiaryTextStyle.copyWith(
                          fontSize: 13,
                          fontWeight: semiBold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      );
    }

    return Container(
      margin: EdgeInsets.only(
        top: defaultMargin/2,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              OrderItemStatus(status: widget.orderItem!.status),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.orderItem!.product!.name!,
                      style: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      formatCurrency.format(widget.orderItem!.product!.price),
                      style: priceTextStyle.copyWith(
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
              ),
              _isLoadingRemove ? const SizedBox() : _isLoadingUpdate ?  Container(
                width: 16,
                height: 16,
                margin: EdgeInsets.zero,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(
                    primaryColor,
                  ),
                ),
              ) : Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _currentlyQty = _currentlyQty + 1;
                        onSubmitUpdate(widget.orderId!, widget.orderItem!.id!, _currentlyQty);
                      });
                    },
                    child: Image.asset(
                      'assets/icons/icon_cart_add.png',
                      width: 23,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _currentlyQty.toString(),
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(height: 2),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _currentlyQty = _currentlyQty - 1;
                        onSubmitUpdate(widget.orderId!, widget.orderItem!.id!, _currentlyQty);
                      });
                    },
                    child: Image.asset(
                      'assets/icons/icon_cart_minus.png',
                      width: 23,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  showConfirmDialogRemove();
                },
                child: _isLoadingUpdate ? const SizedBox() : _isLoadingRemove ? Container(
                  width: 16,
                  height: 16,
                  margin: EdgeInsets.zero,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(
                      errorColor,
                    ),
                  ),
                ) : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/icons/icon_cart_remove.png',
                      width: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Hapus',
                      style: dangerTextStyle.copyWith(
                        fontSize: 13,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );

  }

}