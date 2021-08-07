import 'package:private_key_manager/models/PrivateKeysModel.dart';
import 'package:private_key_manager/screens/KeysShow.dart';
import 'package:private_key_manager/screens/PrivateKeyShow.dart';
import 'package:flutter/material.dart';
import 'package:private_key_manager/screens/Home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(PvtKeyManager());
}

class PvtKeyManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => PrivateKeysModel(),
        child: MaterialApp(
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
                  currentPage: KeysShow(),
                ),
            '/secret': (context) => MainPage(
                  currentPage: PrivateKeyShow(),
                ),
          },
        ));
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
