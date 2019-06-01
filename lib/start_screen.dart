import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_mate/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Github Login'),
          RaisedButton(
            child: Text("Login"),
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
