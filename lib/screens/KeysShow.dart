import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:crypto_key_manager/models/PrivateKeysModel.dart';
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
  void onDelete(String id) {}

  @override
  Widget build(BuildContext context) {
    var PrivateKeysContext = context.watch<PrivateKeysModel>();
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
                          onPressed: () {
                            print("Export");
                          },
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
                                            PrivateKeysContext.addKey = key;
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
          PrivateKeysContext.getKeys.getKeys
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
                                  PrivateKeysContext.removeKey = key;
                                },
                                icon: Icon(
                                  Icons.delete_forever_outlined,
                                  size: 20.0,
                                  color: Colors.red,
                                )),
                            IconButton(
                                onPressed: () {
                                  print("Open");
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
