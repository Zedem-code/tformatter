## TFormatters

A powerful Flutter/Dart package for formatting, validation, and manipulation of common data types such as dates, times, currencies, phone numbers, and more.

- Formatting of dates, times, and durations.
- Formatting of amounts and percentages.
- Validation of emails, URLs, phone numbers, and secure passwords.
- Advanced string manipulation: generating initials, extracting file extensions, and more.
- Generation and validation of unique identifiers.
- Credit Card Validation

### 1. Formatting

```dart
import 'package:tformatter/tformatter.dart';

void main() {
final now = DateTime.now();

// Formatage de la date
print(TFormatters.formatDate(now, pattern: 'dd/MM/yyyy', locale: 'fr_FR'));
// Résultat : 04/01/2025

// Format hour
print(TFormatters.formatHour(now));
// Résultat : 14:30:15

//Readable formatting: "X days ago", "X hours ago".
print(TFormatters.timeAgo(DateTime.now().subtract(Duration(days: 2))))
// Resultat: 2 jours

//Format durations in hours and minutes.
print(TFormatters.formatDuration(Duration(hours: 1, minutes: 50)))
// Resultat: 1h 50m 0s

// Format address
print(TFormatters.formatAddress("Av De l'eglise", 'Butembo', 'DRC'))
// Resultat: Av De l'eglise, Butembo, DRC

// Formatage d'un montant avec devise
print(TFormatters.formatCurrency(1234.56, locale: 'fr_FR', currencySymbol: '€'));
// Résultat : 1 234,56 €

// Formatage en pourcentage
print(TFormatters.formatPercentage(0.875));
// Résultat : 87.50%

//Standardization of Spaces
print(TFormatters.normalizeSpaces("Multiple\n\nnewlines \n and tabs\t\t"))
//Resultat: Multiple newlines and tabs

// Format phone number
print(TFormatters.formatPhoneNumber('0123456789','###-###-####'))
// Resultat: (0) 123-456-789
}
```

### 2. Validating Inputs

```dart
import 'package:tformatter/tformatter.dart';

void main() {
// Validation d'une adresse e-mail
print(TFormatters.isValidEmail('test@example.com'));
// Résultat : true

// Validation d'une URL
print(TFormatters.isValidUrl('https://example.com'));
// Résultat : true

// Validation d'un mot de passe sécurisé
print(TFormatters.isValidPassword('StrongP@ss1'));
// Résultat : true
}
```

### 3. Manipulating Strings

```dart
import 'package:tformatter/tformatter.dart';

void main() {
// Génération d'initiales
print(TFormatters.generateInitials('John Doe'));
// Résultat : JD

// Extraction du domaine d'une adresse e-mail
print(TFormatters.extractEmailDomain('user@example.com'));
// Résultat : example.com

// Extraction de l'extension d'un fichier
print(TFormatters.getFileExtension('document.pdf'));
// Résultat : pdf
}
```

### 4. Managing Durations

```dart
import 'package:tformatter/tformatter.dart';

void main() {
final duration = Duration(hours: 2, minutes: 30,seconds:10);

// Conversion d'une durée en texte lisible
print(TFormatters.formatDuration(duration));
// Résultat : 2h 30m 10s
}
```

### 5. Miscellaneous Features

```dart
import 'package:tformatter/tformatter.dart';

void main() {
// Masquage de données sensibles
print(TFormatters.maskSensitiveData('1234567890', visibleChars: 4));
// Résultat : **\*\***7890

// Formatage d'une taille de fichier
print(TFormatters.formatFileSize(1048576));
// Résultat : 1.0 MB

}
```

### 6. Direct Formatting in Text Fields

The package includes **`TextInputFormatters`** to add dynamic masking or formatting directly to text fields.

#### Exemple : Currency Formatter

```dart
import 'package:tformatters/input_formatters/currency_input_formatter.dart';

TextFormField(
inputFormatters: [
CurrencyInputFormatter(locale: 'fr_FR', currencySymbol: '€'),
],
decoration: const InputDecoration(
labelText: 'Montant',
),
keyboardType: TextInputType.number,
);
```

#### Exemple : Masked Input

```dart
import 'package:tformatters/input_formatters/masked_text_input_formatter.dart';

TextFormField(
inputFormatters: [
MaskedTextInputFormatter(mask: '####-####-####'),
],
decoration: const InputDecoration(
labelText: 'Numéro de carte',
),
keyboardType: TextInputType.number,
);
```

### 7. Credit card validation

```dart
void main() {
  // Numéros de test
  final validCard = '4539 1488 0343 6467'; // Carte valide (Visa)
  final invalidCard = '1234 5678 9012 3456'; // Carte invalide

  // Validation
  print(isValidCreditCard(validCard)); // Résultat : true
  print(isValidCreditCard(invalidCard)); // Résultat : false
}
```

### 8. Complete List of Methods

Formatting

```dart
formatDate(DateTime date, {String pattern, String locale})
formatHour(DateTime date)
formatCurrency(double amount, {String locale, String currencySymbol})
formatPercentage(double value, {int decimalPlaces})
formatDuration(Duration duration)

isValidEmail(String email)
isValidUrl(String url)
isValidPhoneNumber(String phoneNumber)
isValidPassword(String password, {int minLength})
generateInitials(String fullName)
maskSensitiveData(String data, {int visibleChars})
extractEmailDomain(String email)
getFileExtension(String fileName)
toHyperlink(String text, String url)
generatePassword({int number})
extractHashtags(String text)
decompressString(String text)
compressString(String text)
formatJson(String jsonString)
formatUrl(String url)
formatAddress(String street, String city, String country,{String postalCode = ''})
timeAgo(DateTime date, {String locale = 'en'})
dateDifference(DateTime startDate, DateTime endDate)
formatPhoneNumber(String phoneNumber);
isValidCreditCard(String cardNumber)
detectDataType(String input)
getCardType(String cardNumber)
formatNumberShortcut(double value)
...
```
