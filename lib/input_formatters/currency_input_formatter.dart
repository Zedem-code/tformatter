import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final String locale;
  final String currencySymbol;

  CurrencyInputFormatter({required this.locale, required this.currencySymbol});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final value = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    final formatter =
        NumberFormat.currency(locale: locale, symbol: currencySymbol);

    final formatted = formatter.format(double.tryParse(value) ?? 0 / 100);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
