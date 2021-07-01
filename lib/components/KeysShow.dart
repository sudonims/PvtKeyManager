import 'package:flutter/material.dart';
import 'package:crypto_key_manager/helpers/Keys.dart';

class KeysShow extends StatefulWidget {
  KeysShow({@required this.keys});
  final PrivateKeys keys;

  @override
  KeysShowState createState() => KeysShowState();
}

class KeysShowState extends State<KeysShow> {
  @override
  Widget build(BuildContext context) {
    // return Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //       Column(
    //         children: [
    //           ListView.builder(
    //             itemCount: widget.keys.getKeys.length,
    //             itemBuilder: (context, index) {
    //               PrivateKey key = widget.keys.getKeys[index];

    //               return ListTile(
    //                 title: Text(key.getName),
    //                 subtitle: Text("Some"),
    //               );
    //             },
    //           )
    //         ],
    //       )
    //     ]);

    return new ListView(
      padding: const EdgeInsets.all(8),
      children: widget.keys.getKeys
          .map((key) => ListTile(
                title: Text(key.getName),
              ))
          .toList(),
    );
  }
}
