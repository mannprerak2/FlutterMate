import 'package:flutter/material.dart';
import 'package:flutter_mate/network.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

TextStyle nameStyle = TextStyle(color: Colors.purple[700], fontSize: 28.0, fontFamily: 'Oxygen');
TextStyle usernameStyle = TextStyle(color: Colors.black87, fontSize: 18.0, fontFamily: 'Oxygen');
TextStyle aboutStyle = TextStyle(color: Colors.black87, fontSize: 17.0, fontFamily: 'Oxygen');
TextStyle headStyle = TextStyle(color: Colors.blueGrey, fontFamily: 'Oxygen', fontSize: 15.0);

FirebaseUser user = Network().user;
String uid = user.uid;
String githubName = user.displayName;
String imagePath = user.photoUrl;
//String username = Network().getUsername();

Stream<DocumentSnapshot> dc = Firestore.instance.collection('users').document(uid).snapshots();


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  /*Profile() {
    imagePath = Firestore.instance.collection('users').document(uid).collection('picture').toString();
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
//        appBar: AppBar(
//
//        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: dc,
          builder: (context, snapshot) {
            if(snapshot.data == null) {
              return CircularProgressIndicator();
            }
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 400.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(116, 235, 213, 0.7),
                            Color.fromRGBO(172, 182, 229, 0.7),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 30.0,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Your Profile", style: headStyle,),
                                Spacer(),
                                IconButton(icon: Icon(Icons.settings), onPressed: () {},),

                              ],
                            ),
                          ),
                          CircleAvatar(
                            backgroundImage: new NetworkImage(imagePath),
                            radius: 72,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
                            child: Text(githubName, style: nameStyle, overflow: TextOverflow.fade,),
                          ),
                          Padding(

                            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                            child: Text(snapshot.data['username'], style: usernameStyle,),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Container(
                            decoration: BoxDecoration(
                              //boxShadow: Box,

                              borderRadius: BorderRadius.all(Radius.circular(16.0)),
                            ),
                            height: 300,
                            width: 340,
                            child: Padding(
                              padding: const EdgeInsets.all(26.0),
                              child: Text("About", style: aboutStyle,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {
            print("Pressed");
          }
         )
        ,
      ),
    );
  }
}

