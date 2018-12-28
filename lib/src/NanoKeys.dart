import 'dart:typed_data' show Uint8List;
import 'package:flutter_nano_core/flutter_nano_core.dart';

class NanoKeys {
  static String seedToPrivate(String seed, int index) {
    assert(NanoSeeds.isValidSeed(seed));
    assert(index >= 0);
    return NanoHelpers.byteToHex(Hashes.digest256([NanoHelpers.hexToBytes(seed), Hashes.intToUint8List(index, 4)])).toUpperCase();
  }

  static String createPublicKey(String privateKey) {
    assert(NanoSeeds.isValidSeed(privateKey));
    return NanoHelpers.byteToHex(Signature.keyPair_fromSecretKey(NanoHelpers.hexToBytes(privateKey)).publicKey);
  }
}