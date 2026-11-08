import 'package:flutter/material.dart';
import 'friend.dart';
import 'userpost.dart';
class Userdata {
  static const friends = <Friend>[
    Friend(name:'Alex',imagePath:'assets/person1.png'),
    Friend(name:'Jamie',imagePath:'assets/person2.png'),
    Friend(name:'Taylor',imagePath:'assets/person3.png'),
    Friend(name:'Sam',imagePath:'assets/person4.png'),
    Friend(name:'Casey',imagePath:'assets/person5.png'),
    Friend(name:'Jordan',imagePath:'assets/person6.png'),
  ];
  static List<SocialPost> posts() => [
    SocialPost(id:'post1',author:'Alex Rivera',caption:'Enjoying a beautiful day with friends!',time:'2 hours ago',color:Colors.lightBlue,icon:Icons.landscape),
    SocialPost(id:'post2',author:'Jamie Cruz',caption:'A little progress every day goes a long way.',time:'Yesterday',color:Colors.deepPurple,icon:Icons.auto_awesome),
    SocialPost(id:'post3',author:'Taylor Santos',caption:'Great memories from our weekend adventure!',time:'2 days ago',color:Colors.teal,icon:Icons.park),
  ];
}
