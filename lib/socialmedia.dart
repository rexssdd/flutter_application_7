import 'package:flutter/material.dart';
import 'model/userdata.dart';
import 'views/mainheader.dart';
import 'views/infoheader.dart';
import 'views/friendlist.dart';
import 'views/postlist.dart';

class Socialmedia extends StatelessWidget {
  final Userdata data;

  const Socialmedia({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue, foregroundColor: Colors.black, elevation: 0, title: const Text('FaceBook App'), toolbarHeight: 42),
      // Only this outer ListView scrolls. Inner lists are not scrollable.
      body: ListView(
        children: [
          Mainheader(account: data.myUserAccount),
          Infoheader(account: data.myUserAccount),
          const Divider(height: 12, thickness: 1),
          const Padding(
            padding: EdgeInsets.all(14),
            child: Text('Friends', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
          ),
          Friendlist(friends: data.friendList),
          const Divider(height: 12, thickness: 1),
          const Padding(
            padding: EdgeInsets.all(14),
            child: Text('Posts', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Postlist(posts: data.userList),
        ],
      ),
    );
  }
}
