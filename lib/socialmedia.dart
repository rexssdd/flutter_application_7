import 'package:flutter/material.dart';
import 'model/userpost.dart';
import 'model/userdata.dart';
import 'views/mainheader.dart';
import 'views/infoheader.dart';
import 'views/friendlist.dart';
import 'views/postlist.dart';

class Socialmedia extends StatefulWidget {
  const Socialmedia({super.key, required this.username});
  final String username;

  @override
  State<Socialmedia> createState() => _SocialmediaState();
}

class _SocialmediaState extends State<Socialmedia> {
  final List<SocialPost> _posts = Userdata.posts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Social Media'), backgroundColor: Theme.of(context).colorScheme.primaryContainer),
      // FIX: One parent ListView owns all vertical scrolling. No nested scrolling GridView/ListView.
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          MainHeader(username: widget.username),
          const SizedBox(height: 12),
          const InfoHeader(),
          const SizedBox(height: 18),
          const Text('Friends', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          // FIX: shrinkWrap + never scroll separately; equal aspect ratio and centered photos.
          const FriendList(),
          const SizedBox(height: 20),
          const Text('Posts', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Postlist(posts: _posts, currentUser: widget.username),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

