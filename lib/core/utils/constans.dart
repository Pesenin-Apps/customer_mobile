import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Role User
const roleGuest = 'guest';
const roleCustomer = 'customer';

// Table Status
const tableFree = 1;
const tableUsed = 2;
const tableReserved = 3;

const baseUrlImage = 'https://api-pesenin.onggolt-dev.com/uploads/';

final formatCurrency = NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

final formatDate = DateFormat('dd MMMM yyyy', 'id_ID');
final formatTime = DateFormat('Hms');
final formatDateTime = DateFormat('dd-MM-yyyy Hms');
final formatDateWithDay = DateFormat('EEEE, dd MMMM yyyy', 'id_ID');
final formatDateTimeWithDay = DateFormat('EEEE, dd MMMM yyyy H:m:s', 'id_ID');

double defaultMargin = 30.0;

Color primaryColor = const Color(0xffFFA700);
Color secondaryColor = const Color(0xff28BAAB);
Color tertiaryColor = const Color(0xff8D887D);
Color dangerColor = const Color(0xffED6363);
Color warningColor = const Color(0xfffdac53);
Color infoColor = const Color(0xff00a170);
Color priceColor = const Color(0xff2C96F1);
Color backgroundColor1 = const Color(0xffFAFAFA);
// Color backgroundColor1 = const Color(0xff252119);
Color backgroundColor2 = const Color(0xffF3F3ED); 
// Color backgroundColor2 = const Color(0xff322D25);
Color backgroundColor3 = const Color(0xffFFFFFF);
// Color backgroundColor3 = const Color(0xff2F2A21);
Color backgroundColor4 = const Color(0xff322D25);
// Color backgroundColor4 = const Color(0xff353025);
Color primaryTextColor = const Color(0xff111111);
// Color primaryTextColor = const Color(0xffF1F0F2);
Color secondaryTextColor = const Color(0xff9B9B9A);
Color subtitleTextColor = const Color(0xff3C3833);
Color transparentColor = Colors.transparent;
Color errorColor = Colors.red;

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;

String orderItemStatusStr(int orderItemStatus) {
  switch (orderItemStatus) {
    case 1:
      return 'Menunggu Verifikasi Pelayan';
    case 2:
      return 'Dalam Antrian';
    case 3:
      return 'Sedang Diproses';
    default:
      return 'Telah Selesai';
  }
}

String tableStatusStr(int tableStatus) {
  switch (tableStatus) {
    case tableFree:
      return 'Status : Meja Kosong';
    case tableUsed:
      return 'Status : Meja Telah Terisi';
    case tableReserved:
      return 'Status : Meja Telah Direservasi';
    default:
      return 'null';
  }
}