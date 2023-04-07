import 'package:intl/intl.dart';

abstract class CurrencyFormat {
  static String format(double value, {int decimalDigits = 4, bool trailingZeros = false}) {
    final formatter = NumberFormat.currency(decimalDigits: decimalDigits, symbol: '', customPattern: '#,##0.00');
    return formatter.format(value).replaceAll(',', ' ').replaceAll('.', ',');
  }
}
