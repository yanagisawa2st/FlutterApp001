import 'package:flutter/material.dart';
import 'content_screen.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return(
      Scaffold(
        body:Opacity(opacity: 0.9,
        child:Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image:AssetImage("images/fashion08.jpg"),
              fit:BoxFit.cover,
            )
          ),
          child:Center(
            child:Column(
              children:[
                SizedBox(
                  height: 500,
                ),
               Container(
                //  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child:Text('Wild out',style:TextStyle(
                  color: Colors.amber[900],
                  // color:Colors.grey[350],
                  fontWeight:FontWeight.w600,
                  fontFamily: 'Murecho',
                  fontSize: 40,
                  backgroundColor: Colors.brown[900],
                
                )),
               ),
                Column(children: [
                 SizedBox(height: 50),
               
                 SizedBox(
                   width:100,
                   child: ElevatedButton(
                    style:ElevatedButton.styleFrom(
                      primary: Colors.orangeAccent,
                      
                    ),
                    onPressed: (){
                       Navigator.push(
                          context,
                          MaterialPageRoute(builder:(context)=>ContentScreen()),
                       );
                  }, child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 18)))),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                    Text('if you dont have a account,',style:TextStyle(color:Colors.white,fontSize: 15)),
                    InkWell(
                      onTap: ()=>{},
                      child:Container(
                        child:Text('Please go to the Sin out page',style:TextStyle(color:Colors.blue[700],fontWeight: FontWeight.bold,fontSize: 15)),
                      )
                    )
                    ]
                  ),
                  SizedBox(height: 40,),
                  Text('Go to Sign Out Page ',style:TextStyle(color:Colors.pinkAccent,fontWeight: FontWeight.w500,fontSize: 16))
                ],)
              ]
            )
          )
       ),
        ),
      )
    );
  }
}