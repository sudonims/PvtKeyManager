import 'dart:convert';
import 'package:crypto_key_manager/helpers/FileEncryptDecrypt.dart';
import 'package:path/path.dart' as p;
import 'package:crypto/crypto.dart';
import 'package:crypto_key_manager/models/PrivateKeysModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:crypto_key_manager/helpers/Keys.dart';
import 'package:provider/provider.dart';

class KeysShow extends StatefulWidget {
  KeysShow();
  // final PrivateKeys keys;

  @override
  KeysShowState createState() => KeysShowState();
}

class KeysShowState extends State<KeysShow> {
  Future<bool> export(
      PrivateKeys keys, String lucky, String word, String fileName) async {
    try {
      var finalJSON = jsonEncode(keys.toJSON());
      var outputDirectory = await FilePicker.platform.getDirectoryPath();
      var outputPath = p.join(outputDirectory, fileName);

      Encryptor e = new Encryptor();
      e.lucky = lucky;
      e.secret = word;
      e.path = outputPath;
      e.encrypt(finalJSON);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var privateKeysContext = context.watch<PrivateKeysModel>();
    return new ListView(
      padding: const EdgeInsets.all(8),
      children: [
            Column(
              children: [
                ListTile(
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                          ),
                          onPressed: () => showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                var lucky = TextEditingController();
                                var word = TextEditingController();
                                var fileName = TextEditingController();
                                return AlertDialog(
                                  title: Text(
                                      "PR-Pass - Used as a step to encrypt file"),
                                  content: Container(
                                      height: 250,
                                      width: 175,
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: lucky,
                                              decoration: InputDecoration(
                                                  hintText: "Lucky Number"),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              controller: word,
                                              decoration: InputDecoration(
                                                  hintText: "Word"),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              controller: fileName,
                                              decoration: InputDecoration(
                                                  hintText: "Output File Name"),
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
                                            bool success = await export(
                                                privateKeysContext.getKeys,
                                                lucky.text,
                                                word.text,
                                                fileName.text);
                                            if (success) {
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(fileName.text +
                                                    " saved successfully"),
                                                backgroundColor: Colors.green,
                                              ));
                                            } else {
                                              throw new Exception(
                                                  "Error occured");
                                            }
                                          } catch (e) {
                                            print(e);
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text("Error Occured"),
                                              backgroundColor: Colors.red,
                                            ));
                                          }
                                        },
                                        child: Text("Add"))
                                  ],
                                );
                              }),
                          child: Column(
                            children: <Widget>[
                              Row(children: <Widget>[
                                Text(
                                  "Export to file",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Icon(
                                  Icons.import_export,
                                  size: 20.0,
                                  color: Colors.green,
                                )
                              ])
                            ],
                          )),
                      TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                          ),
                          onPressed: () => showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                var name = TextEditingController();
                                return AlertDialog(
                                  title: Text("Add a New Key"),
                                  content: Container(
                                      height: 250,
                                      width: 175,
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              controller: name,
                                              decoration: InputDecoration(
                                                  hintText: "Name"),
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
                                        onPressed: () {
                                          try {
                                            PrivateKey key = new PrivateKey();
                                            key.name = name.text;
                                            key.id = md5
                                                .convert(utf8.encode(name.text +
                                                    DateTime.now().toString()))
                                                .toString();
                                            privateKeysContext.addKey = key;
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content:
                                                  Text("Key added succefully"),
                                              backgroundColor: Colors.blue,
                                            ));
                                          } catch (e) {
                                            print(e);
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text("Error Occured"),
                                              backgroundColor: Colors.red,
                                            ));
                                          }
                                        },
                                        child: Text("Add"))
                                  ],
                                );
                              }),
                          child: Column(
                            children: <Widget>[
                              Row(children: <Widget>[
                                Text(
                                  "Add ",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Icon(
                                  Icons.add_box_rounded,
                                  size: 20.0,
                                  color: Colors.green,
                                )
                              ])
                            ],
                          ))
                    ],
                  ),
                )
              ],
            )
          ] +
          privateKeysContext.getKeys.getKeys
              .map((key) => Column(
                    children: [
                      ListTile(
                        title: Text(
                          key.getName,
                          style: new TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                                onPressed: () {
                                  print("Icon Delete Pressed " + key.getId);
                                  privateKeysContext.removeKey = key;
                                },
                                icon: Icon(
                                  Icons.delete_forever_outlined,
                                  size: 20.0,
                                  color: Colors.red,
                                )),
                            IconButton(
                                onPressed: () {
                                  print("Open");
                                  Navigator.of(context).pushNamed("/secret",
                                      arguments: {"privateKey": key});
                                },
                                icon: Icon(
                                  Icons.open_in_full_rounded,
                                  size: 20.0,
                                  color: Colors.blue,
                                ))
                          ],
                        ),
                      ),
                      Divider()
                    ],
                  ))
              .toList(),
    );
  }
}
