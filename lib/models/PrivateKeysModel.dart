import 'package:crypto_key_manager/helpers/Keys.dart';
import 'package:flutter/material.dart';

class PrivateKeysModel extends ChangeNotifier {
  PrivateKeys _keys;

  set keys(PrivateKeys keys) {
    this._keys = keys;
    notifyListeners();
  }

  PrivateKeys get getKeys => this._keys;
}
