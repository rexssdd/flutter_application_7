
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/userpost.dart';
import '../model/usercomment.dart';
import '../model/userdata.dart';

class ProfileView extends StatefulWidget {
  final Userpost userPost;

  const ProfileView({
    super.key,
    required this.userPost,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController commentController =
      TextEditingController();

  final String myProfileImage = Userdata().myUserAccount.img;

  bool loading = true;
  bool sending = false;

  String commentFilter = 'All Comments';

  final Set<int> likedComments = {};
  Timer? commentClock;

  @override
  void initState() {
    super.initState();

    loadComments();

    commentClock = Timer.periodic(
      const Duration(seconds: 30),
      (_) {
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  Future<void> loadComments() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final saved = prefs.getString(
        'comments_${widget.userPost.id}',
      );

      if (saved != null) {
        final items = jsonDecode(saved) as List<dynamic>;

        widget.userPost.comments
          ..clear()
          ..addAll(
            items.map(
              (item) => Usercomment.fromJson(
                Map<String, dynamic>.from(item),
              ),
            ),
          );

        widget.userPost.numcomments =
            '${widget.userPost.comments.length}';
      }
    } catch (_) {
      // Keep sample comments if saved data is invalid.
    }

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> addComment() async {
    final message = commentController.text.trim();

    if (message.isEmpty || loading || sending) {
      return;
    }

    setState(() {
      sending = true;
    });

    final updated = List<Usercomment>.from(
      widget.userPost.comments,
    )..add(
        Usercomment(
          commenter: 'You',
          message: message,
          createdAt: DateTime.now(),
          profileImage: myProfileImage,
        ),
      );

    try {
      final prefs = await SharedPreferences.getInstance();

      final saved = await prefs.setString(
        'comments_${widget.userPost.id}',
        jsonEncode(
          updated.map(
            (comment) => comment.toJson(),
          ).toList(),
        ),
      );

      if (!saved) {
        throw Exception('Unable to save');
      }

      if (!mounted) return;

      setState(() {
        widget.userPost.comments
          ..clear()
          ..addAll(updated);

        widget.userPost.numcomments = '${updated.length}';

        commentController.clear();
      });

      FocusScope.of(context).unfocus();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Unable to save comment. Try again.',
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          sending = false;
        });
      }
    }
  }

  @override
  void dispose() {
    commentClock?.cancel();
    commentController.dispose();
    super.dispose();
  }

  String commentTime(Usercomment comment) {
    if (comment.createdAt == null) {
      return 'Earlier';
    }

    final elapsed = DateTime.now().difference(
      comment.createdAt!,
    );

    if (elapsed.isNegative || elapsed.inSeconds < 60) {
      return 'Just now';
    }

    if (elapsed.inMinutes < 60) {
      return '${elapsed.inMinutes} min ago';
    }

    if (elapsed.inHours < 24) {
      return '${elapsed.inHours} hr ago';
    }

    if (elapsed.inDays < 7) {
      return '${elapsed.inDays} days ago';
    }

    return '${comment.createdAt!.day}/'
        '${comment.createdAt!.month}/'
        '${comment.createdAt!.year}';
  }

  Widget action(
    IconData icon,
    String title,
    VoidCallback onPressed,
  ) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 17,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 7),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commentItem(
    Usercomment comment,
    int index,
  ) {
    final friendImages = {
      for (final friend in Userdata().friendList)
        friend.name.toLowerCase(): friend.img,
    };

    final avatar =
        (comment.profileImage != null &&
                comment.profileImage!.isNotEmpty)
            ? comment.profileImage!
            : comment.commenter.toLowerCase() == 'you'
                ? myProfileImage
                : (friendImages[
                        comment.commenter.toLowerCase()
                      ] ??
                    'assets/person1.jpg');

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        12, 8, 12, 13,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // COMMENT PROFILE IMAGE
          CircleAvatar(
            radius: 19,
            backgroundImage: AssetImage(avatar),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // COMMENT BUBBLE
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0EDF2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.commenter,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        comment.message,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                // COMMENT TIME, LIKE, REPLY
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 6,
                  ),
                  child: Row(
                    children: [
                      Text(
                        commentTime(comment),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(width: 13),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (!likedComments.add(index)) {
                              likedComments.remove(index);
                            }
                          });
                        },
                        child: Text(
                          'Like',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: likedComments.contains(index)
                                ? Colors.blue
                                : Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(width: 13),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            commentController.text =
                                '@${comment.commenter} ';
                          });
                        },
                        child: const Text(
                          'Reply',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.userPost;

    final comments = post.comments
        .asMap()
        .entries
        .toList();

    if (commentFilter == 'Newest') {
      comments.sort(
        (a, b) => b.key.compareTo(a.key),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFAFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFAFF),
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(''),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  // POST HEADER
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      7, 5, 7, 9,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 21,
                          backgroundImage:
                              AssetImage(post.userimg),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.username,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                Text(
                                  post.time,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Icon(
                                  Icons.people,
                                  size: 14,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // POST CAPTION
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      5, 5, 5, 15,
                    ),
                    child: Text(
                      post.postcontent,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  // POST IMAGE
                  Image.asset(
                    post.postimg,
                    fit: BoxFit.contain,
                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {
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
                  ),

                  // COMMENT AND SHARE COUNTS
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${post.comments.length} Comments',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(width: 18),
                        Text(
                          '${post.numshare} Shares',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 1),

                  // POST ACTION BUTTONS
                  Row(
                    children: [
                      action(
                        post.isliked
                            ? Icons.thumb_up
                            : Icons.thumb_up_outlined,
                        'Like',
                        () {
                          setState(() {
                            post.isliked = !post.isliked;
                            post.likes += post.isliked ? 1 : -1;
                          });
                        },
                      ),
                      action(
                        Icons.comment_outlined,
                        'Comment',
                        () {
                          FocusScope.of(context).requestFocus(
                            FocusNode(),
                          );
                        },
                      ),
                      action(
                        Icons.share_outlined,
                        'Share',
                        () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
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

                  const Divider(height: 1),
                  const SizedBox(height: 14),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Text(
                      '${post.comments.length}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),

                  // COMMENT FILTER
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      12, 16, 12, 14,
                    ),
                    child: PopupMenuButton<String>(
                      initialValue: commentFilter,
                      onSelected: (value) {
                        setState(() {
                          commentFilter = value;
                        });
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: 'All Comments',
                          child: Text('All Comments'),
                        ),
                        PopupMenuItem(
                          value: 'Newest',
                          child: Text('Newest'),
                        ),
                      ],
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            commentFilter,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // COMMENTS LIST
                  if (loading)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else if (comments.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(14),
                      child: Text('No comments yet.'),
                    )
                  else
                    for (final entry in comments)
                      commentItem(entry.value, entry.key),
                ],
              ),
            ),

            // COMMENT INPUT
            Container(
              color: const Color(0xFFFFFAFF),
              padding: const EdgeInsets.fromLTRB(
                10, 6, 10, 8,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage:
                        AssetImage(myProfileImage),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: commentController,
                      maxLines: 2,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Write a comment...',
                        isDense: true,
                        filled: true,
                        fillColor: const Color(0xFFF0EDF2),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed:
                        loading || sending ? null : addComment,
                    icon: const Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
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
