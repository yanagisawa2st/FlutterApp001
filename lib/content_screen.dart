

import 'dart:convert';

import 'package:flutter/material.dart';
import 'detaile_screen.dart';
import 'package:badges/badges.dart' as badges;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'cart_screen.dart';
import 'message_screen.dart';
import 'package:http/http.dart' as http;

class Items{
  Items({required this.icons,required this.name,required this.colors,required this.imgs});
  IconData icons;
  String name;
  Color colors;
  String imgs;
}

class Products{
  Products({required this.name,required this.price,required this.pic});
  String name;
  int price;
  String pic;
  
}

class Msg{
  Msg({required this.title,required this.description});
  List<String> title;
  List<String> description;
}

class checkMsg{
  checkMsg({required this.msgCount,required this.chTitle,required this.chMsg});
  int msgCount;
  bool chTitle;
  bool chMsg;
}

class msgStore{
  msgStore({required this.id,required this.title,required this.description,required this.checked});
  String id;
  String title;
  String description;
  bool checked;
}



class DataArray extends StateNotifier<List<Products>>{


  DataArray():super([]);
  void addArray(Products pro){
    state = [...state,pro];
  }

  void removeArray(Products pro){
  //  var newArray = state.where((sta)=>sta.pic != pro.pic);
  //  state = state[newArray]

  state = [
    for(final item in state)
      if(item.pic != pro.pic) item,
  ];
  }

  void clearArray(){
    if(state.length > 0){
       state.clear();
      
      state = [];
    }
  }
}

class MsgData extends StateNotifier<int>{
    MsgData():super(0);

    List<String>li = [];

    void addNotifi(int msgCount){
     

      
      state = msgCount;
    }

    void removeNotifi(int msgsCount){
      if(state > 0){
         state -= msgsCount;
      }
    }

    
}

class MsgList extends StateNotifier<List<msgStore>>{
    MsgList():super([]);

    void addMsg(msgStore store){
       state = [...state,store];
    }

    void deleteMsg(msgStore store){
      state = [
        for(final s in state)
        if(s.id != store.id)s,
      ];
    }
    void countMsg(){
      state = [...state];
    }
}



var DataWatch = StateNotifierProvider<DataArray,List<Products>>((ref){
   return DataArray();
}
);

var NotifiWatch = StateNotifierProvider<MsgData,int>((ref) {
  return MsgData();
},);

var msgWatch = StateNotifierProvider<MsgList,List<msgStore>>((ref){
  return MsgList();
});



List<Widget>icons = <Widget>[];
List<String>names = <String>[];
List<Color>cls = <Color>[];
List<String>imgs = <String>[];

List<String>pro_name = <String>[];
List<int>pro_price = <int>[];
List<String>pro_pic = <String>[];

List<String>msg_id = <String>[];
List<String>msg_title = <String>[];
List<String>msg_description = <String>[];
List<bool>msg_bool = <bool>[];




class ContentScreen extends HookConsumerWidget{
  

  @override
  Widget build(BuildContext context,WidgetRef ref){
   Items info;
   msgStore store;

   List<msgStore>msgList;
   
   List<Items>types = [new Items(icons:Icons.man,name:"Men",colors:Colors.blue,imgs:"fashion01.webp"),new Items(icons:Icons.woman,name:"Woman",colors:Colors.pinkAccent,imgs:"fashion05.jpg"),new Items(icons: Icons.checkroom,name:"Fashion",colors:Colors.green,imgs:"fashion04.jpg"),new Items(icons:Icons.watch,name:"Watch",colors:Colors.purpleAccent,imgs:"watch01.jpg"),new Items(icons:Icons.roller_skating,name:"shoes",colors:Colors.brown,imgs:"shoes04.jpg")];
   List<Products>products = [new Products(name:"Parcker",price:50000,pic: "images/newfashion07.jpg"),new Products(name: "convers40", price: 8000, pic: "images/shoes01.jpg"),new Products(name: "Black Lather", price: 59000, pic: "images/fashion09.jpg"),new Products(name:"Kargo Pants", price: 4000, pic: "images/newfashion04.jpg"),new Products(name: "Taghoyer02", price: 888000, pic: "images/watch04.jpg"),new Products(name: "White Parker", price: 97000, pic: "images/fashion06.webp")];
   var name = "Outer";

   
   var n_watch = ref.watch(NotifiWatch);
   var msg_watch = ref.watch(msgWatch);

   
   void countNotifi()async{
      var webdata = await http.get(Uri.parse("http://192.168.1.130:3500/get/msg"));

       if(webdata.statusCode == 200){
          var remsg = jsonDecode(webdata.body);
          print("受信数");
          print(remsg.length);

          ref.read(NotifiWatch.notifier).addNotifi(remsg.length);

          for(int i=0;i<remsg.length;i++){
             print(remsg[i]['_id']);
             print(remsg[i]['title']);
             print(remsg[i]['description']);
             ref.read(msgWatch).add(new msgStore(id: remsg[i]['_id'], title: remsg[i]['title'], description: remsg[i]['description'], checked: true));
          }
       }
   }

   

   useEffect((){
    countNotifi();
   },[]);


   for(Items itm in types){
      icons.add(Icon(itm.icons));
      names.add(itm.name);
      cls.add(itm.colors);
      imgs.add(itm.imgs);
   }

   for(Products pr in products){
     pro_name.add(pr.name);
     pro_price.add(pr.price); 
     pro_pic.add(pr.pic);
   }

   var d_watch = ref.watch(DataWatch);
   var arrayCount = d_watch.length;
   
   print("クラスのデータの確認");
   msg_watch.forEach((msg){
      print(msg.id);
   });
   print(msg_watch.length);
   
   


   
   
    return(
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          leading:IconButton(icon:Icon(Icons.chevron_left),onPressed: ()=>{
            Navigator.pop(context)
          },),
          title: Text('Menu'),
          centerTitle: true,




          actions:[
            Padding(padding: EdgeInsets.only(right:8,top:5),
            child:arrayCount > 0 ? badges.Badge(
              badgeStyle: badges.BadgeStyle(badgeColor: Colors.purple),
              position: badges.BadgePosition.topEnd(top:-8,end:-1),
              badgeContent: Text(arrayCount.toString(),style:TextStyle(color:Colors.white)),
              child:IconButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>CartScreen())
                );
              },icon:Icon(Icons.shopping_cart))
            ) : IconButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>CartScreen())
              );
            },icon:Icon(Icons.shopping_cart))
            )
            ,
          ]
        ),
        body:Column(
          children: [
            SizedBox(height:15),
            Opacity(opacity: 0.8,
            child:SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              
              child:Row(
                children:[
                   
                   for(var i = 0;i<types.length;i++)
                    Padding(padding:EdgeInsets.symmetric(horizontal: 3),
                    child:CircleAvatar(
                      
                      backgroundColor: cls[i],
                      maxRadius: 43,
                      
                    //  backgroundImage: NetworkImage(imgs[i]),


                      
                      
                      child:Column(
                        
                        children:[
                          SizedBox(height: 10),
                          Text(names[i],style:TextStyle(fontSize: 20,color:Colors.amberAccent[700])),
                          IconButton(onPressed:(){}, icon: icons[i]),
                          SizedBox(height: 5),
                          
                        ]
                      ),
                      
                    ),
              ),
                    SizedBox(width: 10,)
                ]
              ),
            ),
          ),
          SizedBox(height:15),
          Center(
            child:Text("New",style:TextStyle(fontSize: 30,color:Colors.grey[600],fontWeight: FontWeight.w700))
          ),
          SizedBox(height: 10,),
         Expanded(
          child:GridView.count(crossAxisCount: 2,mainAxisSpacing: 4,crossAxisSpacing: 8, 
          
          children: [
           
            for(var i = 0;i<products.length;i++)
             
                Card(
                  shadowColor: Colors.black,
                  elevation:8,
                  child:InkWell(
                       onTap:(){
                         print(products[i].name);
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder:(context)=>DetailPage(products[i]))
                         );
                       },
                      child:Container(
                    decoration: BoxDecoration(
                      image:DecorationImage(
                        image:AssetImage(pro_pic[i]),
                        fit:BoxFit.cover
                      )
                    ),
                    child:Container(
                      child: Stack(
                        children:[
                          
                          Align(
                            alignment: Alignment.topLeft,
                            child:Container(
                              color:Colors.grey[600],
                              height: 25,
                              width: 70,
                              child:Text(pro_name[i],style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 18))
                            ),
                            ),
                          SizedBox(height: 10,),
                          Align(alignment: Alignment.bottomRight,
                           child: Container(
                            // color: Colors.redAccent,
                            height: 25,
                            width: 70,
                            child:Text("￥"+pro_price[i].toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color:Colors.red),)
                           ),
                          )
                        ]
                      )
                    )
                    )
                    
                  )
                  ),
              
                
           
            
          ],))
          ]
        
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
            icon:n_watch > 0 ? badges.Badge(
              badgeContent:Text(n_watch.toString()),
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
      )
      
    );
  }
    
  
}


