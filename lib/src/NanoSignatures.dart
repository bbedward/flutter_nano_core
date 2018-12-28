import 'package:flutter_nano_core/flutter_nano_core.dart';

class NanoSignatures {
  static String signBlock(String hash, String privKey) {
    var keyPair = Signature.keyPair_fromSecretKey(NanoHelpers.hexToBytes(privKey));
    var signer = Signature(keyPair.publicKey, keyPair.secretKey);
    return NanoHelpers.byteToHex(signer.detached(NanoHelpers.hexToBytes(hash)));
  }
}