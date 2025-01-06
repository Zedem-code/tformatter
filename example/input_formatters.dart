import 'package:flutter/material.dart';
import 'package:tformatter/input_formatters/currency_input_formatter.dart';
import 'package:tformatter/input_formatters/masked_text_input_formatter.dart';

class InputFormattersDemo extends StatelessWidget {
  const InputFormattersDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Formatters Example'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Example 1: Currency Input Formatter
            TextFormField(
              inputFormatters: [
                CurrencyInputFormatter(locale: 'en_US', currencySymbol: '\$'),
              ],
              decoration: const InputDecoration(
                labelText: 'Currency Formatter',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // Example 2: Masked Text Formatter
            TextFormField(
              inputFormatters: [
                MaskedTextInputFormatter(
                  mask: '####-####-####',
                ),
              ],
              decoration: const InputDecoration(
                labelText: 'Masked Formatter (Card Number)',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}
