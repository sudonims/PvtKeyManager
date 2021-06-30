import 'package:flutter/material.dart';
import 'package:crypto_key_manager/components/Home.dart';

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
      home: MainPage(
        currentPage: Home(),
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
