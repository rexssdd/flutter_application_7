import 'package:flutter/material.dart';
import '../model/friend.dart';

class Friendlist extends StatelessWidget {
  final List<Friend> friends;
  const Friendlist({super.key, required this.friends});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.86,
      ),
      itemCount: friends.length,
      itemBuilder: (context, index) {
        Friend friend = friends[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: SizedBox(
                    width: 76,
                    height: 76,
                    child: Image.asset(
                      friend.img,
                      width: 76,
                      height: 76,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      errorBuilder: (context, error, stackTrace) {
                        return const ColoredBox(
                          color: Color(0xFFE9EDF2),
                          child: Icon(Icons.person, size: 42),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  friend.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
