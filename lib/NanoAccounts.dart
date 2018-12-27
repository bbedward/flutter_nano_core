library flutter_nano_core.nanoaccounts;

import "dart:typed_data" show Uint8List;

import "package:flutter_nano_core/Hashes.dart";
import "package:flutter_nano_core/NanoAccountEncodes.dart";
import "package:flutter_nano_core/NanoAccountType.dart";
import "package:flutter_nano_core/NanoHelpers.dart";

class NanoAccounts {
  static NanoAccountEncodes encoder = new NanoAccountEncodes();

  static String createAccount(int accountType, String publicKey) {
    assert(accountType == NanoAccountType.BANANO || accountType == NanoAccountType.NANO);
    var binaryPubkey = NanoHelpers.hexToBinary(publicKey).padLeft(260, "0");
    var encodedChecksum = calculatedEncodedChecksum(binaryPubkey);
    var encodedPubkey = encoder.encode(binaryPubkey);
    return NanoAccountType.getPrefix(accountType) + encodedPubkey + encodedChecksum;
  }

  static String calculatedEncodedChecksum(String publicKey) {
    Uint8List checksum = NanoHelpers.reverse(Hashes.digest(5, [NanoHelpers.hexToBytes(publicKey)]));
    String binaryChecksum = NanoHelpers.hexToBinary(NanoHelpers.byteToHex(checksum)).padLeft(8, "0");
    return encoder.encode(binaryChecksum);
  }
}