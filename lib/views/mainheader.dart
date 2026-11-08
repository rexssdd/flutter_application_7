import 'package:flutter/material.dart';
class MainHeader extends StatelessWidget {
 const MainHeader({super.key,required this.username}); final String username;
 @override Widget build(BuildContext context) => Card(child:Padding(padding:const EdgeInsets.all(16),child:Row(children:[
 const CircleAvatar(radius:34,child:Icon(Icons.person,size:38)),const SizedBox(width:14),
 Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(username,style:const TextStyle(fontSize:20,fontWeight:FontWeight.bold),overflow:TextOverflow.ellipsis),const Text('Welcome to your profile')]))
 ])));
}
