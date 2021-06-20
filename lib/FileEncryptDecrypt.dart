import 'dart:io';
import 'dart:typed_data';
import 'package:aes_crypt/aes_crypt.dart';
import 'dart:convert';
import './helpers/prpass.dart';

class Encryptor {
  late String _path;
  late String _lucky;
  late String _secret;

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
    var crypt = new AesCrypt();
    Uint8List key = Uint8List.fromList(utf8.encode(this.generateSecret()));
    crypt.aesSetKeys(key, key);
    crypt.setPassword(this.generateSecret());
    crypt.encryptFile(this._path, "enc.enc");
  }
}

class Decryptor {
  Decryptor({required this.path, required this.lucky, required this.secret});
  String path;
  int lucky;
  String secret;

  void decrypt() {}
}

void main(List<String> args) {
  var file = File("lib/main.dart");
  var enc = Encryptor();
  enc.path = file.absolute.toString();
  enc.lucky = "13";
  enc.secret = "nimish";
  enc.encrypt();
}
