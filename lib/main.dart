import 'dart:convert';
import 'dart:io';
import 'package:crypto_key_manager/helpers/Keys.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:crypto_key_manager/helpers/FileEncryptDecrypt.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(PvtKeyManager());
}

class PvtKeyManager extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Private Key Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Private Key Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String> openFile(BuildContext context) async {
    FilePickerResult res = await FilePicker.platform.pickFiles();
    if (res != null)
      return res.files.single.path.toString();
    else
      return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
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
          ),
        ));
  }
}
