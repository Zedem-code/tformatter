import 'package:flutter_test/flutter_test.dart';
import 'package:tformatter/input_formatters/masked_text_input_formatter.dart';

void main() {
  group('Masked text formatter tests', () {
    test('Formats text correctly', () {
      final formatter = MaskedTextInputFormatter(mask: '(###) ###-####');

      final oldValue = TextEditingValue.empty;
      final newValue = TextEditingValue(text: '1234567890');
      final formattedValue = formatter.formatEditUpdate(oldValue, newValue);

      expect(formattedValue.text, '(123) 456-7890');
    });

    test('Handles incomplete input correctly', () {
      final formatter = MaskedTextInputFormatter(mask: '(###) ###-####');

      final oldValue = TextEditingValue.empty;
      final newValue = TextEditingValue(text: '12345');

      final formatted = formatter.formatEditUpdate(oldValue, newValue);
      expect(formatted.text, '(123) 45');
    });
  });
}
