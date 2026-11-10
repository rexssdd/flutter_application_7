
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/usercomment.dart';
import '../model/userpost.dart';
import 'profileview.dart';

class Postlist extends StatefulWidget {
  final List<Userpost> posts;

  const Postlist({
    super.key,
    required this.posts,
  });

  @override
  State<Postlist> createState() => _PostlistState();
}

class _PostlistState extends State<Postlist> {
  @override
  void initState() {
    super.initState();
    loadSavedComments();
  }

  Future<void> loadSavedComments() async {
    final prefs = await SharedPreferences.getInstance();

    for (final post in widget.posts) {
      final saved = prefs.getString('comments_${post.id}');

      if (saved == null) {
        post.numcomments = '${post.comments.length}';
        continue;
      }

      try {
        final decoded = jsonDecode(saved) as List<dynamic>;

        final restored = decoded.map((item) {
          return Usercomment.fromJson(
            Map<String, dynamic>.from(item as Map),
          );
        }).toList();

        post.comments
          ..clear()
          ..addAll(restored);

        post.numcomments = '${post.comments.length}';
      } catch (e) {
        debugPrint('Error loading comments: $e');
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> openPost(Userpost post) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileView(
          userPost: post,
        ),
      ),
    );

    if (!mounted) return;

    // Reload comments saved by the detail screen.
    await loadSavedComments();
  }

  void likePost(Userpost post) {
    setState(() {
      post.isliked = !post.isliked;
      post.likes += post.isliked ? 1 : -1;
    });
  }

  Widget postAction(
    IconData icon,
    String label,
    VoidCallback onTap, {
    bool active = false,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 17,
                color: active ? Colors.blue : Colors.grey[600],
              ),
              const SizedBox(width: 7),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: active ? Colors.blue : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.posts.length,
      itemBuilder: (context, index) {
        final post = widget.posts[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          color: const Color(0xFFF9F5FA),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // POST HEADER
              InkWell(
                onTap: () => openPost(post),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(post.userimg),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.username,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Text(
                                  post.time,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Icon(
                                  Icons.people,
                                  size: 15,
                                  color: Colors.black87,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // POST CAPTION
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 2, 12, 12),
                child: Text(
                  post.postcontent,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),

              // POST IMAGE
              GestureDetector(
                onTap: () => openPost(post),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Image.asset(
                      post.postimg,
                      width: constraints.maxWidth,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          height: 210,
                          child: Center(
                            child: Icon(
                              Icons.image,
                              size: 60,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              // COMMENT AND SHARE COUNTS
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 11,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${post.comments.length} Comments',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      '${post.numshare} Shares',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(
                height: 1,
                thickness: 0.7,
                color: Color(0xFFE1DDE2),
              ),

              // LIKE, COMMENT, SHARE BUTTONS
              Row(
                children: [
                  postAction(
                    post.isliked
                        ? Icons.thumb_up
                        : Icons.thumb_up_alt_outlined,
                    'Like',
                    () => likePost(post),
                    active: post.isliked,
                  ),
                  postAction(
                    Icons.comment_outlined,
                    'Comment',
                    () => openPost(post),
                  ),
                  postAction(
                    Icons.share_outlined,
                    'Share',
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Share is not available in this demo.',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const Divider(
                height: 1,
                thickness: 0.7,
                color: Color(0xFFE1DDE2),
              ),
            ],
          ),
        );
      },
    );
  }
}
