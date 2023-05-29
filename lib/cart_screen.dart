import 'package:flutter/material.dart';
import 'package:flutter_application_1/content_screen.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import "package:http/http.dart" as http;
import "dart:convert";



//  int total = 0;
List<String>p_name = <String>[];
List<String>p_image = <String>[];
List<int>p_price = <int>[];
int totals = 0;

class CartScreen extends HookConsumerWidget{
  @override
  Widget build(BuildContext context,WidgetRef ref){
  var total = useState<int>(0);

  useEffect((){
     p_name.clear();
     p_image.clear();
     totals = 0;
  },[]);
   

 var cartData = ref.watch(DataWatch);
    cartData.forEach((data)=>{
      totals += data.price
      
    });


    cartData.forEach((data)=>
      p_name.add(data.name)
      
    );

    cartData.forEach((data)=>
     p_image.add(data.pic)
    );

    cartData.forEach((data)=>
    // p_price.add(data.price)
    total.value += data.price,
    );
    
   
    return Scaffold(
       appBar:  AppBar(
          backgroundColor: Colors.grey,
          leading:IconButton(icon:Icon(Icons.chevron_left),onPressed: ()=>{
            // total = 0,
            Navigator.pop(context)
          },),
          title:Text('Cart List'),
          centerTitle: true,
        ),
        body:Center(
          child:cartData.length == 0 ? 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text("カートに商品がありません",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold))
          ]) : Column(
          //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // for(int i = 0;i < cartData.length;i++)
              for(var data in cartData)
               Card(
                 child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        // child:Image.network("https://vogueword.click/wp-content/uploads/2017/07/c9c2e24f2936f034ec6b012ae5b3f303-e1487363003682.jpg")
                        child:Image.asset(data.pic)

                      ),
                      SizedBox(width:10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text(data.name,style:TextStyle(fontSize: 18)),
                        Padding(
                          padding: EdgeInsets.only(right: 40),
                          child:Text(data.price.toString(),style:TextStyle(fontSize: 18))
                          )
                        
                      ],),
                    ],),
                    IconButton(onPressed:()async{
                      await showDialog(context: context, builder: (BuildContext context){
                           return AlertDialog(
                                title:Text("確認"),
                                content:Text("この商品をカートから削除しても本当によろしいでしょうか？"),
                                actions:[
                                   TextButton(onPressed: (){
                                    ref.read(DataWatch.notifier).removeArray(data);

                                    total.value = 0;
                                    
                                    Navigator.pop(context);
                                  
                                   
                                   }, child: Text("OK")),
                                   TextButton(onPressed: (){
                                    Navigator.pop(context);
                                   }, child: Text("Cancel"))
                                ]
                           );
                      });
                    }, icon: Icon(Icons.delete),color:Colors.green,iconSize: 30,),
                 ],)
               ),
            
               SizedBox(height: 10,),

               Text("Total:"+ "￥" + total.value.toString()+"円",style:TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
               )),

               SizedBox(height: 10,),

               
               Container(
                 decoration: BoxDecoration(
                   color:Colors.redAccent[400],
                   boxShadow: const [
                    BoxShadow(
                      color:Colors.grey,
                      offset:Offset(1.5,2.5),
                      blurRadius:1.5 

                    ),
                   ],
                   borderRadius: BorderRadius.circular(10),
                 ),
                 child:Material(
                  color:Colors.transparent,
                  child: InkWell(
                    onTap: ()async{
                     await showDialog(context: context, builder: (BuildContext context){
      
                        
                          return AlertDialog(
                            title: Text("確認"),
                            content:Text("商品の注文が完了しました"),
                            actions: [
                              TextButton(onPressed:(){

                                   SendData();
                                   ref.read(DataWatch.notifier).clearArray();
                                   total.value = 0;

                                Navigator.pop(context);
                              }, child: Text("Close"))
                            ],
                          );
                      });
                    },
                    child:Container(
                      padding:EdgeInsets.symmetric(horizontal: 12,vertical: 8) ,
                      child:Opacity(
                        opacity: 0.8,
                        child:Text('Buy Now',style:TextStyle(
                        color:Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )),
                        )
                    ),
                  )
                  
                 )
               ),
          ],)
        ),
        bottomNavigationBar: BottomNavigationBar(items:<BottomNavigationBarItem>[
            BottomNavigationBarItem(
            icon: Icon(Icons.store),
            activeIcon: Icon(Icons.store),
            label: 'Home',
            tooltip: "This is a Book Page",
            backgroundColor: Colors.orange,
          ),
             BottomNavigationBarItem(
            icon: Icon(Icons.mail),
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

void SendData()async{
  var send_data = {
    "name" : p_name,
    "price": totals,
    "pic" : p_image,
  };

  print("送信テスト1");
  print(send_data);

  print("送信テスト2");
  print(send_data);

   await http.post(Uri.parse("http://192.168.1.130:3500/additem"),headers:{'Content-Type':'application/json;charset=UTF-8'},body:jsonEncode(send_data));

  //  p_name.clear();
  //  p_image.clear(); 
  //  totals = 0;






  // Map<String,String> headers = {'Content-Type':'application/json;charset=UTF-8'};
  // String body = json.encode(send_data);


  // await http.post(Uri.parse("http://localhost:3500/additem"),headers:headers,body:body);
  // await http.post(Uri.http("http://192.168.1.130","additem"),headers:headers,body:body);
  // await http.post(Uri.http("192.168.1.130","/additem"),headers:headers,body:body);


  
}