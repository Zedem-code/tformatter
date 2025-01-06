import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final String locale;
  final String currencySymbol;

  CurrencyInputFormatter({required this.locale, required this.currencySymbol});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Récupérer uniquement les chiffres
    final rawText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Si l'entrée est vide, renvoyer une chaîne vide
    if (rawText.isEmpty) {
      return TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // Convertir les chiffres en double pour le formattage
    final value = double.parse(rawText) / 100;

    // Formater la valeur
    final formatter =
        NumberFormat.currency(locale: locale, symbol: currencySymbol);
    final formatted = formatter.format(value);

    // Calculer le nouvel offset (position du curseur)
    final newCursorPosition = formatted.length -
        (oldValue.text.length - oldValue.selection.baseOffset);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
          offset: newCursorPosition.clamp(0, formatted.length)),
    );
  }
}
