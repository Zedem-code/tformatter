## 0.2.1

### Fixed

- Cursor issue in CurrencyInputFormatter.

## 0.2.0

### Added

- `isValidIp`: Validates if a strings is a valid IPv4 or IPv6
  - Supports both IPv4 (e.g., `192.168.0.1`) and IPv6 (e.g., `2001:0db8:85a3:0000:0000:8a2e:0370:7334`).
  - Returns `true` for valid IP addresses and `false` otherwise.
- `extractMentions`: Extracts all mentions (e.g., `@username`) from a given text.
  - Returns a list of all mentions found in the input text.
  - If no mentions are found, an empty list returned.
- `generateLoremIpsum`: Generate a lorem ipsum text.
  - Accepts an optional `wordCount` parameter to specify the number of words (default: 50).
  - Returns a random string of dummy text.
- `generateUniqueId`: Generates a random unique identifier.
  - Accepts an optional `length` parameter to specify the ID length (default: 16).
  - Returns a string containing random alphanumeric characters.

### Improved

- Enhanced the documentation for new methods with detailled examples and use cases.

## 0.1.0

### Added

- New `getCardType` to detect credit card types.
- Validation for credit card numbers using Luhn's algorithm.

### Fixed

- Cursor issue in CurrencyInputFormatter.
- Correctly handles parentheses in masks.

## 0.0.1

- TODO: Describe initial release.
