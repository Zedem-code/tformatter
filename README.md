TFormatters

```dart
Un package Flutter/Dart puissant pour le formatage, la validation, et la manipulation des données courantes telles que les dates, les heures, les devises, les numéros de téléphone, et bien plus.

Caractéristiques Principales
Formatage des dates, heures, et durées.
Formatage des montants et pourcentages.
Validation des e-mails, URL, numéros de téléphone, et mots de passe sécurisés.
Manipulation avancée des chaînes : génération d'initiales, extraction d'extensions, et plus encore.
Support de l'internationalisation (i18n) pour les formats régionaux.
Génération et validation d'identifiants uniques.
Installation
Ajoutez le package à votre projet Flutter/Dart via pub.dev :

bash
Copier le code
flutter pub add h_formatters
Ou modifiez directement votre fichier pubspec.yaml :

yaml
Copier le code
dependencies:
h_formatters: ^1.0.0
Puis, exécutez :

bash
Copier le code
flutter pub get
Utilisation de Base

1. Formatage des Dates et Heures
   dart
   Copier le code
   import 'package:h_formatters/h_formatters.dart';

void main() {
final now = DateTime.now();

// Formatage de la date
print(TFormatters.formatDate(now, pattern: 'dd/MM/yyyy', locale: 'fr_FR'));
// Résultat : 04/01/2025

// Formatage de l'heure
print(TFormatters.formatHour(now));
// Résultat : 14:30:15
} 2. Formatage des Montants et Pourcentages
dart
Copier le code
void main() {
// Formatage d'un montant avec devise
print(TFormatters.formatCurrency(1234.56, locale: 'fr_FR', currencySymbol: '€'));
// Résultat : 1 234,56 €

// Formatage en pourcentage
print(TFormatters.formatPercentage(0.875));
// Résultat : 87.50%
} 3. Validation des Entrées
dart
Copier le code


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

4. Manipulation des Chaînes
dart
Copier le code
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
5. Gestion des Durées
dart
Copier le code
void main() {
  final duration = Duration(hours: 2, minutes: 30);

  // Conversion d'une durée en texte lisible
  print(TFormatters.durationToReadableText(duration));
  // Résultat : 2 heures 30 minutes
}
6. Fonctionnalités Diverses
dart
Copier le code
void main() {
  // Masquage de données sensibles
  print(TFormatters.maskSensitiveData('1234567890', visibleChars: 4));
  // Résultat : ******7890

  // Formatage d'une taille de fichier
  print(TFormatters.formatFileSize(1048576));
  // Résultat : 1.0 MB

  // Génération d'un lien hypertexte HTML
  print(TFormatters.toHyperlink('Google', 'https://google.com'));
  // Résultat : <a href="https://google.com">Google</a>
}
Internationalisation (i18n)
Le package prend en charge les formats locaux pour les dates, heures, et montants grâce à la bibliothèque intl.

Exemple :
dart
Copier le code
void main() {
  final now = DateTime.now();

  // Formatage de la date dans différentes locales
  print(TFormatters.formatDate(now, locale: 'en_US')); // Résultat : January 4, 2025
  print(TFormatters.formatDate(now, locale: 'fr_FR')); // Résultat : 4 janvier 2025
}
Liste Complète des Méthodes
Formatage
formatDate(DateTime date, {String pattern, String locale})
formatHour(DateTime date)
formatCurrency(double amount, {String locale, String currencySymbol})
formatPercentage(double value, {int decimalPlaces})
durationToReadableText(Duration duration)
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
Contribution
Nous accueillons vos suggestions et contributions ! Suivez ces étapes pour contribuer :

Clonez le dépôt GitHub :

bash
Copier le code
git clone https://github.com/your_username/h_formatters.git
Créez une branche pour vos modifications :

bash
Copier le code
git checkout -b feature/my-new-feature
Soumettez une Pull Request.

Licence
Ce package est sous licence MIT. Vous êtes libre de l'utiliser et de le modifier selon vos besoins.
```
