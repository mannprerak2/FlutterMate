import 'package:flutter/material.dart';
import 'package:flutter_mate/constants.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String message = "---";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterMate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
            child: Column(
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
            Text(message),
          ],
        )),
      ),
    );
  }
}
