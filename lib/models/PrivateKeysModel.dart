import 'package:crypto_key_manager/helpers/Keys.dart';
import 'package:flutter/material.dart';

PrivateKeys populate() {
  PrivateKeys keys = new PrivateKeys();
  keys.lastModified = DateTime.now();
  PrivateKey key = PrivateKey.fromJSON({
    "name": "Binance",
    "secrets": ["lol", "lol1"]
  });
  key.id = "0001";

  keys.keys = [key];

  key = null;
  key = PrivateKey.fromJSON({
    "name": "Binance",
    "secrets": ["lol", "lol1aaaaa"]
  });
  key.id = "0002";

  keys.addKey = key;
  return keys;
}

class PrivateKeysModel extends ChangeNotifier {
  PrivateKeys _keys;

  PrivateKeysModel() {
    this._keys = populate();
  }

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
