import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_nano_core/src/NanoHelpers.dart';
import 'package:flutter_nano_core/src/encrypt/aes/aes_cbcpkcs7.dart';
import 'package:flutter_nano_core/src/encrypt/kdf.dart';
import 'package:flutter_nano_core/src/encrypt/model/key_iv.dart';

/// Utility for encrypting and decrypting a nano seed
class NanoCrypt {
  /// Decrypts a private key/seed
  static Uint8List decrypt(dynamic value, String password) {
    Uint8List valBytes;
    if (value is String) {
      valBytes = NanoHelpers.hexToBytes(value);
    } else if (value is Uint8List) {
      valBytes = value;
    } else {
      throw Exception('Seed should be a string or uint8list');
    }

    Uint8List salt = valBytes.sublist(8, 16);
    KeyIV key = KDF.deriveKey(password, salt: salt);

    // Decrypt
    Uint8List encData = valBytes.sublist(16);

    return AesCbcPkcs7.decrypt(encData, key: key.key, iv: key.iv);
  }

  /// Encrypts a private key/seed
  static Uint8List encrypt(dynamic seed, String password) {
    Uint8List seedBytes;
    if (seed is String) {
      seedBytes = NanoHelpers.hexToBytes(seed);
    } else if (seed is Uint8List) {
      seedBytes = seed;
    } else {
      throw Exception('Seed should be a string or uint8list');
    }

    // Generate a random salt
    Uint8List salt = Uint8List(8);
    Random rng = Random.secure();
    for (int i = 0; i < 8; i++) {
      salt[i] = rng.nextInt(255);
    }

    KeyIV keyInfo = KDF.deriveKey(password, salt: salt);

    Uint8List seedEncrypted = AesCbcPkcs7.encrypt(seedBytes, key: keyInfo.key, iv: keyInfo.iv);

    return NanoHelpers.concat([NanoHelpers.stringToBytesUtf8("Salted__"), salt, seedEncrypted]);
  }
}