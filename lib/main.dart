import 'package:crypto_key_manager/components/KeysShow.dart';
import 'package:crypto_key_manager/helpers/Keys.dart';
import 'package:flutter/material.dart';
import 'package:crypto_key_manager/components/Home.dart';

void main() {
  runApp(PvtKeyManager());
}

class PvtKeyManager extends StatelessWidget {
  // This widget is the root of your application.

  PrivateKeys populate() {
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
    return keys;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Private Key Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(
        currentPage: KeysShow(
          keys: populate(),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({this.currentPage});

  final Widget currentPage;

  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  // func() {
  //   setState(() {
  //     widget.currentPage = Widget();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Private Key Manager"),
      ),
      body: Center(child: widget.currentPage),
    );
  }
}
