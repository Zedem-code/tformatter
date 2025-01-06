import 'package:flutter/services.dart';

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  MaskedTextInputFormatter({required this.mask, this.separator = '-'});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(separator, '');
    String formatted = '';
    int maskIndex = 0;
    for (int i = 0; i < text.length; i++) {
      if (maskIndex >= mask.length) break;

      if (mask[maskIndex] == separator) {
        formatted += separator;
        maskIndex++;
      }
      formatted += text[i];
      maskIndex++;
    }
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
