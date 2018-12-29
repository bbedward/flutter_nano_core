import 'dart:typed_data' show Uint8List;
import 'package:hex/hex.dart';
import 'package:pointycastle/src/utils.dart';

class NanoHelpers {
  static List<String> hexArray = '0123456789ABCDEF'.split('');

  /**
   * Converts a Uint8List to a hex string
   */
  static String byteToHex(Uint8List bytes) {
    return HEX.encode(bytes);
  }

  static BigInt byteToBigInt(Uint8List bigIntBytes) {
    return decodeBigInt(bigIntBytes);
  }

  /**
   * Converts a hex string to a Uint8List
   */
  static Uint8List hexToBytes(String hex) {
    return Uint8List.fromList(HEX.decode(hex));
  }

  /**
   * Convert a bigint to a byte array
   */
  static Uint8List bigIntToBytes(BigInt bigInt) {
    var bytes = encodeBigInt(bigInt);
    Uint8List tmp = new Uint8List(16);
    int sourcePosition = bytes.length <= 16 ? 0 : 1;
    int bytesLength = bytes.length <= 16 ? bytes.length : 16;
    arraycopy(bytes, sourcePosition, tmp, tmp.length - bytesLength, bytesLength);
    return tmp;
  }

  static void arraycopy(List src, int srcPos, List dest, int destPos, int length) {
    dest.setRange(destPos, length + destPos, src, srcPos);
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

  static bool isHexString(String input) {
    var hexChars = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a',
    'b', 'c', 'd', 'e', 'f', 'A', 'B', 'C', 'D', 'E', 'F'];
    for (int i = 0; i < input.length; i++) {
      if (!hexChars.contains(input[i])) {
        return false;
      }
    }
    return true;
  }
}