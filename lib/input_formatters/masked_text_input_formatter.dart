import 'package:flutter/services.dart';

/// A custom [TextInputFormatter] for applying a mask to text input.
///
/// This class formats text input dynamically according to the provided [mask].
/// It replaces each `#` character in the mask with corresponding digit from the input,
/// and keeps other character (e.g., spaces, dashes, parentheses) as static.
///
/// ### Parameters:
/// - [mask] : A string defining the desired format.
///   - Use `#` as placeholder for digits.
///   - Static characters in the mask (e.g., `-`, `(`, `)`) are retained in the formatted output.
///
/// ### Examples:
/// ```dart
/// final formatter = MaskedTextInputFormatter(mask: '(###) ###-####'); // Input: "1234567890" // Output: "(123) 456-7890"
///
/// final formatter = MaskedTextInputFormatter(mask: '####-####-####-####'); // Input: "4111111111111111" // Output: "4111-1111-1111-1111"
/// ```
class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;

  MaskedTextInputFormatter({required this.mask});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final rawText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    String formattedText = '';
    int rawTextIndex = 0;

    for (int i = 0; i < mask.length; i++) {
      if (rawTextIndex >= rawText.length) break;

      final maskChar = mask[i];
      if (maskChar == '#') {
        formattedText += rawText[rawTextIndex];
        rawTextIndex++;
      } else {
        formattedText += maskChar;
      }
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
