import 'package:crypto_key_manager/helpers/Keys.dart';
import 'package:flutter/material.dart';

class PrivateKeysModel extends ChangeNotifier {
  PrivateKeys _keys;

  set keys(PrivateKeys keys) {
    this._keys = keys;
    notifyListeners();
  }

  PrivateKeys get getKeys => this._keys;

  set addKey(PrivateKey key) {
    this._keys.addKey = key;
    notifyListeners();
  }

  set removeKey(PrivateKey key) {
    this._keys.removeKey = key;
    notifyListeners();
  }

  set updateKey(PrivateKey key) {
    this._keys.updateKey = key;
    notifyListeners();
  }

  set updateLastModified(DateTime time) {
    this._keys.lastModified = time;
    notifyListeners();
  }
}
