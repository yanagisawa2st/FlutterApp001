import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/content_screen.dart';
import 'package:riverpod/riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart' as badges;
import 'dart:convert' as convert;




var items;

class MessageScreen extends HookConsumerWidget{
  @override
  Widget build(BuildContext context,WidgetRef ref){

   var li1 = useState<List<String>>([]);
   var li2 = useState<List<String>>([]);

   var counts = useState(0);

   var notifi = ref.watch(NotifiWatch);
  // var msgCount = ref.watch(msgWatch);

  // print(msgCount.length);

  // msgCount.forEach((msg){
  //   print(msg.title);
  // });
   
   var cheked = useState<bool>(true);
  

    start()async{
    var webdata = await http.get(Uri.parse("http://192.168.1.130:3500/get/msg"));
    if(webdata.statusCode == 200){
      print(webdata.body);
      var decode = jsonDecode(webdata.body);

    
       print(decode.length);
       print(decode);
      //  items = decode[0]['message'];
   
    

       for(int i = 0;i<decode.length;i++){
       
          li1.value.add(decode[i]['title']);
          li2.value.add(decode[i]['description']);
        
        
       }

       print("配列の値："+ li1.value.toString());
      
      
       counts.value = decode.length;
       

      ref.read(NotifiWatch.notifier).addNotifi(decode.length);
    
     print(decode.runtimeType);

  
      
    }
  
}
     
  

    useEffect((){
     start();
   
    },[]);
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.grey,
          leading:IconButton(icon:Icon(Icons.chevron_left),onPressed: ()=>{
            Navigator.pop(context)
          },),
          title: Text('Message'),
          centerTitle: true,
      ),
      body:Center(
        child:counts.value > 0 ? Column(children: [
          SizedBox(height: 15,),
          for(int i=0;i<counts.value;i++)
       
       Card(
            shadowColor: Colors.grey,
            elevation:5,
            child:Center(
              child:InkWell(
                onTap: (){},
                child:Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              width: 500,
              height:40,
              child: InkWell(
                onTap: (){
                   showDialog(context: context, builder: (BuildContext context){
                        return AlertDialog(
                           title: Text(li1.value[i]),
                           content:SingleChildScrollView(
                            child:Container(
                              width: 400,
                              child:ListBody(children: [
                              Column(children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                
                                  child:Text("Memo：",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                                ),
                                SizedBox(height: 10,),
                                Text(li2.value[i]),
                                SizedBox(height: 400)
                              ],)
                            ],)
                            )
                           ),
                           actions:[
                            TextButton(onPressed:(){
                              cheked.value = false;
                              Navigator.pop(context);
                            }, child: Text("close",style:TextStyle(fontSize: 20)))
                           ]
                        );
                   });
                },
                child:Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                   Container(
                     width: 360,
                      child: Text("Title："+li1.value[i],style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.green[300],overflow: TextOverflow.ellipsis)),
              // child: Text("Title："+"　テストメール",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
              // child: Text("Title："+data.value,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                   ),
                 
                 badges.Badge(
                  badgeStyle: badges.BadgeStyle(badgeColor: Colors.transparent),
                  badgeContent:cheked.value ? Text("new",style: TextStyle(color:Colors.pinkAccent,fontSize: 15)
                  ) : Text(""),
                 )
                 
                ],)
              )


            )
              )
            )
          ),
        
       
          SizedBox(height: 20,),
        ],)
        
         : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Text("メッセージはありません",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
        ],)
      ),
      bottomNavigationBar: BottomNavigationBar(items:  <BottomNavigationBarItem>[
            // BottomNavigationBarItem(icon: Icons.store,activeIcon: Icons.store,label:'Home',tooltip: "Online",backgroundColor: Colors.orange),
                BottomNavigationBarItem(
            icon: Icon(Icons.store),
            activeIcon: Icon(Icons.store),
            label: 'Home',
            tooltip: "This is a Book Page",
            backgroundColor: Colors.orange,
          ),
             BottomNavigationBarItem(
            icon:notifi > 0 ? badges.Badge(
              badgeContent:Text(notifi.toString()),
              position:badges.BadgePosition.topEnd(top:-8,end:-1),
              child:IconButton(onPressed: (){
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>MessageScreen())
                 );
              },icon:Icon(Icons.mail)),
               ) : IconButton(onPressed: (){
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>MessageScreen())
                 );
              },icon:Icon(Icons.mail)),
            activeIcon: Icon(Icons.mail),
            label: 'Message',
            tooltip: "This is a Book Page",
            backgroundColor: Colors.orange,
          ),
             BottomNavigationBarItem(
            icon: Icon(Icons.call),
            activeIcon: Icon(Icons.store),
            label: 'Book',
            tooltip: "This is a Book Page",
            backgroundColor: Colors.orange,
          ),
             BottomNavigationBarItem(
            icon: Icon(Icons.map),
            activeIcon: Icon(Icons.store),
            label: 'Map',
            tooltip: "This is a Book Page",
            backgroundColor: Colors.orange,
          ),
          
         
         

        ]),
    );
  }
}

