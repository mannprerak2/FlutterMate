import 'package:flutter/material.dart';

TextStyle nameStyle = TextStyle(color: Colors.black87, fontSize: 32.0, fontFamily: 'Oxygen');
TextStyle usernameStyle = TextStyle(color: Colors.black87, fontSize: 18.0, fontFamily: 'Oxygen');
TextStyle aboutStyle = TextStyle(color: Colors.black87, fontSize: 17.0, fontFamily: 'Oxygen');
class Profile extends StatelessWidget {
  //final String githubUsername, about, fScore;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
//        appBar: AppBar(
//
//        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text("Your Profile"),
                        IconButton(icon: Icon(Icons.settings), onPressed: () {},),

                      ],
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: new NetworkImage("https://i.imgur.com/BoN9kdC.png"),
                    radius: 72,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    child: Text("Name here", style: nameStyle,),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    child: Text("Username here", style: usernameStyle,),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
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

