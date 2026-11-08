import 'package:flutter/material.dart';

class SocialPost {
  SocialPost({required this.id, required this.author, required this.caption, required this.time, required this.color, required this.icon});
  final String id;
  final String author;
  final String caption;
  final String time;
  final Color color;
  final IconData icon;
  bool liked = false;
}

