import 'package:bip39/bip39.dart' as bip39;

import 'package:flutter_nano_core/src/NanoSeeds.dart';

class NanoMnemomics {
  /// Converts a nano seed to a 24-word mnemonic word list
  static List<String> seedToMnemonic(String seed) {
    if (!NanoSeeds.isValidSeed(seed)) {
      throw Exception('Invalid Seed');
    }
    String words = bip39.entropyToMnemonic(seed);
    return words.split(' ');
  }

  /// Convert a 24-word mnemonic word list to a nano seed
  static String mnemonicListToSeed(List<String> words) {
    if (words.length != 24) {
      throw Exception('Expected a 24-word list, got a ${words.length} list');
    }
    return bip39.mnemonicToEntropy(words.join(' ')).toUpperCase();
  }
}