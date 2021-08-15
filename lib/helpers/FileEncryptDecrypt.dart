import 'dart:typed_data';
import 'dart:convert';
import 'package:cryptography/cryptography.dart';
import 'package:aes_crypt/aes_crypt.dart';
import 'prpass.dart';

class Encryptor {
  String _path;
  String _lucky;
  String _secret;

  set path(String path) {
    this._path = path;
  }

  set lucky(String lucky) {
    this._lucky = lucky;
  }

  set secret(String secret) {
    this._secret = secret;
  }

  String generateSecret() {
    var prpass = PRPass(secret: this._secret, lucky: this._lucky);
    return prpass.generatePassword();
  }

  void encrypt(String data) async {
    // AesCtr algorithm = AesCtr.with128bits(macAlgorithm: MacAlgorithm.empty);
    AesCrypt crypt = new AesCrypt();

    String secret = this.generateSecret();
    Uint8List key = Uint8List.fromList(utf8.encode(secret));
    // SecretKey secretKey = await algorithm.newSecretKeyFromBytes(key);

    Uint8List iv = Uint8List.fromList(utf8.encode(
        PRPass(secret: secret, lucky: key[0].toString()).generatePassword()));

    // SecretBox enc = await algorithm.encrypt(
    //     Uint8List.fromList(utf8.encode(data)),
    //     secretKey: secretKey,
    //     nonce: iv);

    crypt.aesSetKeys(key, iv);
    crypt.setPassword(secret);

    // final cipher = enc.cipherText;
    // final mc = enc.mac.bytes;
    // print(cipher);
    // print(mc);
    // print(String.fromCharCodes(mc));
    // print(utf8.encode(String.fromCharCodes(cipher)));

    // Mac mac = new Mac(utf8.encode(String.fromCharCodes(mc)));
    // SecretBox encData = new SecretBox(
    //     Uint8List.fromList(utf8.encode(String.fromCharCodes(cipher))),
    //     nonce: iv);

    // AesCtr algorithm1 = AesCtr.with128bits(macAlgorithm: Hmac.sha256());
    // List<int> dec = await algorithm1.decrypt(encData, secretKey: secretKey);

    // print(dec.toString());
    crypt.encryptDataToFile(Uint8List.fromList(utf8.encode(data)), this._path);
  }
}

class Decryptor {
  String _path;
  String _lucky;
  String _secret;

  set path(String path) {
    this._path = path;
  }

  set lucky(String lucky) {
    this._lucky = lucky;
  }

  set secret(String secret) {
    this._secret = secret;
  }

  String generateSecret() {
    var prpass = PRPass(secret: this._secret, lucky: this._lucky);
    return prpass.generatePassword();
  }

  Future<String> decrypt() async {
    try {
      AesCrypt crypt = new AesCrypt();
      String secret = this.generateSecret();
      Uint8List key = Uint8List.fromList(utf8.encode(secret));
      Uint8List iv = Uint8List.fromList(utf8.encode(
          PRPass(secret: secret, lucky: key[0].toString()).generatePassword()));
      crypt.aesSetKeys(key, iv);
      crypt.setPassword(secret);
      Uint8List decrypted = await crypt.decryptDataFromFile(this._path);
      var data = String.fromCharCodes(decrypted);
      return data;
    } on AesCryptDataException catch (e) {
      // print(e.type);
      print(e.message);
      return "e";
    }
  }
}
