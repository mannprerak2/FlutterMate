import 'package:flutter/material.dart';
import 'package:flutter_mate/network.dart';
import 'package:flutter_mate/usermodel.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  int status = 0;
  List<User> users = [];

  @override
  void initState() {
    getFeed();
    super.initState();
  }

  void getFeed() async {
    users = await Network().getFeed();
    setState(() {
      status = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (status == 0) {
      //loading
      return Scaffold(
        body: Center(
          child: Container(
            width: 10,
            height: 10,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else if (status == 1) {
      //error
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Some Error Occured"),
              RaisedButton(
                child: Text("Retry"),
                onPressed: () {
                  setState(() {
                    status = 0;
                  });
                },
              )
            ],
          ),
        ),
      );
    } else if (status == 2) {
      return Scaffold(
        body: Swiper(
          itemCount: users.length,
          itemBuilder: (context, i) {
            return Text(users[i].toString());
          },
          pagination: SwiperPagination(),
          control: SwiperControl(),
        ),
      );
    }
    return Container(
      child: Text("unknown state"),
    );
  }
}
