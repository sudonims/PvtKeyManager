import 'package:private_key_manager/helpers/Keys.dart';
import 'package:private_key_manager/models/PrivateKeysModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clipboard/clipboard.dart';

class PrivateKeyShow extends StatefulWidget {
  PrivateKeyShow();
  @override
  PrivateKeyShowState createState() => PrivateKeyShowState();
}

class PrivateKeyShowState extends State<PrivateKeyShow> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    PrivateKey key = args['privateKey'];

    var privateKeysModel = context.watch<PrivateKeysModel>();
    // return Text("data");
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
                      // Text(
                      //   key.getName,
                      //   style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                      // ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                        ),
                        onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              var secret = TextEditingController();
                              return AlertDialog(
                                title: Text("Add a New Secret"),
                                content: Container(
                                    height: 250,
                                    width: 175,
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            controller: secret,
                                            decoration: InputDecoration(
                                                hintText: "Secret"),
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
                                          key.addSecret = secret.text;
                                          privateKeysModel.updateKey = key;
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content:
                                                Text("Secret added succefully"),
                                            backgroundColor: Colors.blue,
                                          ));
                                        } catch (e) {
                                          // print(e);
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
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ] +
          key.getSecrets
              .map((singleSecret) => Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(singleSecret),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                                onPressed: () {
                                  FlutterClipboard.copy(singleSecret)
                                      .then((value) => {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Secret Copied Successfully"),
                                              backgroundColor: Colors.green,
                                            ))
                                          });
                                },
                                icon: Icon(Icons.copy_outlined,
                                    size: 20.0, color: Colors.green)),
                            IconButton(
                                onPressed: () {
                                  key.removeSecret = singleSecret;
                                  privateKeysModel.updateKey = key;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text("Secret Removed Successfully"),
                                    backgroundColor: Colors.green,
                                  ));
                                },
                                icon: Icon(
                                  Icons.delete_forever_outlined,
                                  size: 20.0,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                      )
                    ],
                  ))
              .toList(),
    );
  }
}
