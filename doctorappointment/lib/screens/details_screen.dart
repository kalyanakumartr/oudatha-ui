
import 'package:flutter/material.dart';
Map< String,dynamic>? user;
 
class DetailScreen extends StatefulWidget {
  //const DetailScreen({super.key, required details});
 final Map< String,dynamic> username;
 
  DetailScreen(this.username);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  
  //PatientDetails();
@override
  void initState() {
    user=widget.username;
    print(user!['username'].toString());
   
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body:SingleChildScrollView(
      child:Center(
      child:Column(
        children: [
          SizedBox(height:50),
          CircleAvatar( radius: 100,
           child:CircleAvatar(
            radius:100,
            //backgroundColor: Colors.blue,
            backgroundImage:NetworkImage(user!['image'].toString()),
            // NetworkImage(user!['image']),
            // AssetImage("images/doctor1.jpeg")
            ),

            ),
         SizedBox(height:30),
         Text(user!['username'].toString(),
         style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,),
                            ),
        SizedBox(height:30),             
         Text(user!['email'].toString(),
         style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,),
                            ),
                             SizedBox(height:30),             
         Text(user!['phonenumber'].toString(),
         style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,),
                            ),
          Container(
            margin: EdgeInsets.only(top: 250),
            height:500,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft:Radius.circular(24) ,
                topRight: Radius.circular(24),
               
              
                )
               ),
          )
        ],
      )
    )
    )
    );
  }
}










