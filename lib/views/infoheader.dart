import 'package:flutter/material.dart';
import '../model/account.dart';

class Infoheader extends StatelessWidget {
  final Account account;
  const Infoheader({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildCount('Followers', account.followers),
          buildCount('Following', account.following),
          buildCount('Posts', account.posts),
        ],
      ),
    );
  }

  Widget buildCount(String title, int count) {
    return Column(
      children: [
        Text(title),
        const SizedBox(height: 7),
        Text('$count', style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
