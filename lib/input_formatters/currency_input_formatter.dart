import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// A custom [TextInputFormatter] for formatting currency input dynamically.
///
/// This formatter takes raw numerical input and formats it as currency in real time.
/// It supports locale-based formatting and a customizable currency symbol.
///
/// ### Parameters:
/// - [locale]: The locale to use for formatting (e.g., `'en_US'`, `'fr_FR'`).
/// - [currencySymbol]: The symbol to use for the currency (e.g., `'$'`, `'€'`).
///
/// ### Behavior:
/// - Removes all non-numeric characters from the input.
/// - Divides the number by 100 to represent a monetary value.
/// - Formats the resulting value as currency based on the locale and symbol.
///
/// ### Examples:
/// ```dart
/// final formatter = CurrencyInputFormatter(locale: 'en_US', currencySymbol: '\$');// Input: "12345" // Output: "$123.45"
///
/// final frenchFormatter = CurrencyInputFormatter(locale: 'fr_FR', currencySymbol: '€');// Input: "12345" // Output: "123,45 €"
///
/// ```
class CurrencyInputFormatter extends TextInputFormatter {
  final String locale;
  final String currencySymbol;

  /// Creates a [CurrencyInputFormatter] with the specified [locale] and [currencySymbol].
  CurrencyInputFormatter({required this.locale, required this.currencySymbol});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove all non-numeric characters from the new value
    final rawText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Handle empty input
    if (rawText.isEmpty) {
      return TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // Convert the raw input to a monetary value
    final value = double.parse(rawText) / 100;

    // Format the value as currency
    final formatter =
        NumberFormat.currency(locale: locale, symbol: currencySymbol);
    final formatted = formatter.format(value);

    final newCursorPosition = formatted.length -
        (oldValue.text.length - oldValue.selection.baseOffset);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
          offset: newCursorPosition.clamp(0, formatted.length)),
    );
  }
}
