import 'package:flutter_nano_core/flutter_nano_core.dart';

class NanoKeys {
  static String seedToPrivate(String seed, int index) {
    assert(NanoSeeds.isValidSeed(seed));
    assert(index >= 0);
    return NanoHelpers.byteToHex(Hashes.digest256(
            [NanoHelpers.hexToBytes(seed), NanoHelpers.intToBytes(index, 4)]))
        .toUpperCase();
  }

  static String createPublicKey(String privateKey) {
    assert(NanoSeeds.isValidSeed(privateKey));
    return NanoHelpers.byteToHex(
        RaiBlocks.pkFromSecret(NanoHelpers.hexToBytes(privateKey)));
  }
}
