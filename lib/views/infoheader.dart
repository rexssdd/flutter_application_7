import 'package:flutter/material.dart';
class InfoHeader extends StatelessWidget {const InfoHeader({super.key});
 @override Widget build(BuildContext context) => const Card(child:Padding(padding:EdgeInsets.symmetric(vertical:18),child:Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children:[_Stat('Followers','1.2K'),_Stat('Following','340'),_Stat('Posts','3')])));
}
class _Stat extends StatelessWidget {const _Stat(this.label,this.value);final String label,value;
 @override Widget build(BuildContext context)=>Column(children:[Text(value,style:const TextStyle(fontSize:18,fontWeight:FontWeight.bold)),Text(label)]);
}
