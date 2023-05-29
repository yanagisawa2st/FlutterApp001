import 'package:flutter/material.dart';
import 'package:flutter_application_1/content_screen.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';



class ShowsPicture{
  ShowsPicture({required this.name,required this.identifer});
  String name;
  List<String>identifer;
  
}



List<ShowsPicture>li = [new ShowsPicture(name: "Parcker", identifer: ["https://outlet-mall.jp/magazine/wp-content/uploads/2021/08/25174802/tyler-nix-6UEyVsw_1lU-unsplash.jpg","https://cdn.shopify.com/s/files/1/0585/5939/8083/files/tyler-nix-6mKxZ5XCw2Y-unsplash_480x480.jpg?v=1638684147","https://www.lifebranding.co.jp/logi-lab//wp-content/uploads/2020/10/a85f417a67153a5fe969e6d70fe9deac-e1603706493463.jpg","https://m.media-amazon.com/images/I/51GDI5vRVhL._AC_UX522_.jpg"]),new ShowsPicture(name: "convers40", identifer: ["https://ds393qgzrxwzn.cloudfront.net/resize/m280x280/cat1/img/present/9c8c/9c8c6600fbe0520fcd597721554032f9.jpg","https://tasclap.k-img.com/icv/450/tasclapimage_1872_2_1.jpg?d=20230501020022","https://tasclap.k-img.com/icv/450/tasclapimage_1872_4_1.jpg?d=20230131115344","https://www.fashion-press.net/img/news/59071/MVk.jpg"]),new ShowsPicture(name: "Black Lather", identifer: ["https://fashion-basics.com/wp-content/uploads/2018/10/6-27.jpg","https://cdn.shopify.com/s/files/1/0585/5939/8083/files/tyler-nix-6mKxZ5XCw2Y-unsplash_480x480.jpg?v=1638684147","https://www.lifebranding.co.jp/logi-lab//wp-content/uploads/2020/10/a85f417a67153a5fe969e6d70fe9deac-e1603706493463.jpg","https://i.pinimg.com/originals/99/93/ca/9993ca17616ded193a528a69275dd2a7.jpg"]),new ShowsPicture(name: "Kargo Pants", identifer: ["https://otokomaeken.com/wp-content/uploads/2018/07/DSC1786a.jpg","https://item-shopping.c.yimg.jp/i/n/jamtrading1_eaa191982","https://images.stylepress.jp/files/article/82074/sp_82074_0.jpg?1554774048","https://arkhe.tokyo/wp-content/uploads/2018/07/NIKON-CORPORATION_NIKON-D800_7490016-7574530_087-min-1024x650.jpg"]),new ShowsPicture(name: "Taghoyer02", identifer:["https://www.pressance.co.jp/yuzusachi/magazine/cms/wp-content/uploads/2020/05/251_ext_01_0-1.jpg","https://img07.shop-pro.jp/PA01402/513/etc/thecitiissyou_title.jpg","https://www.rasin.co.jp/blog/wp-content/uploads/2020/06/0100.jpg","https://citizen.jp/the-citizen/caliber0100/images/product/img_item02_01.jpg"]),new ShowsPicture(name: "White Parker", identifer: ["https://vogueword.click/wp-content/uploads/2017/07/c9c2e24f2936f034ec6b012ae5b3f303-e1487363003682.jpg","https://images.stylepress.jp/files/article/82074/sp_82074_0.jpg?1554774048","https://item-shopping.c.yimg.jp/i/n/jamtrading1_eaa191982","https://kurumani.com/wp-content/uploads/2016/03/51211.jpg"])];

List<String>shps = [];

List<String>profiles = [];

String target = "";

var shd = li.forEach((l)=> shps =l.identifer);
var target_name = li.forEach((l)=> target = l.identifer.first);
   
// var main_picture = useState(target_name);


class DetailPage extends HookConsumerWidget{
  

  DetailPage(this.product);
  Products product;

    
   
  @override 
  Widget build(BuildContext context,WidgetRef ref){

   var shd = li.forEach((l)=> shps =l.identifer);
   
   var data = li.where((l)=>l.name == product.name);

   data.forEach((da)=>profiles = da.identifer);

    data.forEach((da)=> target = da.identifer.first);

    final main_picture = useState<String>(target);

   print(target);
   print(profiles);

   
   print("テスト");
   

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey,
          leading:IconButton(icon:Icon(Icons.chevron_left),onPressed: ()=>{
            Navigator.pop(context)
          },),
          title: Text(product.name),
          centerTitle: true,
        ),
        body:Center(
        child:Column(
          children: [
            SizedBox(height: 20,),
            Card(
              shadowColor: Colors.black,
              elevation:8,
              shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.circular(80)
              ),
              child:Container(
                
                width: 250,
                // child:Image.asset(product.pic)
                child:Image.network(main_picture.value)
              ),
            ),
            Text(product.name,style:TextStyle(fontSize: 30)),
            SizedBox(height: 10,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:Row(children: [
                for(var i = 0;i<4;i++)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child:CircleAvatar(
                  maxRadius: 28,
                  // backgroundImage: NetworkImage('https://tshop.r10s.jp/kabekore/cabinet/mpg2_1/mpg2_002840.jpg?fitin=720%3A720'),
                  backgroundImage: NetworkImage(profiles[i]),
                  child:InkWell(
                    onTap:(){
                       main_picture.value = profiles[i];
                    }
                  )
                )
                )
              ],)
            ),
            SizedBox(height: 20,),
            Text("￥"+product.price.toString()+"円",style:TextStyle(fontSize: 25)),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Material(
                //   color:Colors.amber[700],
                //   shadowColor: Colors.black,
                //   child:  InkWell(
                //   onTap:(){
                //     print("Add Cart!!");
                //   },
                //   splashColor: Colors.white70,
                //   child:Container(
                //     height: 25,
                //     child:Text("Add Cart")
                //   )
                // ),
                // ),
                // SizedBox(width:10),
                // Material(
                //   color:Colors.pinkAccent,
                //   shadowColor: Colors.black,
                //   child:InkWell(
                //     splashColor: Colors.grey[200],
                //     onTap:(){
                //       print("Buy Product");
                //     },
                //     child:Container(
                //       child:Text("Order")
                //     )
                //   )
                // )
                Container(
                  decoration:BoxDecoration(
                    // gradient: LinearGradient(
                    //   colors:[Colors.pink,Colors.white,Colors.pink],
                    // ),
                    color:Colors.pink[400],
                    boxShadow: const [
                      BoxShadow(
                        color:Colors.grey,
                        offset:Offset(1.5,2.5),
                        blurRadius:1.5,
                        spreadRadius: 1
                      ),
                    ],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child:Material(
                    color:Colors.transparent,
                    child:InkWell(
                      onTap:()async{
                        ref.read(DataWatch.notifier).addArray(product);
                        await showDialog<Products>(context: context, builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("メッセージ"),
                            content:Text("商品がカートに追加されました！！"),
                            actions:<Widget>[
                                 TextButton(onPressed:(){
                                    Navigator.pop(context);
                                 }, child: Text("OK"))
                            ],
                          );
                        });
                      },
                      child:Container(
                        padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        child:Text(
                          'Add Cart',
                          style:TextStyle(
                            color:Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            
                          )
                        )
                      )
                    )
                  )
                )
              ],
            )

          ],
        )
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