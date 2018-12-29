import 'dart:typed_data';
import 'package:flutter_nano_core/flutter_nano_core.dart';

class NanoBlocks {
  static String computeStateHash(int accountType, String account, String previous, String representative, BigInt balance, String link) {
    assert(accountType == NanoAccountType.BANANO || accountType == NanoAccountType.NANO);
    Uint8List statePreamble = NanoHelpers.hexToBytes("0000000000000000000000000000000000000000000000000000000000000006");
    Uint8List accountBytes = NanoHelpers.hexToBytes(NanoAccounts.extractPublicKey(account));
    Uint8List previousBytes = NanoHelpers.hexToBytes(previous.padLeft(64, "0"));
    Uint8List representativeBytes = NanoHelpers.hexToBytes(NanoAccounts.extractPublicKey(representative));
    Uint8List balanceBytes = NanoHelpers.bigIntToBytes(balance);
    Uint8List linkBytes = NanoAccounts.isValid(accountType, link) ? NanoHelpers.hexToBytes(NanoAccounts.extractPublicKey(link)) : NanoHelpers.hexToBytes(link);
    return NanoHelpers.byteToHex(Hashes.digest256([statePreamble, accountBytes, previousBytes, representativeBytes, balanceBytes, linkBytes])).toUpperCase();
  }
}