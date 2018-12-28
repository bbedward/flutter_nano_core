import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_nano_core/flutter_nano_core.dart';

void main() {
  test('test seed to private key', () {
    expect(NanoKeys.seedToPrivate('E11A48D701EA1F8A66A4EB587CDC8808D726FE75B325DF204F62CA2B43F9ADA1', 0), '67EDBC8F904091738DF33B4B6917261DB91DD9002D3985A7BA090345264A46C6');
    expect(NanoKeys.seedToPrivate('E11A48D701EA1F8A66A4EB587CDC8808D726FE75B325DF204F62CA2B43F9ADA1', 1), '22EDDBF0D72E9A4232C3FE6689A6CB0A228C9ED822715A63E2F8644AA2C905A4');
  });

  test('test address from seed', () {
    var privKey = '67EDBC8F904091738DF33B4B6917261DB91DD9002D3985A7BA090345264A46C6';
    expect(NanoAccounts.createAccount(NanoAccountType.BANANO, 
                                      NanoKeys.createPublicKey(privKey)),
          'ban_1p95xji1g5gou8auj8h6qcuezpdpcyoqmawao6mpwj4p44939oouoturkggc');
    expect(NanoAccounts.createAccount(NanoAccountType.NANO, 
                                      NanoKeys.createPublicKey(privKey)),
          'nano_1p95xji1g5gou8auj8h6qcuezpdpcyoqmawao6mpwj4p44939oouoturkggc');
  });

  test('test hex to byte array and back', () {
    var hex = '67EDBC8F904091738DF33B4B6917261DB91DD9002D3985A7BA090345264A46C6';
    var byteArray = NanoHelpers.hexToBytes('67EDBC8F904091738DF33B4B6917261DB91DD9002D3985A7BA090345264A46C6');
    expect(NanoHelpers.byteToHex(byteArray), hex);
  });

  test('test hex to binary and back', () {
    var hex = '67EDBC8F904091738DF33B4B6917261DB91DD9002D3985A7BA090345264A46C6';
    var binary = NanoHelpers.hexToBinary('67EDBC8F904091738DF33B4B6917261DB91DD9002D3985A7BA090345264A46C6');
    expect(NanoHelpers.binaryToHex(binary), hex);
  });

  test('test address validation', () {
    // Three valid accounts
    expect(NanoAccounts.isValid(NanoAccountType.BANANO, 'ban_1p95xji1g5gou8auj8h6qcuezpdpcyoqmawao6mpwj4p44939oouoturkggc'), true);
    expect(NanoAccounts.isValid(NanoAccountType.NANO, 'xrg_1p95xji1g5gou8auj8h6qcuezpdpcyoqmawao6mpwj4p44939oouoturkggc'), true);
    expect(NanoAccounts.isValid(NanoAccountType.NANO, 'nano_1p95xji1g5gou8auj8h6qcuezpdpcyoqmawao6mpwj4p44939oouoturkggc'), true);
    // Invalid checksum
    expect(NanoAccounts.isValid(NanoAccountType.BANANO, 'ban_3zzzzzzzzzzzhw11111111111111111111111111111111111111spcronyu'), false);
    // Too short of length
    expect(NanoAccounts.isValid(NanoAccountType.BANANO, 'ban_1p95xji1g5gou8auj8h6qcuezpdpcyoqmawao6mpwj4p44939oouoturkg'), false);
    // Invalid prefix
    expect(NanoAccounts.isValid(NanoAccountType.BANANO, 'xrb_1p95xji1g5gou8auj8h6qcuezpdpcyoqmawao6mpwj4p44939oouoturkggc'), false);
  });

  test('test block hash computation', () {
    // given
    var accountType = NanoAccountType.NANO;
    var account = 'xrb_1ak9nqn1m5u5ze4yr4rfm7rnwjny1qw96r46ncm88oiophz8yakdggfb6bo4';
    var previous = '3DA527883F4C39A1C7C312DEB55766E975B512544595D574347B5F04BF19413E';
    var representative = 'xrb_3rw4un6ys57hrb39sy1qx8qy5wukst1iiponztrz9qiz6qqa55kxzx4491or';
    var balance = BigInt.parse('30109202700477890000000000000000000');
    var link = 'xrb_3ok55uirensct6yjq6j5w7k9w38hngubozjgi77cwsgaxuh9m9gkqek1f4yi';

    var calculatedHash = NanoBlocks.computeStateHash(accountType, account, previous, representative, balance, link);

    expect(calculatedHash,
          '714DC230267C4E5A6BA0D61E6B90410C67D17F649A2752297E3115F12AEFBD9E');
  });

  test('test block signature', () {
    var privKey = '9F0E444C69F77A49BD0BE89DB92C38FE713E0963165CCA12FAF5712D7657120F';
    var hash = 'AEC75F807DCE45AFA787DE7B395BE498A885525569DD614162E0C80FD4F27EE9';

    String signature = NanoSignatures.signBlock(hash, privKey);

    expect(signature,
          '1123C926EF53B0FFA3585D5F6FA17D05B2AAD486D28CBEED88837B83265F264CBAF3FEA78AF80AAB4C59740546B220ADBE207F6B800FFE864E0934E9C1078401');
  });
}
