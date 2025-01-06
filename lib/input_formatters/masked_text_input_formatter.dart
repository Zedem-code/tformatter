import 'package:flutter/services.dart';

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;

  MaskedTextInputFormatter({required this.mask});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    /// Récupérer uniquement les chiffres
    final rawText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    String formattedText = '';
    int rawTextIndex = 0;

    /// Parcourir le masque et appliquer la mise en forme
    for (int i = 0; i < mask.length; i++) {
      if (rawTextIndex >= rawText.length) break;

      final maskChar = mask[i];
      if (maskChar == '#') {
        /// Si le caractère du masque est un "#" (chiffre attendu)
        formattedText += rawText[rawTextIndex];
        rawTextIndex++;
      } else {
        /// Sinon, ajoutez les caractères fixes du masque (parenthèses, tirets, etc.)
        formattedText += maskChar;
      }
    }

    /// Retourner le texte formaté
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
