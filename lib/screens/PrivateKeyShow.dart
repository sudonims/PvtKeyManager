import 'package:crypto_key_manager/helpers/Keys.dart';
import 'package:crypto_key_manager/models/PrivateKeysModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    print(args);

    PrivateKey key = args['privateKey'];

    var privateKeysModel = context.watch<PrivateKeysModel>();

    return Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      key.getName,
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                    ),
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
                                          setState(() {
                                            key.addSecret = secret.text;
                                          });
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
                )
              ] +
              key.getSecrets
                  .map((secret) => Row(
                        children: <Widget>[
                          ListTile(
                            title: Text(secret),
                            trailing: Text("de"),
                          )
                        ],
                      ))
                  .toList(),
        ));
  }
}
