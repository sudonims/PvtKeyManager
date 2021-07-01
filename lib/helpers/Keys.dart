class PrivateKey {
  String _id;
  String _name;
  List<String> _secrets;

  set id(String id) {
    this._id = id;
  }

  set name(String name) {
    this._name = name;
  }

  set secrets(List<String> secret) {
    this._secrets = secret;
  }

  set addSecret(String secret) {
    this._secrets.add(secret);
  }

  get getId {
    return this._id;
  }

  get getName {
    return this._name;
  }

  get getSecrets {
    return this._secrets;
  }

  PrivateKey.fromJSON(Map<String, dynamic> input)
      : this._id = input['id'],
        this._name = input['name'],
        this._secrets = input['secrets'];

  Map<String, dynamic> toJSON() =>
      {'id': this._id, 'name': this._name, 'secrets': this._secrets};
}

class PrivateKeys {
  DateTime _lastModified;
  List<PrivateKey> _keys;

  set lastModified(DateTime last) {
    this._lastModified = last;
  }

  set keys(List<PrivateKey> keys) {
    this._keys = keys;
  }

  set addKey(PrivateKey key) {
    this._keys.add(key);
  }

  List<PrivateKey> get getKeys {
    return this._keys;
  }

  DateTime get getLastModified {
    return this._lastModified;
  }

  PrivateKeys();

  PrivateKeys.fromJSON(Map<String, dynamic> input) {
    this._lastModified = input['lastModified'];
    this._keys = input['keys']
        .map<PrivateKey>((key) => PrivateKey.fromJSON(key))
        .toList();
  }

  Map<String, dynamic> toJSON() => {
        "lastModified": this._lastModified,
        "keys": this._keys.map((key) => key.toJSON()).toList()
      };
}
