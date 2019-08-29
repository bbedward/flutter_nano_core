# DEPRECATED

## THIS PACKAGE HAS BEEN RENAMED

You should use the new package, it has a new name [nanodart](https://pub.dev/packages/nanodart)

# flutter_nano_core

Low-level functions for NANO/BANANO written in DART. Similar structure to [jnano-commons](https://github.com/rotilho/jnano-commons) for Java

Examples:

```
# Generate a random seed
String randomSeed = NanoSeeds.generateSeed();
# Validate a seed
bool seedIsValid = NanoSeeds.isValid(randomSeed);

# Create private key from seed at index 0
String privateKey = NanoKeys.seedToPrivate(seed, 0);
# Create public key from private key
String publicKey = NanoKeys.createPublicKey(privateKey);
# Create account from public get (nano_/ban_ address)
String address = NanoAccounts.createAccount(NanoAccountType.NANO, publicKey);

# Compute state block hash
computeStateHash(int accountType, String account, String previous, String representative, BigInt balance, String link);

# Sign a block
NanoSignatures.signBlock(hash, privateKey);
```