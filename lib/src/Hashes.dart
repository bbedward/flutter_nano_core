import 'dart:typed_data' show Uint8List;

import 'package:pointycastle/digests/blake2b.dart';
import 'package:flutter_nano_core/flutter_nano_core.dart';

class Hashes {
  static const int DIGEST_256 = 256 ~/ 8;

  static Uint8List digest256(List<Uint8List> bytes) {
    return digest(DIGEST_256, bytes);
  }

  static Uint8List digest(int digestSize, List<Uint8List> byteArrays) {
    Uint8List output = new Uint8List(digestSize);
    var blake2b = Blake2bDigest(digestSize: digestSize);
    byteArrays.forEach(
        (byteArray) => byteArray.forEach((byte) => blake2b.updateByte(byte)));
    blake2b.doFinal(output, 0);
    return output;
  }

  static Uint8List intToUint8List(int integer, int length) {
    var ret = Uint8List(length);
    for (int i = 0; i < length; i++) {
      var byte = integer & 0xff;
      ret[i] = byte;
      integer = (integer - byte) ~/ 256;
    }
    return NanoHelpers.reverse(ret);
  }
}
