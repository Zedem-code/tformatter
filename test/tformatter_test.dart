import 'package:flutter_test/flutter_test.dart';

import 'package:tformatter/tformatter.dart';

void main() {
  test('formats phone number correctly', () {
    final phone =
        TFormatters.formatPhoneNumber('0123456789', '(#) ###-###-###');
    expect(phone, '(0) 123-456-789');
  });

  test('Validate phone number', () {
    final isValid = TFormatters.isValidPhoneNumber('+0123456789');
    expect(isValid, true);
  });

  test('formats date correctly', () {
    final date = DateTime(2025, 1, 1);
    final formatted = TFormatters.formatDate(date);
    expect(formatted, '2025-01-01');
  });

  test('formats currency correctly ', () {
    final amount = TFormatters.formatCurrency(90, currencySymbol: '\$');
    expect(amount, '\$90.00');
  });

  test('formats duration', () {
    final hour = Duration(hours: 1, minutes: 50);

    final duration = TFormatters.formatDuration(hour);
    expect(duration, '1h 50m 0s');
  });

  test('formats date difference', () {
    final start = DateTime(2025, 1, 1);
    final end = DateTime(2025, 1, 4);
    final diff = TFormatters.dateDifference(start, end, locale: 'fr');
    expect(diff, '3 jours');
  });

  test('calculate time ago', () {
    final past = DateTime.now().subtract(Duration(days: 2));
    final ago = TFormatters.timeAgo(past);
    expect(ago, '2 days');
  });

  test('format number shortcuts', () {
    final number = TFormatters.formatNumberShortcut(12345678);
    expect(number, '12.3M');
  });

  test('generates initials correctly', () {
    final initials = TFormatters.generateInitials('John Doe');
    expect(initials, 'JD');
  });

  test('formats percentage', () {
    final result = TFormatters.formatPercentage(0.85234, decimalPlaces: 1);
    expect(result, '85.2%');
  });

  test('formats URL', () {
    final result = TFormatters.formatUrl('example.com');
    expect(result, 'https://example.com');
  });

  test('masks sensitive data', () {
    final result =
        TFormatters.maskSensitiveData('1234567890123456', visibleChars: 4);
    expect(result, '************3456');
  });

  test('validates email addresses', () {
    expect(TFormatters.isValidEmail('test@example.com'), true);
    expect(TFormatters.isValidEmail('invalid-email'), false);
  });

  test('validates URLs', () {
    expect(TFormatters.isValidUrl('https://example.com'), true);
    expect(TFormatters.isValidUrl('invalid-url'), false);
  });

  test('extracts email domain', () {
    expect(TFormatters.extractEmailDomain('test@example.com'), 'example.com');
    expect(TFormatters.extractEmailDomain('invalid-email'), 'invalid_email');
  });

  test('gets file extension', () {
    expect(TFormatters.getFileExtension('document.pdf'), 'pdf');
    expect(TFormatters.getFileExtension('document'), 'No extension found');
  });

  test('formats JSON to readable text', () {
    final json = '{"name":"John","age":30}';
    final result = TFormatters.formatJson(json);
    expect(result, contains('name'));
    expect(result, contains('John'));
  });

  test('validates secure password', () {
    expect(TFormatters.isValidPassword('StrongP@ssw0rd'), true);
    expect(TFormatters.isValidPassword('weakpass'), false);
  });

  test('format address', () {
    final street = "Av De l'eglise";
    final city = 'Butembo';
    final country = "DRC";
    final adress = TFormatters.formatAddress(street, city, country);
    expect(adress, "Av De l'eglise, Butembo, DRC");
  });

  test('shorted number', () {
    expect(TFormatters.formatNumberShortcut(1000000), '1.0M');
  });

  test('format a list', () {
    final items = ['Alice', 'Bob', 'Charlie'];
    final listPersons = TFormatters.formatList(items);
    expect(listPersons, 'Alice, Bob and Charlie');
  });

  test('validate the date', () {
    expect(TFormatters.isValidDate('2025-01-09 18:00:00'), true);
  });

  test('validate credit card', () {
    expect(TFormatters.isValidCreditCard('4539 1488 0343 6467'), true);
  });
}
