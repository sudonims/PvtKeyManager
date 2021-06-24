import 'dart:convert';
import 'dart:io';
import 'package:crypto_key_manager/helpers/Keys.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:crypto_key_manager/helpers/FileEncryptDecrypt.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, String this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextButton(
                onPressed: () async {
                  print("lol");
                  Encryptor enc = new Encryptor();
                  enc.lucky = "12";
                  enc.secret = "nim";
                  enc.path = await openFile(context);
                  enc.encrypt();
                },
                child: Text("Click")),
            TextButton(
                onPressed: () async {
                  print("lol");
                  Decryptor enc = new Decryptor();
                  enc.lucky = "12";
                  enc.secret = "nim";
                  enc.path = await openFile(context);
                  enc.decrypt();
                },
                child: Text("Click")),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
