import 'package:flutter/material.dart';
import '../model/userpost.dart';
import 'profileview.dart';

class Postlist extends StatefulWidget {
  final List<Userpost> posts;
  const Postlist({super.key, required this.posts});

  @override
  State<Postlist> createState() => _PostlistState();
}

class _PostlistState extends State<Postlist> {
  Future<void> openPost(Userpost post) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileView(userPost: post)),
    );
    if (mounted) {
      setState(() {});
    }
  }

  void likePost(Userpost post) {
    setState(() {
      post.isliked = !post.isliked;
      post.likes += post.isliked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.posts.length,
      itemBuilder: (context, index) {
        Userpost post = widget.posts[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(backgroundImage: AssetImage(post.userimg)),
                title: Text(post.username),
                subtitle: Text(post.time),
                onTap: () => openPost(post),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Text(post.postcontent),
              ),
              GestureDetector(
                onTap: () => openPost(post),
                child: Image.asset(
                  post.postimg,
                  width: double.infinity,
                  height: 500,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(height: 210, child: Center(child: Icon(Icons.image, size: 60)));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('${post.likes} likes · ${post.comments.length} comments · ${post.numshare} shares'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () => likePost(post),
                    icon: Icon(post.isliked ? Icons.favorite : Icons.favorite_border),
                    label: const Text('Like'),
                  ),
                  TextButton.icon(
                    onPressed: () => openPost(post),
                    icon: const Icon(Icons.comment_outlined),
                    label: const Text('Comment'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Share is not available in this demo.')),
                      );
                    },
                    icon: const Icon(Icons.share_outlined),
                    label: const Text('Share'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
