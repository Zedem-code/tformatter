import 'dart:convert';
import 'dart:math';

import 'package:intl/intl.dart';

import 'translation/translation.dart';

class TFormatters {
  /// Formats a phone number based on a provided mask.
  ///
  /// The mask define the structure of  the formatted number
  /// Use `#` to represent digits in the phone number
  ///
  /// Example masks:
  /// - `(###) ###-####`
  /// - `+### (###)-###-###`
  ///
  /// If the input contains non numeric characters, they are removed before formatting.
  ///
  /// ### Parameters:
  /// - [phoneNumber]: The phone number to be formatted. It should contain digit only.
  /// - [mask]: The mask defining the desire format.
  ///
  /// ### Returns:
  /// A formatted number as String
  ///
  /// ### Example:
  /// ```dart
  /// final formatted=TFormatters.formatPhoneNumber("0123456789","(#) ###-###-###");
  /// print(formatted); //Output: "(0) 123-456-789"
  /// ```
  static String formatPhoneNumber(String phoneNumber, String mask) {
    if (phoneNumber.isEmpty) return "Numéro invalide";

    final digits = phoneNumber.replaceAll(RegExp(r'\D'), '');
    int digitIndex = 0;
    String formattedNumber = '';

    for (int i = 0; i < mask.length; i++) {
      if (digitIndex >= digits.length) break;

      if (mask[i] == '#') {
        formattedNumber += digits[digitIndex];
        digitIndex++;
      } else {
        formattedNumber += mask[i];
      }
    }

    return formattedNumber;
  }

  /// Formats a [DateTime] object into a string based on the specified pattern and locale.
  ///
  /// The [pattern] defines the format of the date. For example:
  /// - `'yyyy-MM-dd'` (default): Formats the date as "2025-01-08"
  /// - `'dd-MM-yyyy'`: Formats the date as "08-01-2025"
  ///
  /// The [locale] determines the language/region-specific formatting. For example:
  /// - `'en_US'` (default): Formats the date for US English.
  /// - `'fr_FR'`: Formats the date French
  ///
  /// If the provided [pattern] or [locale] is invalid, the method returns `'Date invalide'`.
  ///
  /// ### Parameters:
  /// - [date]: The [DateTime] object to format.
  /// - [pattern] (optional): A string representing the desired format. Default is `'yyyy-MM-dd'`.
  /// - [locale] (optional): A string specifying the locale for the date formatting. Default is `'en_US'`.
  ///
  /// ### Returns:
  /// A formatted date string based on the given pattern and locale, or `'Date invalide'` if an error occurs.
  ///
  /// ### Example:
  /// ```dart
  ///
  /// final now = DateTime.now()
  /// print(TFormatters.formatDate(now));//Output:2025-01-08
  ///
  /// print(TFormatters.formatDate(now, pattern:'dd/MM/yyyy')); //Output:"08/01/2025"
  ///```
  static String formatDate(DateTime date,
      {String pattern = 'yyyy-MM-dd', String locale = 'en_US'}) {
    try {
      return DateFormat(pattern, locale).format(date);
    } catch (e) {
      return "Date invalide";
    }
  }

  /// Formats the given [amount] as currency string based on the specified [locale] and [currencySymbol].
  ///
  /// The [locale] determines the language and region-specific formatting rules, such as
  /// the placement of the currency symbol and the use of decimal separators.
  /// The [currencySymbol] defines the symbol to be used for the currency (e.g, `$`, `€`, `₹`)
  ///
  /// ### Parameters:
  /// - [amount] : The numeric value to format as currency. It can be positive or negative.
  /// - [locale] (optional): A string specifying the locale formatting. Default is `'en_US'`.
  /// - [currencySymbol] (optional): A string specifying a currency symbol. Default is `'$'`
  ///
  /// ### Returns:
  /// A formatted string, or `'Montant invalide'` if an error occurs.
  ///
  /// ### Examples:
  /// ```dart
  /// final value=1234.56;
  /// print(TFormatters.formatCurrency(value)); //Output:$1,234.56
  ///
  /// print(TFormatters.formatCurrency(value), locale:'fr_FR', currencySymbol:'€'); //Output: "1 234,56 €"
  /// ```
  static String formatCurrency(double amount,
      {String locale = 'en_US', String currencySymbol = '\$'}) {
    try {
      return NumberFormat.currency(locale: locale, symbol: currencySymbol)
          .format(amount);
    } catch (e) {
      return "Montant invalide";
    }
  }

  /// Formats a given [Duration] into a string.
  ///
  /// This method converts the [duration] into its equivalent in hours, minutes and seconds.
  ///
  /// ### Parameters:
  /// - [duration] : The duration object to format.
  ///
  /// ### Returns:
  /// A String representation of the duration in the format `Xh Ym Zs`.
  ///
  /// ### Example:
  /// ```dart
  /// final duration = Duration(hours:1, minutes:30, seconds:50)
  /// print(TFormatters.formatDuration(duration)); //Output: "1h 30m 50s"
  /// ```
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    return '${hours}h ${minutes}m ${seconds}s';
  }

  /// Calculate the difference between two dates and returns it as a human-readable string.
  ///
  /// The difference is expressed in the largest applicable unit (years, months, weeks or days):
  /// - If the difference is greater than or equal to 365 days, it is shown in years.
  /// - if the difference is greater than or equal to 30 days, it is shown in months.
  /// - If the difference is greater than or equal to 7 days, it is shown in weeks,
  /// - Otherwise, it shown in days.
  ///
  /// ### Parameters:
  /// - [startDate] : The earlier date
  /// - [endDate] : The later date
  /// - [locale] (optional): Determines the language. Default is `'en'`
  ///
  /// ### Returns:
  /// A string representation of the difference between the two dates,
  /// in years, months, weeks or days.
  ///
  /// ### Example:
  /// ```dart
  /// final startDate=DateTime(2020, 1, 1);
  /// final endDate = DateTime(2025, 1, 1);
  /// print(TFormatters.dateDifference(startDate,endDate,locale:'fr')); //Output: "5 ans"
  /// ```
  static String dateDifference(DateTime startDate, DateTime endDate,
      {String locale = 'en'}) {
    final words = translations[locale] ?? translations['en'];

    final duration = endDate.difference(startDate);
    if (duration.inDays >= 365) {
      final years = (duration.inDays / 365).truncate();
      return '$years ${years > 1 ? words!['years'] : words!['year']}';
    } else if (duration.inDays >= 30) {
      final months = (duration.inDays / 30).truncate();
      return '$months ${months > 1 ? words!['months'] : words!['month']}';
    } else if (duration.inDays >= 7) {
      final weeks = (duration.inDays / 7).truncate();
      return '$weeks ${weeks > 1 ? words!['weeks'] : words!['week']}';
    } else {
      final days = duration.inDays;
      return '$days ${days > 1 ? words!['days'] : words!['day']}';
    }
  }

  /// Returns a human-readable string representing how much time has passed since a given date.
  ///
  /// The method calculates the difference between the current time and the given [date]
  /// and express it in the largest applicable unit:
  /// - Days: If more than 1 day has passed, it returns the number of days.
  /// - Hours: If more than 1 hour has passed, it returns the number of hours.
  /// - Minutes: If more than 1 minute has passed, it returns the number of minutes.
  /// - Just now: If less than 1 minute has passed.
  ///
  /// ### Parameters:
  /// - [date] : The past date to calculate the time difference from.
  /// - [locale] (optional) : The locale for the output. Default is `'en'`
  ///
  /// ### Returns:
  /// A human-readable string representing the time elapsed since the given [date]
  ///
  /// ### Example:
  /// ```dart
  /// final now = DateTime.now();
  /// final hourAgo = now.subtract(Duration(hours: 2));
  /// print(TFormatters.timeAgo(hourAgo)); //Output: "2 hours"
  /// ```
  static String timeAgo(DateTime date, {String locale = 'en'}) {
    final words = translations[locale] ?? translations['en'];
    final now = DateTime.now();
    final duration = now.difference(date);
    if (duration.inDays >= 1) {
      final unit = duration.inDays > 1 ? words!['days'] : words!['day'];
      return '${duration.inDays} $unit';
    }
    if (duration.inHours >= 1) {
      final unit = duration.inHours > 1 ? words!['hours'] : words!['hour'];
      return '${duration.inHours} $unit';
    }
    if (duration.inMinutes >= 1) {
      final unit =
          duration.inMinutes > 1 ? words!['minutes'] : words!['minute'];
      return '${duration.inMinutes} $unit';
    }
    return words!['just_now']!;
  }

  /// Formats a number into a shortened human-readable string with units like "k" for thousands or "M" for millions or "B" for billions.
  ///
  /// ### Behavior
  /// - Numbers greater than or equal to 1,000,000,000,000 are represented in trillions with the suffix "T".
  /// - Numbers greater than or equal to 1,000,000,000 are represented in billions with suffix "B".
  /// - Numbers greater than or equal to 1,000,000 are represented in millions with suffx "M".
  /// - Numbers greater than or equal to 1,000 are represented in thousands with suffix "k".
  /// - Smaller numbers are displayed as is, without a suffix.
  ///
  /// The number is rounded to one decimal place for thousands and millions, and integers for smaller values.
  ///
  /// ### Parameters:
  /// - [value] : The numeric value to be formatted.
  /// - [decimals] (optional) : The number of decimal places to include in the formatted output. Default is `1`.
  ///
  /// ### Returns :
  /// A string representation of the number in a shortened format with appropriete units.
  ///
  /// ### Example :
  /// ```dart
  /// print(TFormatters.formatNumberShortcut(234000)); //Output: "23.4k"
  /// ```
  static String formatNumberShortcut(double value, {int decimals = 1}) {
    if (value >= 1000000000000) {
      return '${(value / 1000000000000).toStringAsFixed(decimals)}T';
    } else if (value >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(decimals)}B';
    } else if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(decimals)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(decimals)}k';
    }

    return value.toStringAsFixed(decimals == 0 ? 0 : decimals);
  }

  /// Formats a list of strings into a human-readable string with proper separators.
  ///
  /// This method takes a list of strings [items] and formats it as a natural language string:
  /// - If the list is empty, it return an empty string.
  /// - If the list contain a single item, it return that item.
  /// - If the list contain multiple items, it joins them with commas (`,`), and the last item is preceded by [conjuction].
  ///
  /// ### Parameters:
  /// -[items] : A list of string to format.
  /// -[conjuction] (optional) : The word used to join the last item in the list. Default is "and"
  ///
  /// ### Returns:
  /// A formatted string where items are separated by commas, and the last item is joined with `"and`".
  ///
  /// ### Example
  /// ```dart
  /// final persons=['Alice','Bob','Charlie'];
  /// print(TFormatters.formatList(persons)); //Output: "Alice,Bob and Charlie"
  /// ```
  static String formatList(List<String> items, {String conjuction = 'and'}) {
    if (items.isEmpty) return '';
    if (items.length == 1) return items.first;
    final allButLast = items.sublist(0, items.length - 1);
    return '${allButLast.join(', ')} $conjuction ${items.last}';
  }

  /// Converts a [DateTime] object from one time zone to another using their respective offsets.
  ///
  /// This methode takes a [DateTime] object in the source time zone, subtracts the [fromoffset]
  /// (offset of the source time zone), and adds the [toOffset] (offset of the target time zone) to
  /// return the corresponding [DateTime] in the target time zone
  ///
  /// ### Parameters:
  /// - [date] : The [DateTime] object to be converted. It is assumed to be the source time zone.
  /// - [fromOffset] : The [Duration] offset of the source time zone (e.g., `Duration(hours: -5)` for UTC-5).
  /// - [toOffset] : The [Duration] offset of the target time zone (e.g., `Duration(hours: 1)` for UTC+1).
  ///
  /// ### Returns:
  /// A [DateTime] object adjust to the target time zone.
  ///
  /// ### Example:
  /// ```dart
  /// final dateInNewYork=DateTime(2025,1,9,12,0); //12:00 PM in New York
  /// final convertedToParis=TFormatters.convertTimeZone(dateInNewYork, Duration(hours:-5), Duration(hours:1));
  /// print(convertedToParis);//Output: "2025-01-09 18:00:00"
  /// ```
  static DateTime convertTimeZone(
      DateTime date, Duration fromOffset, Duration toOffset) {
    final utcDate = date.subtract(fromOffset);

    final targetDate = utcDate.add(toOffset);

    return targetDate;
  }

  /// Validates a phone number based on a regular expression pattern.
  ///
  /// This method checks wether the given [phoneNumber] matches the following rules:
  /// - The number may start with the optional `+`.
  /// - It must contain only digits (0-9).
  /// - The lenght must be between 10 and 13 characters, inclusive.
  ///
  /// ### Parameters:
  /// [phoneNumber] : The phone number to validate as string
  ///
  /// ### Returns:
  /// A boolean value:
  /// - `true` if the phone number is valid.
  /// - `false` otherwise.
  ///
  /// ### Example:
  /// ```dart
  /// print(TFormatters.isValidPhone(+12345678901)); //Output: true
  /// ```
  static bool isValidPhoneNumber(String phoneNumber) {
    final regex = RegExp(r'^\+?[0-9]{10,13}$');
    return regex.hasMatch(phoneNumber);
  }

  /// Validate the date.
  ///
  /// ### Parameters:
  /// [date] : The date in string to format
  ///
  /// ### Returns:
  /// - `true`  If is valid date.
  /// - `false` Otherwise.
  ///
  /// ### Example:
  /// ```dart
  /// print(TFormatters.isValidDate('2025-01-09 18:00:00'));//Output: true
  /// ```
  static bool isValidDate(String date) {
    try {
      DateTime.parse(date);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Formats a numeric value as percentage string with a specified number of decimal places.
  ///
  /// This method take a [value] (fraction between 0 and 1) and converts it into a percentage by multiplying it by 100.
  /// If the [value] is greater than 1, it is capped at 100%.
  /// The resulting percentage is formatted as a string with a fixed number of decimal places,
  /// as specified by [decimalPlaces].
  ///
  /// ### Parameters:
  /// - [value] : The numeric value to format as percentage, Typically, this is a fraction (e.g., 0.75 for 75%).
  /// - [decimalPlaces] (optional): The number of decimal places to include in the formatted percentage. Default is `2`.
  ///
  /// ### Returns:
  /// A String representation of the percentage, followed by the `%` symbol.
  /// if the [value] is greater than 1, it returns `100.00%`
  ///
  /// ### Example:
  /// ```dart
  /// print(TFormatters.formatPercentage(0.75)); //Output: "75.00%"
  /// ```
  static String formatPercentage(double value, {int decimalPlaces = 2}) {
    if (value > 1) return '100.00%';
    final percentage = (value * 100).toStringAsFixed(decimalPlaces);
    return '$percentage%';
  }

  /// Generate initials from a [fullName]
  ///
  /// This method takes a [fullName], splits it into words, and extracts the first letter
  /// of each word to create a string of initials.
  /// - The initials are always in uppercase.
  /// - The result is limited to a maximum of 2 characters  (e.g., for "John Doe", the output is "JD").
  ///
  /// ### Parametes:
  /// - [fullName] : A string representing a full name to exctract initials from.
  ///
  /// ### Returns:
  /// A string containing the initials of the full name:
  /// - If [fullName] is empty or contains only whitespace, it returns an empty string (`""`).
  /// - If [fullName] contains only one word, it returns the first letter of the word.
  /// - For multiple words, it returns the initials of the first two words.
  ///
  /// ### Example:
  /// ```dart
  /// final initials=TFormatters.generateInitials('John Doe');
  /// print(initials); //Output: "JD"
  /// print(TFormatters.generateInitials('Alice')); //Output: "A"
  /// ```
  static String generateInitials(String fullName) {
    final words = fullName.trim().split(RegExp(r'\s+'));
    if (words.isEmpty) return '';
    final initials = words
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() : '')
        .join('');
    return initials.substring(0, initials.length > 2 ? 2 : initials.length);
  }

  /// Masks sensitive data by replacing all but the last few characters with a customizable mask character.
  ///
  /// This method is commonly used to obscure sensitive information, such as credit card numbers
  /// phone numbers, or personal identifiers, while displaying the last few characters for clarity.
  /// The mask character and the number of visible characters can be customized.
  ///
  /// ### Parameters:
  /// - [data] : The string containing the sensitive data to be masked
  /// - [visibleChars] (optional) : The number of characters to keep visible at the end of the string. Default is `4`.
  /// - Must be greater than or equal to 0. Throws [ArgumentError] if negative.
  /// - [maskChar] (optional) : The character used for masking. Default is `'*'`.
  /// - Must not be empty. Throws an [ArgumentError] if empty.
  ///
  /// ### Returns:
  /// A masked string where all but the last [visibleChars], the original string is returned unmodified.
  ///
  /// ### Throws:
  /// - [ArgumentError] : If [visibleChars] is negative or if [maskChar] is empty.
  ///
  /// ### Example:
  /// ```dart
  /// final masked=TFormatters.maskSensitiveData(1234567890);
  /// print(masked); //Output: "******7890"
  /// final masked2 = TFormatters.maskSensitiveData('1234567890', visibleChars: 2);
  /// print(masked2); // Output: "********90"
  /// ```
  static String maskSensitiveData(
    String data, {
    int visibleChars = 4,
    String maskChar = '*',
  }) {
    if (visibleChars < 0) {
      throw ArgumentError('visibleChars must be greater than or equal to 0.');
    }
    if (maskChar.isEmpty) {
      throw ArgumentError('maskChar cannot be empty.');
    }

    if (data.length <= visibleChars) return data;
    return '${maskChar * (data.length - visibleChars)}${data.substring(data.length - visibleChars)}';
  }

  /// Normalizes spaces in a given string by replacing multiple consecutive spaces with
  /// a single space and trimming leading and trailing spaces.
  ///
  /// This method is useful for cleaning up user input, ensuring consistent formatting  in string
  /// by removing redundant spaces.
  ///
  /// ### Parameters:
  /// - [input] : The string to normalize.
  ///
  /// ### Returns:
  /// A string with:
  /// - All sequences of consecutive spaces replaced by a single space.
  /// - Leading and trailing spaces removed.
  ///
  /// ### Examples:
  /// ```dart
  /// final normalized1 = TFormatters.normalizeSpaces('Hello    world!   How  are you?');
  /// print(normalized1); // Output: "Hello world! How are you?"
  /// ```
  static String normalizeSpaces(String input) {
    return input.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Converts a string to title case, where the first letter of each word is capitalized
  /// and the remaining letters are in lowercase
  ///
  /// This method splits the input into words, capitalizes the first letter of each word,
  /// and converts the rest of the letters to lowercase. Words separated by spaces are processed individually.
  ///
  /// ### Parameters
  /// - [input] : The string to convert to title case
  ///
  /// ### Returns:
  /// A new string where:
  /// - Each word starts with an uppercase letter.
  /// - The remaining letters of each word are in lowercase.
  /// - If the input is empty, an empty string is returned.
  ///
  /// ### Example:
  /// ```
  /// final title1 = TFormatters.toTitleCase('hello world');
  /// print(title1); // Output: "Hello World"
  ///
  /// final title2 = TFormatters.toTitleCase('fLUtTer is awESome');
  /// print(title2); // Output: "Flutter Is Awesome"
  /// ```
  static String toTitleCase(String input) {
    if (input.isEmpty) return '';
    return input.split(' ').map((word) {
      if (word.isEmpty) return '';
      return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
    }).join(' ');
  }

  /// Formats an address by combining street, city, country, and an optional postal code  into
  /// a readable string
  ///
  /// This method constructs an address string using the provided [street],[city],[country] and [postalCode].
  /// The components are separated by commas, and the postal code (if provided) is appended with a hypen (`-`).
  ///
  /// ### Parameters:
  /// - [street] : The street address (e.g., "123 Main St"). Required.
  /// - [city] : The city name. Required but can be empty.
  /// - [country] : The country name. Required but can be empty.
  /// - [postalCode] (optional) : The postal code. Default is an empty string.
  ///
  /// ### Returns:
  /// A formatted address string combining the provided components:
  /// - If [city] or [country] are empty, they are excluded from the result.
  /// - If [postalCode] is empty, it is excluded from the result.
  ///
  /// ### Example:
  /// ```dart
  /// final address1 = TFormatters.formatAddress('123 Main St', 'Paris', 'France', postalCode: '75001');
  /// print(address1); // Output: "123 Main St, Paris, France - 75001"
  /// ```
  static String formatAddress(String street, String city, String country,
      {String postalCode = ''}) {
    final address = StringBuffer();
    address.write(street);
    if (city.isNotEmpty) address.write(', $city');
    if (country.isNotEmpty) address.write(', $country');
    if (postalCode.isNotEmpty) address.write(' - $postalCode');
    return address.toString();
  }

  /// Formats a URL by ensuring it starts with a valid protocol, and adds a default if necessary
  ///
  /// This method checks whether the given [url] starts with any protocol listed in [validProtocols].
  /// If no valid protocol is detected, it prepends  the [defaultProtocol] to the URL.
  ///
  /// ### Parameters:
  /// - [url] : The URL to format. Can be empty, in which case [defaulProtocol] is returned.
  /// - [validProtocols] (optional) : A list of allowed protocols. Default is `['http://','https://']` .
  /// - Must not be empty. Throws an [ArgumentError] if empty.
  /// - [defaultProtocol] (optional): The protocol to prepend if the [url] does not start with a valid protocol.
  /// - Default is `'https://'`.
  /// - Must follow the format `word://`. Throws an [ArgumentError] if invalid.
  ///
  /// ### Returns:
  /// A string representing the format URL:
  /// - If the [url] starts with the valid protocol, it's returned unchanged.
  /// - If the [url] does not start with a valid protocol, [defaultProtocol] is prepended.
  /// - If the [url] is empty, the [defaultProtocol] is returned.
  ///
  /// ### Throws:
  /// - [ArgumentError] : If [validProtocols] is empty.
  /// - [ArgumentError] : If [defaultProtocol] is not in the format `word://`.
  ///
  /// ### Example:
  /// ```dart
  /// final formatted1 = TFormatters.formatUrl('https://example.com');
  /// print(formatted1); // Output: "https://example.com"
  ///

  /// final formatted2 = TFormatters.formatUrl('example.com');
  /// print(formatted2); // Output: "https://example.com"
  /// ```
  static String formatUrl(
    String url, {
    List<String> validProtocols = const ['http://', 'https://'],
    String defaultProtocol = 'https://',
  }) {
    if (validProtocols.isEmpty) {
      throw ArgumentError('The validProtocols list cannot be empty.');
    }
    if (!RegExp(r'^[a-zA-Z]+://$').hasMatch(defaultProtocol)) {
      throw ArgumentError('Invalid defaultProtocol: $defaultProtocol');
    }

    if (url.isEmpty) return defaultProtocol;

    final hasValidProtocol =
        validProtocols.any((protocol) => url.startsWith(protocol));
    if (!hasValidProtocol) {
      return '$defaultProtocol$url';
    }

    return url;
  }

  /// Checks if the provided string is a valid email address.
  ///
  /// This method uses a regular expression to verify if the input conforms to the basic email format.
  /// ### Note:
  /// While this method provides a basic validation, it does not guarantee that the email address actually exists
  /// on email server.
  ///
  /// ### Parameters:
  /// - [email] : The string to be checked for email format validity.
  ///
  /// ### Returns:
  /// `true` If the input string matches a basic email format.
  /// `false` Otherwise.
  ///
  /// ### Examples:
  /// ```dart
  /// bool isValid = TFormatters.isValidEmail("test@example.com"); // true
  /// bool isInvalid = TFormatters.isValidEmail("invalid_email"); // false
  /// ```
  static bool isValidEmail(String email) {
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return regex.hasMatch(email);
  }

  /// Validates whether a given string is a valid URL.
  ///
  /// This method uses a regular expression to check if the [url] meets the following criteria:
  /// - Starts with `http://` or `https://`.
  /// - Contains a valid domain name (e.g., `example.com`).
  /// - Optionally includes a port (e.g., `:8080`).
  /// - Optionally includes a path after the domain.
  ///
  /// ### Parameters:
  /// - [url]: The string to validate as a URL.
  ///
  /// ### Returns:
  /// A boolean value:
  /// - `true` if the [url] matches the URL pattern.
  /// - `false` otherwise.
  ///
  /// ### Examples:
  /// ```dart
  /// final isValid1 = TFormatters.isValidUrl('http://example.com');
  /// print(isValid1); // Output: true
  ///
  /// final isValid2 = TFormatters.isValidUrl('https://example.com/path');
  /// print(isValid2); // Output: true
  /// ```
  static bool isValidUrl(String url) {
    final regex = RegExp(
      r'^(https?:\/\/)' // Doit commencer par http:// ou https://
      r'([a-zA-Z0-9\-_]+\.)+[a-zA-Z]{2,}' // Domaine (ex. example.com)
      r'(:\d+)?(\/[^\s]*)?$', // Port optionnel et chemin optionnel
    );
    return regex.hasMatch(url);
  }

  /// Extracts the domain part of an email address.
  ///
  /// ### Parameters:
  /// - [email] : The email address from which to extract the domain.
  ///
  /// ### Returns:
  /// - The domain part of the email address if is valid.
  /// - The string "invalid_email" if the [email] is invalid.
  ///
  /// ### Example:
  /// ```dart
  /// print(TFormatters.extractEmailDomain('test@example.com')); //Output: 'example.com'
  /// ```
  static String extractEmailDomain(String email) {
    if (isValidEmail(email)) {
      return email.split('@').last;
    }
    return "invalid_email";
  }

  /// Extracts the file extension from given file name
  ///
  /// ### Parameters:
  /// - [fileName] : The file name from which to extract the extension.
  ///
  /// ### Returns:
  /// - The file extension if it exists.
  /// - The string `No extension found` if no extension is detected.
  ///
  /// ### Example:
  /// ```dart
  /// String extension1 = TFormatters.getFileExtension("image.jpg");
  /// String extension2 = TFormatters.getFileExtension("file_without_extension");
  /// print(extension1);// "jpg"
  /// print(extension2);// "No extension found"
  /// ```
  static String getFileExtension(String fileName) {
    if (fileName.contains('.')) {
      return fileName.split('.').last;
    }
    return "No extension found";
  }

  /// Checks if a password meets specific complexity requirements.
  ///
  /// A password is considered valid if it satifies the following criteria:
  /// - **Minimum lenght:** Must be at least [minLength] characters long. By Default
  /// [minLength] is set to "8".
  /// - **Uppercase character:** Must contain at least one uppercase letter.
  /// - **Lowercase character:** Must contain at least one lowercase letter.
  /// - **Digit:** Must contain at least one digit.
  /// - **Special character:** Must contain at least one special character from the set: `!@#$%^&*(),.?":{}|<>`.
  ///
  /// ### Parameters:
  /// - [password] : The password string to be validated.
  /// - [minLength] (optional) : The minimum required lenght of the password.
  ///
  /// ### Returns:
  /// `true` If the password meets all the specified criteria.
  /// `false` otherwise.
  ///
  /// ### Example:
  /// ```dart
  /// print(TFormatters.isValidPassword('StrongP@ssw0rd'));//Output:true
  /// print(TFormatters.isValidPassword('weakpass'));//Output:false
  /// ```
  static bool isValidPassword(String password, {int minLength = 8}) {
    if (password.length < minLength) return false;
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasDigits = password.contains(RegExp(r'\d'));
    final hasSpecialChars =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    return hasUppercase && hasLowercase && hasDigits && hasSpecialChars;
  }

  /// Formats a JSON string into human-readable, indented format.
  ///
  /// This method takes a JSON string, decodes it into a Dart object, and then re-encodes it
  /// with indentation for improved readability. If the input is not a valid JSON string,
  /// it returns `'JSON invalide'`.
  ///
  /// ### Parameters:
  /// - [jsonString]: The JSON string to format.
  ///
  /// ### Returns:
  /// A formatted JSON string with indentation for better readability.
  /// If [jsonString] is not a valid JSON string, the method returns `'JSON invalide'`.
  ///
  /// ### Examples:
  /// ```dart
  /// // Example 1: Format a valid JSON string
  /// final jsonString = '{"name":"Alice","age":30,"skills":["Dart","Flutter"]}';
  /// final formattedJson = TFormatters.formatJson(jsonString);
  /// print(formattedJson);// Output:
  ///
  ///  {
  ///    "name": "Alice",
  ///    "age": 30,
  ///    "skills": [
  ///      "Dart",
  ///      "Flutter"
  ///    ]
  ///  }
  ///
  /// ```
  static String formatJson(String jsonString) {
    try {
      final decoded = json.decode(jsonString);
      final prettyJson = JsonEncoder.withIndent('  ').convert(decoded);
      return prettyJson;
    } catch (e) {
      return "JSON invalide";
    }
  }

  /// Compresses  a string by encoding it in Base64 format.
  ///
  /// This method converts the given [input] string into a Base64-encoded string.
  /// It first encodes the input string to UTF-8, the applies the Base64 encoding.
  /// The resulting string is typically used for compact data representation or safe data transfer.
  ///
  /// ### Parameters:
  /// - [input] : The string to compress
  ///
  /// ### Returns:
  /// A Base64-encoded string representing the compressed version of the [input].
  ///
  /// ### Examples:
  /// ```dart
  /// final compressed1 = TFormatters.compressString('Hello, World!');
  /// print(compressed1); // Output: "SGVsbG8sIFdvcmxkIQ=="
  ///
  /// final compressed2 = TFormatters.compressString('Flutter is amazing!');
  /// print(compressed2); // Output: "Rmx1dHRlciBpcyBhbWF6aW5nIQ=="
  ///```
  static String compressString(String input) {
    return base64Encode(utf8.encode(input));
  }

  /// Decompresses a Base64-encoded string back into a human-readable string.
  ///
  /// This method decodes a given [input] string that is in Base64 format and converts it back into
  /// its original text representation by encoding it to UTF-8.
  ///
  /// ### Parameters:
  /// -[input] : The Base64-encoded string to decompress.
  ///
  /// ### Returns:
  /// The original human-readable string represented by the [input].
  ///
  ///### Throws:
  /// - [FormatException]: If the [input] is not a valid Base64-encoded string.
  ///
  /// ### Examples:
  /// ```dart
  /// final decompressed1 = TFormatters.decompressString('SGVsbG8sIFdvcmxkIQ==');
  /// print(decompressed1); // Output: "Hello, World!"
  ///
  /// final decompressed2 = TFormatters.decompressString('Rmx1dHRlciBpcyBhbWF6aW5nIQ==');
  /// print(decompressed2); // Output: "Flutter is amazing!"
  ///```
  static String decompressString(String input) {
    return utf8.decode(base64Decode(input));
  }

  /// Extracts all hashtags from a given text
  ///
  /// This method searches the [text] for hashtags (words starting with `#`) and returns them as list of strings.
  /// A hashtag is defined as a `#` followed by one or more alphanumeric characters or underscrores (`\w+`).
  ///
  /// ### Parameters:
  /// - [text] : The input string containing potential hashtags.
  ///
  /// ### Returns:
  /// A list of strings, where each string is a hashtag extracted from the [text].
  /// If no hashtags are found, an empty list is returned.
  ///
  /// ### Examples:
  /// ```dart
  /// final hashtags1 = TFormatters.extractHashtags('Flutter is amazing! #flutter #dart');
  /// print(hashtags1); // Output: ["#flutter", "#dart"]
  ///
  /// final hashtags2 = TFormatters.extractHashtags('This text has no hashtags.');
  /// print(hashtags2); // Output: []
  /// ```
  static List<String> extractHashtags(String text) {
    return RegExp(r'#\w+').allMatches(text).map((m) => m.group(0)!).toList();
  }

  /// Formats a file size in bytes into a human-readable string with appropriate units.
  ///
  /// This method converts a size in bytes into larger units (B,KB, MB, GB, TB) as needed.
  /// The formatted size includes one decimal place and the corresponding unit.
  /// It validates the input to ensure the size is non-negative integer.
  ///
  /// ### Parameter:
  /// - [bytes] : The file size in bytes as a non-negative integer.
  ///
  /// ### Returns:
  /// A string representing the formatted file size, including one decimal place and the unit:
  /// - `'B'` for bytes.
  /// - `'KB'` for kilobytes.
  /// - `'MB'` for megabytes.
  /// - `'GB'` for gigabytes.
  /// - `'TB'` for terabytes.
  ///
  /// ### Throws:
  /// - [ArgumentError] If [bytes] is a negative value.
  ///
  /// ### Examples:
  /// ```dart
  /// final size1 = TFormatters.formatFileSize(512);
  /// print(size1); // Output: "512.0 B"
  ///
  /// final size2 = TFormatters.formatFileSize(2048);
  /// print(size2); // Output: "2.0 KB"
  /// ```
  static String formatFileSize(int bytes) {
    if (bytes < 0) {
      throw ArgumentError('Bytes must be a non-negative integer.');
    }

    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    int i = 0;
    double size = bytes.toDouble();
    while (size >= 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }
    return '${size.toStringAsFixed(1)} ${suffixes[i]}';
  }

  /// Generates a random password with specified length
  ///
  /// This method creates a secure password by randomly selecting characters from a
  /// predefined set of letters, numbers and special symbol. The length of the password
  /// can be customized using [length] parameter.
  ///
  /// ### Parameter:
  /// - [length] (optional): The length of generated password. Default is `12`.
  ///  - Must not be 0. Throws an [ArgumentError] if 0.
  ///
  /// ### Returns:
  /// A randomly generated password as string, consisting of:
  /// - Lowercase letters (`a-z`).
  /// - Uppercase letters (`A-Z`).
  /// - Numbers (`0-9`).
  /// - Specials symbols (`!@#\$%^&*()`).
  ///
  /// ### Throws
  /// - [ArgumentError] If the length is 0.
  ///
  /// ### Example:
  /// ``` dart
  ///  final password1 = TFormatters.generatePassword();
  /// print(password1); // Output: A random 12-character password
  /// ```
  static String generatePassword({int length = 12}) {
    if (length == 0) throw ArgumentError('The length must not be 0');
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()';
    final rand = Random();
    return List.generate(length, (index) => chars[rand.nextInt(chars.length)])
        .join();
  }

  /// Validates a credit card number using the Luhn algorithm.
  ///
  /// This method checks whether the provided [cardNumber] is a valid credit card number.
  /// It removes any whitespace from the input, verifies the length, and applies the Luhn algorithm
  /// to determine the validity of the number.
  ///
  /// ### Parameters:
  /// - [cardNumber] : The credit card number as string. It can contain spaces for readability (e.g., "1234 5678 9012 3456").
  ///
  /// ### Returns:
  /// A boolean value:
  /// -`true` If the [cardNumber] is valid according to the Luhn algorithm.
  /// - `false` Otherwise.
  ///
  /// ### Example:
  /// ```dart
  /// final isValid1 = TFormatters.isValidCreditCard('4539 1488 0343 6467');
  /// print(isValid1); // Output: true
  ///
  /// final isValid2 = TFormatters.isValidCreditCard('1234 5678 9012 3456');
  /// print(isValid2); // Output: false
  /// ```
  static bool isValidCreditCard(String cardNumber) {
    cardNumber = cardNumber.replaceAll(RegExp(r'\s+'), '');
    if (!RegExp(r'^\d+$').hasMatch(cardNumber)) return false;
    if (cardNumber.length < 13 || cardNumber.length > 19) return false;

    int sum = 0;
    bool alternate = false;
    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int n = int.parse(cardNumber[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) n -= 9;
      }
      sum += n;
      alternate = !alternate;
    }
    return sum % 10 == 0;
  }

  /// Detects the type of data in given input string.
  ///
  /// This method analyzes the [input] and determines its data type based on specific validations rules:
  /// - If the [input] is a valid email address, it returns `'Email'`.
  /// - If the [input] is a valid URL, it returns `'URL'`.
  /// - If the [input] is a valid phone number, it returns `'Phone Number'`.
  /// - If none of the above match, it returns `'Unknown'`.
  ///
  /// ### Parameter:
  /// - [input] : The string to analyze and classify.
  ///
  /// ### Returns:
  /// A string representing the detected data type:
  /// - `'Email'` for valid email addresses.
  /// - `'URL'` for valid URLs.
  /// - `'Phone Number'` for valid phone numbers.
  /// - `'Unknown'` if the [input] does not match any known type.
  ///
  /// ### Examples:
  /// ```dart
  /// final type1 = TFormatters.detectDataType('test@example.com');
  /// print(type1); // Output: "Email"
  ///
  /// final type2 = TFormatters.detectDataType('https://example.com');
  /// print(type2); // Output: "URL"
  /// ```
  static String detectDataType(String input) {
    if (isValidEmail(input)) return 'Email';
    if (isValidUrl(input)) return 'URL';
    if (isValidPhoneNumber(input)) return 'Phone Number';
    return 'Unknown';
  }

  /// Identifies the type of credit card based on its number.
  ///
  /// This method uses pattern and prefixes to determine the type of card.
  /// It supports popular card types like Visa, Mastercard, American Express and Discover.
  ///
  /// ### Parameters:
  /// - [cardNumber] : The credit card number as a string. It can contain non-numeric characters like spaces or dashes.
  ///
  /// ### Returns:
  /// A string representing the type of card:
  /// - `'Visa'` If the card number starts with `4`.
  /// - `'MasterCard'` If the card number matches the range `51` to `55`.
  /// - `'American Express'` If the card number starts with `34` or `37`.
  /// - `'Discover'` If the card number starts with `6`.
  /// - `'Unknown'` If the card number does not match any known pattern.
  ///
  /// ### Examples:
  ///  ```dart
  /// final cardType1 = TFormatters.getCardType('4111 1111 1111 1111');
  /// print(cardType1); // Output: "Visa"
  ///
  /// final cardType2 = TFormatters.getCardType('5500 0000 0000 0004');
  /// print(cardType2); // Output: "Mastercard"
  /// ```
  static String getCardType(String cardNumber) {
    final cleanedNumber = cardNumber.replaceAll(RegExp(r'\D'), '');
    if (cleanedNumber.startsWith('4')) return 'Visa';
    if (RegExp(r'^5[1-5]').hasMatch(cleanedNumber)) return 'Mastercard';
    if (RegExp(r'^3[47]').hasMatch(cleanedNumber)) return 'American Express';
    if (cleanedNumber.startsWith('6')) return 'Discover';
    return 'Unknown';
  }

  /// Generates a random Lorem Ipsum text with a specified number of words.
  ///
  /// This method creates a simulated text using a predefined set of words commonly used in dummy text.
  /// The [wordCount] parameter allows customization of the number of words in the generated text.
  ///
  /// ### Parameters:
  /// - [wordCount] (optional): The number of words to generate. Default is `50`.
  ///
  /// ### Returns:
  /// A string containing the generated Lorem Ipsum text.
  ///
  /// ### Throws:
  /// - [ArgumentError] If [wordCount] is negative.
  ///
  /// ### Examples:
  /// ```dart
  /// final loremDefault = TFormatters.generateLoremIpsum();
  /// print(loremDefault); // Output: A random 50-word Lorem Ipsum text.
  ///
  /// final loremCustom = TFormatters.generateLoremIpsum(wordCount: 10);
  /// print(loremCustom); // Output: A random 10-word Lorem Ipsum text.
  ///
  /// final emptyLorem = TFormatters.generateLoremIpsum(wordCount: 0);
  /// print(emptyLorem); // Output: ""
  /// ```

  static String generateLoremIpsum({int wordCount = 50}) {
    if (wordCount < 0) throw ArgumentError('wordCount must not be negative');
    const words = [
      'lorem',
      'ipsum',
      'dolor',
      'sit',
      'amet',
      'consectetur',
      'adipiscing',
      'elit',
      'sed',
      'do',
      'eiusmod',
      'tempor',
      'incididunt',
      'ut',
      'labore',
      'et',
      'dolore',
    ];
    final rand = Random();
    return List.generate(
        wordCount, (index) => words[rand.nextInt(words.length)]).join(' ');
  }

  /// Extracts all mentions (e.g., `@username`) from a given text.
  ///
  /// This method searches the [text] for mentions, defined as any word starting with `@`
  /// followed by alphanumeric characters or underscores. It returns all matches as a list.
  ///
  /// ### Parameters:
  /// - [text]: The input string containing potential mentions.
  ///
  /// ### Returns:
  /// A list of strings representing the extracted mentions.
  /// If no mentions are found, an empty list is returned.
  ///
  /// ### Examples:
  /// ```dart
  /// final mentions = TFormatters.extractMentions('Hello @Alice and @Bob!');
  /// print(mentions); // Output: ["@Alice", "@Bob"]
  ///
  /// final noMentions = TFormatters.extractMentions('This text has no mentions.');
  /// print(noMentions); // Output: []
  ///
  /// final mentionsWithSpecial = TFormatters.extractMentions('Welcome @user_name123!');
  /// print(mentionsWithSpecial); // Output: ["@user_name123"]
  ///
  /// ```

  static List<String> extractMentions(String text) {
    return RegExp(r'@\w+').allMatches(text).map((m) => m.group(0)!).toList();
  }

  /// Generates a unique identifier with a specified length.
  ///
  /// This method creates a random string consisting of alphanumeric characters (a-z, A-Z, 0-9).
  /// The [length] parameter determines the length of the generated ID.
  ///
  /// ### Parameters:
  /// - [length] (optional): The length of the unique identifier. Default is `16`.
  ///
  /// ### Returns:
  /// A string containing the randomly generated unique identifier.
  ///
  /// ### Throws:
  /// - [ArgumentError] if [length] is negative.
  ///
  /// ### Examples:
  /// ```dart
  /// final defaultId = TFormatters.generateUniqueId();
  /// print(defaultId); // Output: A random 16-character ID.
  ///
  /// final shortId = TFormatters.generateUniqueId(length: 8);
  /// print(shortId); // Output: A random 8-character ID.
  ///
  /// final longId = TFormatters.generateUniqueId(length: 32);
  /// print(longId); // Output: A random 32-character ID.
  /// ```

  static String generateUniqueId({int length = 16}) {
    if (length < 0) throw ArgumentError('The length must not be negative');
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random();
    return List.generate(length, (index) => chars[rand.nextInt(chars.length)])
        .join();
  }

  /// Validates whether a given string is a valid IP address (IPv4 or IPv6).
  ///
  /// This method checks if the [ip] string matches the format of an IPv4 or IPv6 address:
  /// - IPv4: Four groups of 1–3 digits separated by periods (e.g., `192.168.0.1`).
  /// - IPv6: Eight groups of 1–4 hexadecimal digits separated by colons (e.g., `2001:0db8:85a3:0000:0000:8a2e:0370:7334`).
  ///
  /// ### Parameters:
  /// - [ip]: The string to validate as an IP address.
  ///
  /// ### Returns:
  /// A boolean value:
  /// - `true` if the [ip] matches the format of an IPv4 or IPv6 address.
  /// - `false` otherwise.
  ///
  /// ### Examples:
  /// ```dart
  /// final isValidIPv4 = TFormatters.isValidIp('192.168.0.1');
  /// print(isValidIPv4); // Output: true
  ///
  /// final isValidIPv6 = TFormatters.isValidIp('2001:0db8:85a3:0000:0000:8a2e:0370:7334');
  /// print(isValidIPv6); // Output: true
  ///
  /// final isInvalid = TFormatters.isValidIp('999.999.999.999');
  /// print(isInvalid); // Output: false
  ///
  /// ```

  static bool isValidIp(String ip) {
    final ipv4Regex = RegExp(
      r'^(([0-9]{1,3}\.){3}[0-9]{1,3})$',
    );
    final ipv6Regex = RegExp(
      r'^(([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4})$',
    );
    return ipv4Regex.hasMatch(ip) || ipv6Regex.hasMatch(ip);
  }
}
