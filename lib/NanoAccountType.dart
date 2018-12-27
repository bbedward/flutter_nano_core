library flutter_nano_core.nanoaccountype;

class NanoAccountType {
  static const int NANO = 1;
  static const int BANANO = 2;

  static String getPrefix(int type) {
    switch (type) {
      case NANO:
        return "nano_";
      case BANANO:
        return "ban_";
      default:
        return "nano_";
    }
  }
}
