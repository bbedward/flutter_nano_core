import 'dart:typed_data' show Uint8List;
import 'package:hex/hex.dart';

class NanoHelpers {
  static List<String> hexArray = '0123456789ABCDEF'.split('');

  /**
   * Converts a Uint8List to a hex string
   */
  static String byteToHex(Uint8List bytes) {
    return HEX.encode(bytes);
  }

  /**
   * Converts a hex string to a Uint8List
   */
  static Uint8List hexToBytes(String hex) {
    return Uint8List.fromList(HEX.decode(hex));
  }

  /**
   * Converts a hex string to a binary string
   */
  static String hexToBinary(String hex) {
    return BigInt.parse(hex, radix: 16).toRadixString(2);
  }

  /**
   * Converts a binary string into a hex string
   */
  static String binaryToHex(String binary) {
    return BigInt.parse(binary, radix: 2).toRadixString(16);
  }

  static Uint8List reverse(Uint8List bytes) {
    Uint8List reversed = new Uint8List(bytes.length);
    for (int i = bytes.length; i > 0; i--) {
      reversed[bytes.length - i] = bytes[i - 1];
    }
    return reversed;
  }
}