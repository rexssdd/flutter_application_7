import 'usercomment.dart';

class Userpost {
  String id;
  String userimg;
  String username;
  String time;
  String postcontent;
  String postimg;
  String numcomments;
  String numshare;
  bool isliked;
  int likes;
  List<Usercomment> comments;

  Userpost({
    required this.id,
    required this.userimg,
    required this.username,
    required this.time,
    required this.postcontent,
    required this.postimg,
    required this.numcomments,
    required this.numshare,
    required this.isliked,
    this.likes = 0,
    List<Usercomment>? comments,
  }) : comments = comments ?? [];
}
