import 'dart:math';
import 'package:flutter_nano_core/flutter_nano_core.dart';

class NanoSeeds {
  // Returns true if a seed is valid, false otherwise
  static bool isValidSeed(String seed) {
    // Ensure seed is 64 characters long
    if (seed == null || seed.length != 64) {
      return false;
    }
    // Ensure seed only contains hex characters, 0-9;A-F
    return NanoHelpers.isHexString(seed);
  }

  static String generateSeed() {
    String result = ""; // Resulting seed when done
    String chars = "abcdef0123456789"; // Characters a seed may contain
    var rng = new Random.secure();
    for (int i = 0; i < 64; i++) {
      result += chars[rng.nextInt(chars.length)];
    }
    return result.toUpperCase();
  }
}
