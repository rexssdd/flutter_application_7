import 'package:flutter/material.dart';
import '../model/account.dart';

class Mainheader extends StatelessWidget {
  final Account account;
  const Mainheader({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
      child: Column(
        children: [
          CircleAvatar(radius: 43, backgroundImage: AssetImage(account.img)),
          const SizedBox(height: 10),
          Text(account.name, textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
          const SizedBox(height: 3),
          Text(account.email, textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }
}
