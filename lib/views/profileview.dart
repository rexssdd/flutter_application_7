import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/userpost.dart';
import '../model/usercomment.dart';

class ProfileView extends StatefulWidget {
  final Userpost userPost;
  const ProfileView({super.key, required this.userPost});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController commentController = TextEditingController();
  bool loading = true;
  bool sending = false;

  @override
  void initState() {
    super.initState();
    loadComments();
  }

  Future<void> loadComments() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? saved = prefs.getString('comments_${widget.userPost.id}');
      if (saved != null) {
        List<dynamic> items = jsonDecode(saved);
        List<Usercomment> loaded = [];
        for (var item in items) {
          loaded.add(Usercomment.fromJson(Map<String, dynamic>.from(item)));
        }
        widget.userPost.comments.clear();
        widget.userPost.comments.addAll(loaded);
        widget.userPost.numcomments = '${loaded.length}';
      }
    } catch (error) {
      // Show the sample comments if saved data cannot be loaded.
    }
    if (mounted) {
      setState(() { loading = false; });
    }
  }

  Future<void> addComment() async {
    String message = commentController.text.trim();
    if (message.isEmpty || sending || loading) return;

    setState(() { sending = true; });
    List<Usercomment> updated = List.from(widget.userPost.comments);
    updated.add(Usercomment(commenter: 'You', message: message));

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> items = [];
      for (Usercomment comment in updated) {
        items.add(comment.toJson());
      }
      bool saved = await prefs.setString(
        'comments_${widget.userPost.id}',
        jsonEncode(items),
      );
      if (!saved) throw Exception('Unable to save comment');
      if (!mounted) return;

      setState(() {
        widget.userPost.comments.clear();
        widget.userPost.comments.addAll(updated);
        widget.userPost.numcomments = '${updated.length}';
        commentController.clear();
      });
      FocusScope.of(context).unfocus();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to save comment. Try again.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() { sending = false; });
      }
    }
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Userpost post = widget.userPost;
    return Scaffold(
      appBar: AppBar(title: const Text('Post Details')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: CircleAvatar(backgroundImage: AssetImage(post.userimg)),
                    title: Text(post.username),
                    subtitle: Text(post.time),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Text(post.postcontent),
                  ),
                  Image.asset(
                    post.postimg,
                    width: double.infinity,
                    height: 230,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(height: 230, child: Icon(Icons.image, size: 60));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Text('${post.likes} likes · ${post.comments.length} comments'),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.all(14),
                    child: Text('Comments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  if (loading)
                    const Center(child: CircularProgressIndicator())
                  else if (post.comments.isEmpty)
                    const Padding(padding: EdgeInsets.all(14), child: Text('No comments yet.'))
                  else
                    for (Usercomment comment in post.comments)
                      ListTile(
                        leading: const CircleAvatar(child: Icon(Icons.person)),
                        title: Text(comment.commenter),
                        subtitle: Text(comment.message),
                      ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: commentController,
                      minLines: 1,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Write a comment...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: sending || loading ? null : addComment,
                    icon: const Icon(Icons.send, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
