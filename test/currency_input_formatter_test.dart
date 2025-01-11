import 'package:flutter_test/flutter_test.dart';
import 'package:tformatter/input_formatters/currency_input_formatter.dart';

void main() {
  group('CurrencyInputFormatter', () {
    test('Formats input correctly for en_US locale', () {
      final formatter =
          CurrencyInputFormatter(locale: 'en_US', currencySymbol: '\$');
      final oldValue = TextEditingValue.empty;
      final newValue = TextEditingValue(text: '12345');

      final result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '\$123.45');
    });

    test('Formats input correctly for fr_FR locale', () {
      final formatter =
          CurrencyInputFormatter(locale: 'fr_FR', currencySymbol: '€');
      final oldValue = TextEditingValue.empty;
      final newValue = TextEditingValue(text: '12345');

      final result = formatter.formatEditUpdate(oldValue, newValue);
      expect(result.text, '123,45\u00A0€');
    });
  });
}
