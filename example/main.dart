import 'package:flutter/material.dart';
import 'package:tformatter/tformatter.dart';

import 'input_formatters.dart';

void main() {
  runApp(const TFormattersExample());
}

class TFormattersExample extends StatelessWidget {
  const TFormattersExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TFormatters Example'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const InputFormattersDemo()));
                },
                child: Text('Input formatters'))
          ],
        ),
        body: const TFormattersDemo(),
      ),
    );
  }
}

class TFormattersDemo extends StatelessWidget {
  const TFormattersDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final amount = 1234.567;
    final email = 'test@example.com';
    final url = 'https://example.com';
    final fileName = 'document.pdf';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TFormatters Examples',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Example 1: Date and Time Formatting
          Text(
              'Current Date: ${TFormatters.formatDate(now, pattern: 'dd-MM-yyyy')}'),

          const Divider(),

          // Example 2: Currency and Percentage Formatting
          Text(
              'Formatted Currency: ${TFormatters.formatCurrency(amount, locale: 'en_US', currencySymbol: '\$')}'),
          Text('Formatted Percentage: ${TFormatters.formatPercentage(0.875)}'),
          const Divider(),

          // Example 3: Validation
          Text('Is Valid Email: ${TFormatters.isValidEmail(email)}'),
          Text('Is Valid URL: ${TFormatters.isValidUrl(url)}'),
          const Divider(),

          // Example 4: String Manipulation
          Text(
              'Extracted Email Domain: ${TFormatters.extractEmailDomain(email)}'),
          Text('File Extension: ${TFormatters.getFileExtension(fileName)}'),
          Text(
              'Generated Initials: ${TFormatters.generateInitials("John Doe")}'),
          const Divider(),

          // Example 6: Masking Sensitive Data
          Text(
              'Masked Phone Number: ${TFormatters.maskSensitiveData("1234567890", visibleChars: 4)}'),
          const Divider(),
        ],
      ),
    );
  }
}
