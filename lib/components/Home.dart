import 'package:flutter/material.dart';
import 'package:crypto_key_manager/helpers/Keys.dart';
import 'package:file_picker/file_picker.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  Future<String> openFile(BuildContext context) async {
    FilePickerResult res = await FilePicker.platform.pickFiles();
    if (res != null)
      return res.files.single.path.toString();
    else
      return "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(
            onPressed: () async {
              print("lol");
            },
            child: Text("Import")),
        TextButton(onPressed: () async {}, child: Text("Create New")),
        TextButton(
            onPressed: () {
              PrivateKeys keys = new PrivateKeys();
              keys.lastModified = DateTime.now();
              // PrivateKey key = ;
              keys.keys = [
                PrivateKey.fromJSON({
                  "name": "Binance",
                  "secrets": ["lol", "lol1"]
                })
              ];
              keys.addKey = PrivateKey.fromJSON({
                "name": "Binance",
                "secrets": ["lol", "lol1aaaaa"]
              });
              var a = keys.toJSON();

              print(a);

              PrivateKeys keysC = PrivateKeys.fromJSON(a);
              keysC.addKey = PrivateKey.fromJSON({
                "name": "X",
                "secrets": ["lulz"]
              });
              print(keysC.toJSON());
            },
            child: Text("Lol"))
      ],
    );
  }
}
