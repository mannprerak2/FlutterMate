import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mate/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter_mate/network.dart';
import 'package:flutter_mate/profile.dart';

void main() => runApp(Profile());

/*class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String message = "---";
  StreamSubscription _subs;

  @override
  void initState() {
    _initDeepLinkListener();
    super.initState();
  }

  @override
  void dispose() {
    _disposeDeepLinkListener();
    super.dispose();
  }

  void _initDeepLinkListener() async {
    _subs = getLinksStream().listen((String link) {
      print("init deeplink listener");
      _checkDeepLink(link);
    }, cancelOnError: true);
  }

  void _checkDeepLink(String link) {
    if (link != null) {
      String code = link.substring(link.indexOf(RegExp('code=')) + 5);
      Network().loginWithGitHub(code).then((firebaseUser) {
        print("LOGGED IN AS: " + firebaseUser.displayName);

      }).catchError((e) {
        print("LOGIN ERROR: " + e.toString());
      });
    }
  }

  void _disposeDeepLinkListener() {
    print("dispose deeplink listener");
    if (_subs != null) {
      _subs.cancel();
      _subs = null;
    }
  }

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
            Text(message),
          ],
        )),
      ),
    );
  }
}*/
