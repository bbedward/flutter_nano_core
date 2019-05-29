## [1.1.4] - May 29th, 2019

* Add some validation methods to NanoMnemonics
* Add NanoCrypt class which encrypts/decrypts a seed using a basic pbkdf2 derivator and AES

## [1.1.3] - May 23rd, 2019

* Added NanoMnemomics class for turning a seed/private key into a 24-word list and back. Check tests for usage.

## [1.1.2] - May 8th, 2019

**IMPORTANT**

* An important fix was added to public key derivation. Keys were being generated incorrectly on compiled code, on 32-bit platforms after the Dart 2.3/Flutter 1.5 update.

## [1.1.1] - May 7th, 2019

* Fix some Unit tests

## [1.1.0] - April 17th, 2019

**BREAKING**
Switch from xrb_ to nano_ prefix

## [1.0.4] - February 20th, 2019

* Add license

## [1.0.3] - February 20th, 2019

* Switch to official pointycastle releases

## [1.0.2] - February 1st, 2019

* Switch to xrb_ prefixes, some popular nano apps still don't support nano_ ones

## [1.0.1] - January 17th, 2019

* Format everything and fix all of the flutter package warnings and suggestions

## [1.0.0] - January 3rd, 2019

* Initial Release
