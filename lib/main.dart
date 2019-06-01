import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mate/constants.dart';
import 'package:flutter_mate/start_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter_mate/network.dart';
import 'package:flutter_mate/profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String message = "---";
  StreamSubscription _subs;
  final navKey = GlobalKey<NavigatorState>();

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

      proceedToProfile(code);
    }
  }

  void proceedToProfile(String code) async {
    bool p = await Network().loginWithGitHub(code);

    if (p) {
      navKey.currentState.pushReplacementNamed("/profile");
    } else {
      showDialog(
          context: navKey.currentState.context,
          builder: (context) {
            return AlertDialog(
                content: Text("Some Server Error Occured, Please Try Again"));
          });
      print("Server Error");
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
      navigatorKey: navKey,
      title: 'FlutterMate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => StartScreen(),
        '/profile': (context) => Profile(),
      },
    );
  }
}
