import 'dart:convert';
import 'dart:math';

import 'package:intl/intl.dart';

class TFormatters {
  /// Formatage d'un numéro de téléphone (supporte les numéros locaux et internationaux).
  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) return "Numéro invalide";
    if (phoneNumber.length == 10) {
      return "(${phoneNumber.substring(0, 1)}) ${phoneNumber.substring(1, 4)}-${phoneNumber.substring(4, 7)}-${phoneNumber.substring(7, 10)}";
    } else if (phoneNumber.length == 13) {
      return "+${phoneNumber.substring(0, 3)} ${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6, 9)}-${phoneNumber.substring(9, 13)}";
    }
    return phoneNumber;
  }

  /// Formatage des dates avec un modèle personnalisé.
  static String formatDate(DateTime date,
      {String pattern = 'yyyy-MM-dd', String locale = 'en_US'}) {
    try {
      return DateFormat(pattern, locale).format(date);
    } catch (e) {
      return "Date invalide";
    }
  }

  /// Formatage des montants avec symbole monétaire.
  static String formatCurrency(double amount,
      {String locale = 'en_US', String currencySymbol = '\$'}) {
    try {
      return NumberFormat.currency(locale: locale, symbol: currencySymbol)
          .format(amount);
    } catch (e) {
      return "Montant invalide";
    }
  }

  /// Formatage des durées en heures et minutes.
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    return '${hours}h ${minutes}m ${seconds}s';
  }

  /// Différence en jours, mois ou années entre deux dates.
  static String dateDifference(DateTime startDate, DateTime endDate) {
    final duration = endDate.difference(startDate);
    if (duration.inDays >= 365) {
      return '${(duration.inDays / 365).truncate()} ans';
    } else if (duration.inDays >= 30) {
      return '${(duration.inDays / 30).truncate()} mois';
    } else if (duration.inDays >= 7) {
      return '${(duration.inDays / 7).truncate()} semaines';
    } else {
      return '${duration.inDays} jours';
    }
  }

  /// Formatage lisible : "il y a X jours", "il y a X heures".
  static String timeAgo(DateTime date, {String locale = 'en'}) {
    final now = DateTime.now();
    final duration = now.difference(date);
    if (duration.inDays > 1) return '${duration.inDays} jours';
    if (duration.inHours > 1) return '${duration.inHours} heures';
    if (duration.inMinutes > 1) return '${duration.inMinutes} minutes';
    return 'à l\'instant';
  }

  /// Formatage des nombres avec raccourcis : 1.2k, 3M.
  static String formatNumberShortcut(double value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}k';
    }
    return value.toStringAsFixed(0);
  }

  /// Formatage d'une liste en chaîne lisible (ex. : "Apple, Banana, et Orange").
  static String formatList(List<String> items) {
    if (items.isEmpty) return '';
    if (items.length == 1) return items.first;
    final allButLast = items.sublist(0, items.length - 1);
    return '${allButLast.join(', ')} et ${items.last}';
  }

  /// Conversion entre fuseaux horaires.
  static DateTime convertTimeZone(
      DateTime date, String fromTimeZone, String toTimeZone) {
    final utcDate = date.toUtc();
    final toTimeZoneOffset = DateTime.now().timeZoneOffset;
    return utcDate.add(toTimeZoneOffset);
  }

  /// Validation d'un numéro de téléphone.
  static bool isValidPhoneNumber(String phoneNumber) {
    final regex = RegExp(r'^\+?[0-9]{10,13}$');
    return regex.hasMatch(phoneNumber);
  }

  /// Validation d'une date.
  static bool isValidDate(String date) {
    try {
      DateTime.parse(date);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Formatage des Pourcentages
  static String formatPercentage(double value, {int decimalPlaces = 2}) {
    final percentage = (value * 100).toStringAsFixed(decimalPlaces);
    return '$percentage%';
  }

  /// Génération des Initiales
  static String generateInitials(String fullName) {
    final words = fullName.trim().split(RegExp(r'\s+'));
    if (words.isEmpty) return '';
    final initials = words
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() : '')
        .join('');
    return initials.substring(0, initials.length > 2 ? 2 : initials.length);
  }

  /// Masquage des Données Sensibles
  static String maskSensitiveData(String data, {int visibleChars = 4}) {
    if (data.length <= visibleChars) return data;
    return '${'*' * (data.length - visibleChars)}${data.substring(data.length - visibleChars)}';
  }

  /// Normalisation des Espaces
  static String normalizeSpaces(String input) {
    return input.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Conversion en Mode "Titre"
  static String toTitleCase(String input) {
    if (input.isEmpty) return '';
    return input.split(' ').map((word) {
      if (word.isEmpty) return '';
      return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
    }).join(' ');
  }

  /// Formatage des Adresses
  static String formatAddress(String street, String city, String country,
      {String postalCode = ''}) {
    final address = StringBuffer();
    address.write(street);
    if (city.isNotEmpty) address.write(', $city');
    if (country.isNotEmpty) address.write(', $country');
    if (postalCode.isNotEmpty) address.write(' - $postalCode');
    return address.toString();
  }

  /// Ajout de Préfixe aux URL
  static String formatUrl(String url) {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      return 'https://$url';
    }
    return url;
  }

  /// Validation d'une adresse e-mail
  static bool isValidEmail(String email) {
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return regex.hasMatch(email);
  }

  /// Validation d'une URL
  static bool isValidUrl(String url) {
    final regex = RegExp(
      r'^(https?:\/\/)' // Doit commencer par http:// ou https://
      r'([a-zA-Z0-9\-_]+\.)+[a-zA-Z]{2,}' // Domaine (ex. example.com)
      r'(:\d+)?(\/[^\s]*)?$', // Port optionnel et chemin optionnel
    );
    return regex.hasMatch(url);
  }

  /// Extraction du domaine d'un e-mail
  static String extractEmailDomain(String email) {
    if (isValidEmail(email)) {
      return email.split('@').last;
    }
    return "Adresse e-mail invalide";
  }

  /// Extraction de l'extension d'un fichier
  static String getFileExtension(String fileName) {
    if (fileName.contains('.')) {
      return fileName.split('.').last;
    }
    return "Aucune extension détectée";
  }

  /// Validation d'un mot de passe sécurisé
  static bool isValidPassword(String password, {int minLength = 8}) {
    if (password.length < minLength) return false;
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasDigits = password.contains(RegExp(r'\d'));
    final hasSpecialChars =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    return hasUppercase && hasLowercase && hasDigits && hasSpecialChars;
  }

  /// Formatage JSON en texte lisible
  static String formatJson(String jsonString) {
    try {
      final decoded = json.decode(jsonString);
      final prettyJson = JsonEncoder.withIndent('  ').convert(decoded);
      return prettyJson;
    } catch (e) {
      return "JSON invalide";
    }
  }

  static String compressString(String input) {
    return base64Encode(utf8.encode(input));
  }

  static String decompressString(String input) {
    return utf8.decode(base64Decode(input));
  }

  static List<String> extractHashtags(String text) {
    return RegExp(r'#\w+').allMatches(text).map((m) => m.group(0)!).toList();
  }

  static String formatFileSize(int bytes) {
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    int i = 0;
    double size = bytes.toDouble();
    while (size >= 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }
    return '${size.toStringAsFixed(1)} ${suffixes[i]}';
  }

  static String generatePassword({int length = 12}) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()';
    final rand = Random();
    return List.generate(length, (index) => chars[rand.nextInt(chars.length)])
        .join();
  }
}
