import 'package:flutter/material.dart';
import '../model/userdata.dart';
class FriendList extends StatelessWidget {const FriendList({super.key});
 @override Widget build(BuildContext context) => GridView.builder(
  shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),itemCount:Userdata.friends.length,
  gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,crossAxisSpacing:8,mainAxisSpacing:8,childAspectRatio:0.95),
  itemBuilder:(context,index){final friend=Userdata.friends[index];return Card(child:Padding(padding:const EdgeInsets.all(5),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
   CircleAvatar(radius:27,child:ClipOval(child:Image.asset(friend.imagePath,width:54,height:54,fit:BoxFit.cover,errorBuilder:(_,__,___)=>const Icon(Icons.person,size:30)))),
   const SizedBox(height:7),Text(friend.name,textAlign:TextAlign.center,maxLines:1,overflow:TextOverflow.ellipsis)
  ])));});
}
