import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/userpost.dart';
import '../model/usercomment.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, required this.post, required this.currentUser});
  final SocialPost post;
  final String currentUser;
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _commentController = TextEditingController();
  List<UserComment> _comments = [];
  bool _loading = true;
  bool _saving = false;

  String get _storageKey => 'social_comments_${widget.post.id}';

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  Future<void> _loadComments() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_storageKey);
      final decoded = raw == null ? <dynamic>[] : jsonDecode(raw) as List<dynamic>;
      if (!mounted) return;
      setState(() {
        _comments = decoded.map((item) => UserComment.fromJson(Map<String,dynamic>.from(item as Map))).toList();
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Unable to load saved comments.')));
    }
  }

  Future<void> _addComment() async {
    final message = _commentController.text.trim();
    if (message.isEmpty || _saving || _loading) return;
    setState(() => _saving = true);
    final updated = [..._comments, UserComment(author: widget.currentUser, message: message, date: DateTime.now().toLocal().toString().substring(0, 16))];
    try {
      final prefs = await SharedPreferences.getInstance();
      final success = await prefs.setString(_storageKey, jsonEncode(updated.map((comment) => comment.toJson()).toList()));
      if (!success) throw StateError('Save failed');
      if (!mounted) return;
      setState(() => _comments = updated);
      _commentController.clear();
      FocusScope.of(context).unfocus();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not save comment. Please retry.')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Post Details')),
    body: SafeArea(child: Column(children: [
      Expanded(child: ListView(padding: const EdgeInsets.all(16), children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(backgroundColor: widget.post.color, child: const Icon(Icons.person, color: Colors.white)),
          title: Text(widget.post.author, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(widget.post.time),
        ),
        const SizedBox(height: 8),
        Text(widget.post.caption, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 12),
        Container(height: 190, color: widget.post.color.withValues(alpha: 0.15), child: Icon(widget.post.icon, size: 90, color: widget.post.color)),
        const SizedBox(height: 20),
        Text('Comments (${_comments.length})', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const Divider(),
        if (_loading) const Center(child: CircularProgressIndicator())
        else if (_comments.isEmpty) const Padding(padding: EdgeInsets.all(20), child: Text('No comments yet. Be the first to comment!', textAlign: TextAlign.center))
        else ..._comments.map((comment) => Card(child: ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text(comment.author, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(comment.message),
            Text(comment.date, style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ]),
        ))),
      ])),
      Padding(padding: EdgeInsets.fromLTRB(12, 8, 12, MediaQuery.viewInsetsOf(context).bottom > 0 ? 8 : 12), child: Row(children: [
        Expanded(child: TextField(
          controller: _commentController,
          minLines: 1,
          maxLines: 3,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(hintText: 'Write a comment...', border: OutlineInputBorder(), isDense: true),
          onSubmitted: (_) => _addComment(),
        )),
        const SizedBox(width: 8),
        IconButton.filled(onPressed: (_loading || _saving) ? null : _addComment, icon: _saving
          ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
          : const Icon(Icons.send), tooltip: 'Post comment'),
      ])),
    ])),
  );
}
