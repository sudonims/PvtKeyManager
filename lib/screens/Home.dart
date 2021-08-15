import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:private_key_manager/helpers/Keys.dart';
import 'package:private_key_manager/models/PrivateKeysModel.dart';
import 'package:private_key_manager/helpers/FileEncryptDecrypt.dart';

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

  Future<String> decryptedData(
      String filePath, String lucky, String word) async {
    Decryptor d = new Decryptor();
    d.lucky = lucky;
    d.secret = word;
    d.path = filePath;

    String dec = await d.decrypt();
    return dec;
  }

  Future<bool> checkPermission() async {
    final status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      final result = await Permission.storage.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var privateKeysContext = context.watch<PrivateKeysModel>();

    checkPermission();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(
          onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                var lucky = TextEditingController();
                var word = TextEditingController();
                return AlertDialog(
                  title: Text("Select the encrypted File"),
                  content: Container(
                      height: 250,
                      width: 175,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: lucky,
                              decoration:
                                  InputDecoration(hintText: "Lucky Number"),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: word,
                              decoration: InputDecoration(hintText: "Word"),
                              obscureText: true,
                            ),
                          ),
                        ],
                      )),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel")),
                    TextButton(
                        onPressed: () async {
                          try {
                            String filePath = await openFile(context);
                            String dec = await decryptedData(
                                filePath, lucky.text, word.text);
                            // print(dec);
                            if (dec == "e") {
                              throw new Exception("Error");
                            }
                            var jsonData = jsonDecode(dec);
                            // print(jsonData);
                            PrivateKeys keys = PrivateKeys.fromJSON(jsonData);
                            privateKeysContext.keys = keys;
                            Navigator.pushNamed(context, "/keys");
                          } catch (e) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("Error Occured. Check password or File"),
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                        child: Text("Open"))
                  ],
                );
              }),
          child: Text("Import"),
        ),
        TextButton(
            onPressed: () async {
              Navigator.pushNamed(context, '/keys');
            },
            child: Text("Create New")),
      ],
    );
  }
}
