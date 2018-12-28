class NanoAccountType {
  static const int NANO = 1;
  static const int BANANO = 2;
  static const String NANO_REGEX =  r"^(xrb_|nano_)[13456789abcdefghijkmnopqrstuwxyz]{60}$";
  static const String BANANO_REGEX = r"^(ban_)[13456789abcdefghijkmnopqrstuwxyz]{60}$";

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

  static String getRegex(int type) {
    switch (type) {
      case NANO:
        return NANO_REGEX;
      case BANANO:
        return BANANO_REGEX;
      default:
        return NANO_REGEX;
    }    
  }
}
