import "dart:typed_data" show Uint8List;

import 'package:flutter_nano_core/flutter_nano_core.dart';

class NanoAccounts {
  static NanoAccountEncodes encoder = new NanoAccountEncodes();

  static String createAccount(int accountType, String publicKey) {
    assert(accountType == NanoAccountType.BANANO || accountType == NanoAccountType.NANO);
    var binaryPubkey = NanoHelpers.hexToBinary(publicKey).padLeft(260, "0");
    print('binaryPubkey ${binaryPubkey}');
    var encodedChecksum = calculatedEncodedChecksum(binaryPubkey);
    print('encodedChecksum ${encodedChecksum}');
    var encodedPubkey = encoder.encode(binaryPubkey);
    print('encodedPubKey ${encodedPubkey}');
    return NanoAccountType.getPrefix(accountType) + encodedPubkey + encodedChecksum;
  }

  static bool isValid(int accountType, String account) {
    assert(accountType == NanoAccountType.BANANO || accountType == NanoAccountType.NANO);
    assert(account != null);
    // Ensure regex match
    if (!account.contains(new RegExp(NanoAccountType.getRegex(accountType)))) {
      return false;
    }
    String expectedChecksum = account.substring(account.length - 8);
    String encodedChecksum = calculatedEncodedChecksum(extractPublicKey(account));
    return expectedChecksum == encodedChecksum;
  }

  static String extractEncodedPublicKey(String account) {
    return account.startsWith("nano_") ? account.substring(5, 57) : account.substring(4, 56);
  }

  static String extractPublicKey(String account) {
    assert(account != null);
    String encodedPublicKey = extractEncodedPublicKey(account);
    String binaryPublicKey = encoder.decode(encodedPublicKey).substring(4);
    String hexPublicKey = NanoHelpers.binaryToHex(binaryPublicKey).padLeft(64, "0");
    return hexPublicKey;
  }

  static String calculatedEncodedChecksum(String publicKey) {
    Uint8List checksum = NanoHelpers.reverse(Hashes.digest(5, [NanoHelpers.hexToBytes(publicKey)]));
    String binaryChecksum = NanoHelpers.hexToBinary(NanoHelpers.byteToHex(checksum)).padLeft(8, "0");
    print("cs ${binaryChecksum}");
    return encoder.encode(binaryChecksum);
  }
}