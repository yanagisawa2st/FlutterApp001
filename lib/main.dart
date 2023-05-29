import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_screen.dart';



void main(){
  runApp(ProviderScope(child: MyApp()));
} 

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
      return MaterialApp(
         debugShowCheckedModeBanner: false,
         theme: ThemeData(
           primaryColor: Colors.blueAccent,
         ),
         home: HomeScreen(),
      );
  }
}
   