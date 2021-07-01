import 'package:crypto_key_manager/components/KeysShow.dart';
import 'package:crypto_key_manager/helpers/Keys.dart';
import 'package:flutter/material.dart';
import 'package:crypto_key_manager/components/Home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(PvtKeyManager());
}

class PvtKeyManager extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Private Key Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(
              currentPage: Home(),
            ),
        '/keys': (context) => MainPage(
              currentPage: KeysShow(keys: populate()),
            )
      },
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({this.currentPage});

  final Widget currentPage;

  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
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
