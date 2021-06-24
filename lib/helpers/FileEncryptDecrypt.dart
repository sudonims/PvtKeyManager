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

  void encrypt() {
    AesCrypt crypt = new AesCrypt();
    Uint8List key = Uint8List.fromList(utf8.encode(this.generateSecret()));
    crypt.aesSetKeys(key, key);
    crypt.setPassword(this.generateSecret());
    crypt.encryptFile(this._path, "enc.enc");
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

  void decrypt() async {
    AesCrypt crypt = new AesCrypt();
    Uint8List key = Uint8List.fromList(utf8.encode(this.generateSecret()));
    crypt.aesSetKeys(key, key);
    crypt.setPassword(this.generateSecret());
    Uint8List decrypted = await crypt.decryptDataFromFile(this._path);

    var data = decrypted.toString();

    print(data);
  }
}
