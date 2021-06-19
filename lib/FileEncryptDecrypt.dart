import 'package:flutter/material.dart';

import 'package:aes_crypt/aes_crypt.dart';

class Encryptor {
  Encryptor({required this.path, required this.lucky, required this.secret});
  String path;
  int lucky;
  String secret;

  void encrypt() {}
}

class Decryptor {
  Decryptor({required this.path, required this.lucky, required this.secret});
  String path;
  int lucky;
  String secret;

  void decrypt() {}
}
