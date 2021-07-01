import 'package:flutter/material.dart';
import 'package:crypto_key_manager/helpers/Keys.dart';

class KeysShow extends StatefulWidget {
  KeysShow({@required this.keys});
  final PrivateKeys keys;

  @override
  KeysShowState createState() => KeysShowState();
}

class KeysShowState extends State<KeysShow> {
  void onDelete(String id) {}

  @override
  Widget build(BuildContext context) {
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
                          onPressed: () {
                            print("Add");
                          },
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
          widget.keys.getKeys
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
