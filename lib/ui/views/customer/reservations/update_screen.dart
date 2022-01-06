import 'package:customer_pesenin/core/helpers/routes_generator.dart';
import 'package:customer_pesenin/core/utils/constans.dart';
import 'package:customer_pesenin/core/utils/enum.dart';
import 'package:customer_pesenin/core/utils/theme.dart';
import 'package:customer_pesenin/core/viewmodels/cart_vm.dart';
import 'package:customer_pesenin/core/viewmodels/connection_vm.dart';
import 'package:customer_pesenin/core/viewmodels/order_vm.dart';
import 'package:customer_pesenin/ui/views/customer/orders/updated_screen.dart';
import 'package:customer_pesenin/ui/views/customer/reservations/choose_product_screen.dart';
import 'package:customer_pesenin/ui/views/no_inet_screen.dart';
import 'package:customer_pesenin/ui/widgets/cart/cart_tile.dart';
import 'package:customer_pesenin/ui/widgets/custom_radio.dart';
import 'package:customer_pesenin/ui/widgets/custom_textfield.dart';
import 'package:customer_pesenin/ui/widgets/order/order_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CustomerReservationUpdateScreen extends StatefulWidget {
  static const routeName = '/customer-update-reservation';

  final String? id;

  const CustomerReservationUpdateScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _CustomerReservationUpdateScreenState createState() => _CustomerReservationUpdateScreenState();
}

class _CustomerReservationUpdateScreenState extends State<CustomerReservationUpdateScreen> {

  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController _datePlan = TextEditingController();
  TextEditingController _timePlan = TextEditingController();
  TextEditingController _numberOfPeople = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  int _countOrderItem = 0;
  bool _isLoadingPage = false;
  bool _isLoadingSubmit = false;

  OrderServing _orderServingSelected = OrderServing.none;

  @override
  void initState() {
    getData();
    final reservation = Provider.of<OrderVM>(context, listen: false).customerOrder.reservation;
    _datePlan = TextEditingController(
      text: formatYearMonthDay.format(DateTime.parse(reservation!.datetimePlan!).toLocal()),
    );
    _datePlan.addListener(onChangeControl);
    _timePlan = TextEditingController(
      text: formatHourMinute.format(DateTime.parse(reservation.datetimePlan!).toLocal()),
    );
    _timePlan.addListener(onChangeControl);
    _numberOfPeople = TextEditingController(
      text: reservation.numberOfPeople.toString(),
    );
    _numberOfPeople.addListener(onChangeControl);
    super.initState();
  }

  void onChangeControl() {
    setState(() { });
  }

  @override
  void dispose() {
    _datePlan.removeListener(onChangeControl);
    _datePlan.dispose();
    _timePlan.removeListener(onChangeControl);
    _timePlan.dispose();
    _numberOfPeople.removeListener(onChangeControl);
    _numberOfPeople.dispose();
    super.dispose();
  }

  void getData() async {
    Provider.of<ConnectionVM>(context, listen: false).startMonitoring();
    setState(() => _isLoadingPage = true );
    await Provider.of<OrderVM>(context, listen: false).fetchCustomerOrderDetail(widget.id!);
    final order = Provider.of<OrderVM>(context, listen: false).customerOrder;
    setState(() {
      _orderServingSelected = order.reservation!.servingType == orderServingOntime ? OrderServing.onTime : OrderServing.byConfirmation;
      final dateTimePlan = DateTime.parse(order.reservation!.datetimePlan!).toLocal();
      _selectedDate = dateTimePlan;
      _selectedTime = TimeOfDay(hour: dateTimePlan.hour, minute: dateTimePlan.minute);
      _countOrderItem = order.orderItem!.length;
    });
    setState(() => _isLoadingPage = false );
  }

  Future _selectedBuildDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 7),
      helpText: 'Pilih Tanggal Reservasi',
      cancelText: 'Batal',
      confirmText: 'Pilih',
      // locale: const Locale('id', 'ID'),
      // initialDatePickerMode: DatePickerMode.year,
      initialEntryMode: DatePickerEntryMode.calendar,
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _selectedDate = picked;
        _datePlan = TextEditingController(text: formatYearMonthDay.format(picked));
      });
    }
  }

  Future _selectedBuildTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      // initialEntryMode: TimePickerEntryMode.input,
      helpText: 'Pilih Jam Reservasi',
      cancelText: 'Batal',
      confirmText: 'Pilih',
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _timePlan = TextEditingController(text: formatTimeOfDay(picked));
      });
    }
  }

  void _onSubmitReservation(CartVM cartVM) async {
    setState(() => _isLoadingSubmit = true);
    // time checking
    final currentDateTime = DateTime.now();
    final dateTimePlan = DateTime.parse('${_datePlan.text} ${_timePlan.text}');
    final minutesBefore = currentDateTime.difference(dateTimePlan).inMinutes;
    if (minutesBefore > -150) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: errorColor,
          content: const Text(
            'Periksa kembali waktu reservasi, pemesanan reservasi maksimal 3 jam sebelumnya!',
          ),
        ),
      );
      setState(() => _isLoadingSubmit = false);
    } else {
      // actions
      final OrderVM orderVM = Provider.of<OrderVM>(context, listen: false);
      Future.delayed(const Duration(seconds: 3), () async {
        final Map<String, dynamic> formUpdateReservation = {
          'datetime_plan': '${_datePlan.text} ${_timePlan.text}',
          'number_of_people': _numberOfPeople.text,
          'serving_type': _orderServingSelected == OrderServing.onTime ? orderServingOntime : orderServingByConfirmation,
          'orders': cartVM.carts.map((cart) => {
            'item': cart.product!.id,
            'qty': cart.qty,
          }).toList(),
        };
        final bool response = await orderVM.updateCustomerReservation(widget.id!, formUpdateReservation);
        if (response) {
          Navigator.pop(context);
          await orderVM.fetchCustomerOrderDetail(widget.id!);
          setState(() { });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: primaryColor,
              content: const Text(
                'Berhasil, Data Reservasi Telah Diubah!',
              ),
            ),
          );
          cartVM.carts = [];
          setState(() => _isLoadingSubmit = false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: errorColor,
              content: const Text(
                'Gagal, Terjadi Kesalahan Pada Sistem!',
              ),
            ),
          );
          setState(() => _isLoadingSubmit = false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    CartVM cartVM = Provider.of<CartVM>(context);

    Future<void> showConfirmDialogUpdateReservation() async {
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
                    'Reservasi telah sesuai?',
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Pastikan yang anda inputkan data yang valid, mohon periksa kembali sebelum Reservasi.',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 150,
                    height: 40,
                    margin: EdgeInsets.zero,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _onSubmitReservation(cartVM);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Ya, Sesuai',
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

    Widget formInput() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Form(
          key: formGlobalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date
              Text(
                'Tanggal',
                style: primaryTextStyle.copyWith(
                  fontSize: 13,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: () async {
                  await _selectedBuildDate(context);
                },
                child: IgnorePointer(
                  child: CustomTextField(
                    hintText: 'Pilih Tanggal Reservasi', 
                    inputName: 'Tanggal Reservasi', 
                    controller: _datePlan, 
                    onSubmitField: () {
                      print('');
                    }, 
                    onChange: (value) {
                      print('');
                    },
                    isBorder: true,
                    actionType: TextInputType.text,
                    actionKeyboard: TextInputAction.go,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Time
              Text(
                'Jam',
                style: primaryTextStyle.copyWith(
                  fontSize: 13,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: () async {
                  await _selectedBuildTime(context);
                },
                child: IgnorePointer(
                  child: CustomTextField(
                    hintText: 'Pilih Jam Reservasi', 
                    inputName: 'Jam Reservasi', 
                    controller: _timePlan, 
                    onSubmitField: () {
                      print('');
                    }, 
                    onChange: (value) {
                      print('');
                    },
                    isBorder: true,
                    actionType: TextInputType.text,
                    actionKeyboard: TextInputAction.go,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Number Of People
              Text(
                'Jumlah Orang (Pelanggan)',
                style: primaryTextStyle.copyWith(
                  fontSize: 13,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(height: 5),
              CustomTextField(
                hintText: 'Masukkan Jumlah Orang (Pelanggan)', 
                inputName: 'Jumlah Orang (Pelanggan)', 
                controller: _numberOfPeople, 
                onSubmitField: () {
                  print('');
                }, 
                onChange: (value) {
                  print('');
                },
                isBorder: true,
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                actionType: TextInputType.number,
                actionKeyboard: TextInputAction.go,
              ),
              const SizedBox(height: 20),
              // Option Servings
              Text(
                'Penyajian Pesanan',
                style: primaryTextStyle.copyWith(
                  fontSize: 13,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomRadio(
                    label: Wrap(
                      children: [
                        Text(
                          'ON TIME',
                          style: primaryTextStyle,
                        )
                      ],
                    ),
                    padding: const EdgeInsets.all(0),
                    groupValue: _orderServingSelected,
                    onChanged: (OrderServing newValue) {
                      setState(() {
                        _orderServingSelected = newValue;
                      });
                    },
                    value: OrderServing.onTime,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  CustomRadio(
                    label: Wrap(
                      children: [
                        Text(
                          'BY CONFIRMATION',
                          style: primaryTextStyle,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(0),
                    groupValue: _orderServingSelected,
                    onChanged: (OrderServing newValue) {
                      setState(() {
                        _orderServingSelected = newValue;
                      });
                    },
                    value: OrderServing.byConfirmation
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _orderServingSelected == OrderServing.onTime ? Text(
                'Penyajian pesanan akan disiapkan secara tepat waktu (On time) berdasarkan waktu Reservasi.',
                style: secondaryTextStyle.copyWith(
                  fontSize: 10,
                  ),
              ) : Text(
                'Penyajian pesanan akan disiapkan berdasarkan kofirmasi pelanggan.',
                style: secondaryTextStyle.copyWith(
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget orderItemAdditional() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin/1.5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tambahan Item Pesanan',
              style: primaryTextStyle.copyWith(
                fontSize: 13,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                _orderServingSelected == OrderServing.onTime && cartVM.carts.isEmpty && _countOrderItem == 0 ? Text(
                  'Karena penyajian Tepat Waktu (On Time) maka anda wajib menambahkan Item.',
                  style: errorTextStyle.copyWith(
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ) : Column(
                  children: cartVM.carts.map((e) => CartTile(cart: e)).toList(),
                ),
                const SizedBox(height: 5),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context, 
                          ReservationChooseProductScreen.routeName,
                          arguments: ScreenArguments(
                            type: 'reservation-additional',
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Text(
                          '+ Tambah Item',
                          style: themeTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget buttonSubmit() {
      return Container(
        height: 40,
        width: double.infinity,
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: TextButton(
          onPressed: () {
            if (formGlobalKey.currentState!.validate()) {
              formGlobalKey.currentState!.save();
              if (_orderServingSelected == OrderServing.onTime && cartVM.carts.isEmpty && _countOrderItem == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: errorColor,
                    content: const Text(
                      'Item pesanan kosong!',
                    ),
                  ),
                );
              } else {
                showConfirmDialogUpdateReservation();
              }
            }
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )
          ),
          child: _isLoadingSubmit ? Container(
            width: 16,
            height: 16,
            margin: EdgeInsets.zero,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(
                backgroundColor3,
              ),
            ),
          ) : Text(
            'Simpan Perubahan',
            style: tertiaryTextStyle.copyWith(
              fontSize: 14,
              fontWeight: semiBold,
            ),
          ),
        ),
      );
    }

    Widget orderItemHasOrdered() {
      return _countOrderItem > 0 ? Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          bottom: defaultMargin,
        ),
        child: Consumer<OrderVM>(
          builder: (context, orderVM, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Item Yang Telah Dipesan',
                    style: primaryTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: semiBold,
                    ),
                  ),
                  orderVM.canChangedCustomerOrderExist ? InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context, 
                        CustomerOrderUpdateScreen.routeName,
                        arguments: ScreenArguments(
                          id: widget.id!, 
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Text(
                        'Ubah Item',
                        style: themeTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                  ) : const SizedBox(),
                ],
              ),
              Column(
                children: [
                  for (var i = 0; i < orderVM.customerOrder.orderItem!.length; i++) OrderItemTile(orderItem : orderVM.customerOrder.orderItem![i]),
                ],
              ),
            ],
          ),
        ),
      ) : const SizedBox(height: 30);
    }

    return Consumer<ConnectionVM>(
      builder: (context, connectionVM, _) => connectionVM.isOnline != null && connectionVM.isOnline! ? SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor3,
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 0,
            title: const Text('Ubah Data Reservasi'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                cartVM.carts = [];
                Navigator.pop(context);
              },
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
          ) : SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  formInput(),
                  orderItemAdditional(),
                  buttonSubmit(),
                  orderItemHasOrdered(),
                ],
              ),
            ),
          ),
        ),
      ) : const NoInternetConnectionScreen(),
    );

  }

}