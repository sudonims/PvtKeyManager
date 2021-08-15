import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:cryptography/cryptography.dart';
import 'prpass.dart';

class Encryptor {
  String _path;
  String _lucky;
  String _secret;

  set path(String path) {
    this._path = path + ".enc";
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
    AesCtr algorithm = AesCtr.with128bits(macAlgorithm: Hmac.sha256());

    String secret = this.generateSecret();
    Uint8List key = Uint8List.fromList(utf8.encode(secret));
    SecretKey secretKey = await algorithm.newSecretKeyFromBytes(key);

    Uint8List iv = Uint8List.fromList(utf8.encode(
        PRPass(secret: secret, lucky: key[0].toString()).generatePassword()));

    SecretBox enc = await algorithm.encrypt(
        Uint8List.fromList(utf8.encode(data)),
        secretKey: secretKey,
        nonce: iv);

    File file = new File(this._path);
    file.writeAsBytesSync(enc.cipherText);
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
      File file = new File(this._path);
      Uint8List fileData = file.readAsBytesSync();

      AesCtr algorithm = AesCtr.with128bits(macAlgorithm: Hmac.sha256());

      String secret = this.generateSecret();
      Uint8List key = Uint8List.fromList(utf8.encode(secret));
      SecretKey secretKey = await algorithm.newSecretKeyFromBytes(key);

      Uint8List iv = Uint8List.fromList(utf8.encode(
          PRPass(secret: secret, lucky: key[0].toString()).generatePassword()));

      Mac mac =
          await Hmac.sha256().calculateMac(fileData, secretKey: secretKey);

      SecretBox encData = new SecretBox(fileData, nonce: iv, mac: mac);

      List<int> dec = await algorithm.decrypt(encData, secretKey: secretKey);

      String data = String.fromCharCodes(dec);
      return data;
    } on SecretBoxAuthenticationError catch (e) {
      return "hmac_verify_fail";
    }
  }
}
