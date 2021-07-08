import 'dart:typed_data';
import 'package:aes_crypt/aes_crypt.dart';
import 'dart:convert';
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

  void encrypt(String data) {
    AesCrypt crypt = new AesCrypt();
    String secret = this.generateSecret();
    Uint8List key = Uint8List.fromList(utf8.encode(secret));
    Uint8List iv = Uint8List.fromList(utf8.encode(
        PRPass(secret: secret, lucky: key[0].toString()).generatePassword()));
    crypt.aesSetKeys(key, iv);
    crypt.setPassword(secret);
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
  }
}
