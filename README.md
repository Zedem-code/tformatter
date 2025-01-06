## TFormatters

A powerful Flutter/Dart package for formatting, validation, and manipulation of common data types such as dates, times, currencies, phone numbers, and more.

- Formatting of dates, times, and durations.
- Formatting of amounts and percentages.
- Validation of emails, URLs, phone numbers, and secure passwords.
- Advanced string manipulation: generating initials, extracting file extensions, and more.
- Generation and validation of unique identifiers.

### 1. Formatting Dates and Times

```dart
import 'package:tformatter/tformatter.dart';

void main() {
final now = DateTime.now();

// Formatage de la date
print(TFormatters.formatDate(now, pattern: 'dd/MM/yyyy', locale: 'fr_FR'));
// Résultat : 04/01/2025

// Formatage de l'heure
print(TFormatters.formatHour(now));
// Résultat : 14:30:15
}
```

### 2. Formatting Amounts and Percentages

```dart
import 'package:tformatter/tformatter.dart';

void main() {
// Formatage d'un montant avec devise
print(TFormatters.formatCurrency(1234.56, locale: 'fr_FR', currencySymbol: '€'));
// Résultat : 1 234,56 €

// Formatage en pourcentage
print(TFormatters.formatPercentage(0.875));
// Résultat : 87.50%
}
```

### 3. Validating Inputs

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

### 4. Manipulating Strings

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

### 5. Managing Durations

```dart
import 'package:tformatter/tformatter.dart';

void main() {
final duration = Duration(hours: 2, minutes: 30);

// Conversion d'une durée en texte lisible
print(TFormatters.durationToReadableText(duration));
// Résultat : 2 heures 30 minutes
}
```

### 6. Miscellaneous Features

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

### 7. Direct Formatting in Text Fields

Le package inclut des **`TextInputFormatters`** pour ajouter des masquages ou formatages dynamiques directement dans les champs de texte.

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
MaskedTextInputFormatter(mask: '####-####-####', separator: '-'),
],
decoration: const InputDecoration(
labelText: 'Numéro de carte',
),
keyboardType: TextInputType.number,
);
```

### 8. Complete List of Methods

Formatting

```dart
formatDate(DateTime date, {String pattern, String locale})
formatHour(DateTime date)
formatCurrency(double amount, {String locale, String currencySymbol})
formatPercentage(double value, {int decimalPlaces})
formatDuration(Duration duration)
Validation
isValidEmail(String email)
isValidUrl(String url)
isValidPhoneNumber(String phoneNumber)
isValidPassword(String password, {int minLength})
Manipulation
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
```
