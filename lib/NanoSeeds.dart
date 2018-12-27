library flutter_nano_core.nanoseeds;

import 'dart:math';

class NanoSeeds {
  // Returns true if a seed is valid, false otherwise
  static bool isValidSeed(String seed) {
    // Ensure seed is 64 characters long
    if (seed == null || seed.length != 64) {
      return false;
    }
    // Ensure seed only contains hex characters, 0-9;A-F
    var hexChars = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a',
    'b', 'c', 'd', 'e', 'f', 'A', 'B', 'C', 'D', 'E', 'F'];
    for (int i = 0; i < seed.length; i++) {
      if (!hexChars.contains(seed[i])) {
        return false;
      }
    }
    return true;
  }

  static String generateSeed() {
    String result = ""; // Resulting seed when done
    String chars = "abcdef0123456789"; // Characters a seed may contain
    var rng = new Random.secure();
    for (int i = 0; i < 64; i ++) {
      result += chars[rng.nextInt(chars.length)];
    }
    return result.toUpperCase();
  }
}
