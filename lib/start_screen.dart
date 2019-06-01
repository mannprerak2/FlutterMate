import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_mate/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class StartScreen extends StatelessWidget {
  static BuildContext popContext;

  @override
  Widget build(BuildContext context) {
    popContext = context;
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Flutter-Mate',
              style: TextStyle(color: Colors.blue, fontSize: 40),
            ),
          ),
          RaisedButton(
            color: Colors.blue,
            child: Text(
              "Login with Github",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              if (await canLaunch(url)) {
                await launch(
                  url,
                  forceSafariVC: false,
                  forceWebView: false,
                );
              } else {
                print("CANNOT LAUNCH THIS URL!");
              }
            },
          ),
        ],
      )),
    );
  }
}
