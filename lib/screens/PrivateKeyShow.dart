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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                key.getName,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
