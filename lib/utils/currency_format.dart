import 'package:intl/intl.dart';

abstract class CurrencyFormat {
  static String format(double value, {int decimalDigits = 4, bool trailingZeros = false}) {
    final formatter = NumberFormat.currency(customPattern: '#,##0.00', locale: 'en_US', decimalDigits: decimalDigits);
    final baseFormat = formatter.format(value).replaceAll(',', ' ').replaceAll('.', ',');
    final cropZeros = baseFormat.replaceAll(RegExp(r"0*$"), "");
    final result = cropZeros.replaceAll(RegExp(r",$"), "");
    return result;
  }
}
