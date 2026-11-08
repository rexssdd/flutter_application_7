import 'package:flutter/material.dart';
import 'profileview.dart';
import '../model/userpost.dart';

class Postlist extends StatefulWidget {
  const Postlist({super.key, required this.posts, required this.currentUser});
  final List<SocialPost> posts;
  final String currentUser;
  @override
  State<Postlist> createState() => _PostlistState();
}

class _PostlistState extends State<Postlist> {
  @override
  Widget build(BuildContext context) {
    // FIX: Not another scrolling ListView inside the parent ListView.
    return Column(children: widget.posts.map((post) => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(clipBehavior: Clip.antiAlias, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        ListTile(
          leading: CircleAvatar(backgroundColor: post.color, child: const Icon(Icons.person, color: Colors.white)),
          title: Text(post.author, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(post.time),
          onTap: () => _openPost(post),
        ),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Text(post.caption)),
        InkWell(onTap: () => _openPost(post), child: Container(
          height: 180, color: post.color.withValues(alpha: 0.15),
          child: Icon(post.icon, size: 84, color: post.color),
        )),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextButton.icon(
            onPressed: () => setState(() => post.liked = !post.liked),
            icon: Icon(post.liked ? Icons.favorite : Icons.favorite_border, color: post.liked ? Colors.red : null),
            label: Text(post.liked ? 'Liked' : 'Like'),
          ),
          TextButton.icon(onPressed: () => _openPost(post), icon: const Icon(Icons.comment_outlined), label: const Text('Comment')),
          TextButton.icon(onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sharing is not configured in this demo.')));
          }, icon: const Icon(Icons.share_outlined), label: const Text('Share')),
        ]),
      ])),
    )).toList());
  }

  void _openPost(SocialPost post) => Navigator.push(context, MaterialPageRoute<void>(
    builder: (_) => ProfileView(post: post, currentUser: widget.currentUser),
  ));
}
