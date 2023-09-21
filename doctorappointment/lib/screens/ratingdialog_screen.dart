import 'dart:convert';
import 'dart:math';
import 'package:doctorappointment/common/common.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/sharedPreferences.dart';
final shareddata = SharedPref();

List<dynamic> resultDetail = [];
class RatingView extends StatefulWidget {
  const RatingView({super.key,} );
 
 

  @override
  State<RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> with common {
SharedPreferences? prefs;
var ratingPageController=PageController();
var commentController=TextEditingController();
var starPosition = 200.0;
int rating=0;
int ? appId;

@override
  void initState() {
        transferdata();    
   // TODO: implement initState
    super.initState();
   
  }
   
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      clipBehavior: Clip.antiAlias,
      child:Stack(
        children: [
          Container(
            height: max(300, MediaQuery.of(context).size.height*0.3),
            child:PageView(
              controller: ratingPageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                part1(),
                 part2(),
              
                      
              ],
          
            )
          ),
           Positioned(
                bottom: 0,left: 0,right:0,
                 child:Container(
                  color: Colors.blue,
                  child: MaterialButton(
                     onPressed: (){
                      
                     postRating(rating ,commentController.text,appId!);
                     if(rating>0 && commentController.text.isNotEmpty){
                       Navigator.of(context).pop();
                      showdialog(context, "Thank You");
                     }
                   else {
                     showdialog(context, "Please Enter Some Value");
                    
                   }
                     setState(() {
                       rating=0;
                     });
                  
                   commentController.clear();
                     },
                    child:Text("OK",
                    style:TextStyle(
                  // color: Colors.blue,
                  fontSize: 18,
                ),),
                      textColor: Colors.white,
                    ),
                ),
                ),
                Positioned(
                  right:0,
                  child: MaterialButton(
                    onPressed: (){
                    Navigator.of(context).pop();
                    },
                    child: Text("Skip",
                    style:TextStyle(
                  // color: Colors.blue,
                  fontSize: 18,)

                    ),
                     textColor: Colors.blue,
                    )
                    ),
                    // AnimatedPositioned(
                    //   top:starPosition,
                    //   left:0,right:0,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: List.generate(5
                    //     , (index) => IconButton(
                    //        icon: index< rating ?Icon(Icons.star,size:30):Icon(Icons.star_border,size:30),
                    //       color:Colors.blue,
                    //       onPressed: (){
                    //         // ratingPageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                    //         setState(() {
                    //           starPosition = 20.0;
                    //           rating = index+1;

                    //         });
                    //       }, 
                         
                    //       )),
                    //   ), duration: Duration(milliseconds: 300),
                    //   ),
                    Positioned(
                      // top:starPosition,
                      left:0,right:0,bottom:130,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5
                        , (index) => IconButton(
                           icon: index< rating ?Icon(Icons.star,size:30):Icon(Icons.star_border,size:30),
                          color:Colors.blue,
                          onPressed: (){
                            setState(() {
                               rating = index+1;

                            });
                          }, 
                         
                          )),
                      ),
                      ),
                      SizedBox(height: 10),
                       Padding(
                      padding:
                          EdgeInsets.fromLTRB(20,180,20,20),
                          // only(top:190,left:20,right:20,bottom:30),
                      child: TextFormField(
                        controller: commentController,
                        // maxLength: 100,
                        decoration: InputDecoration(
                           border: OutlineInputBorder(),
                          labelText: "Your Comments here",
                          // prefixIcon: Icon(Icons.person),
                        ),
                        // validator: (val) {
                        //   if (val!.isEmpty ||
                        //       !RegExp(r'^[a-z A-Z 0-9]+$').hasMatch(val)) {
                        //     return "Please enter some value";
                        //   }
                        //   return null;
                        // },
                      ),
                    ),

        ],)
    );
  }

part1(){
  return Column(
    // Padding(
    //  padding: EdgeInsets.only(top: 10),),
     mainAxisSize: MainAxisSize.min,
       mainAxisAlignment: MainAxisAlignment.start,
   
    children: [
     
      Padding(padding: EdgeInsets.all(25)),
      Text("Rate us Your Experience with",
      style:TextStyle(
          color: Colors.black,
                  fontSize: 20,
      )),
      Text(  
        //  "Doc",
          "Dr "+
         resultDetail[0]['userName'].toUpperCase(),
      style:TextStyle(
          color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
      )
      ),
      Text(
        // "designation",
         resultDetail[0]['designation'],
     
      ),
      Text(
          // "Consulted on",
           "Consulted on  "+ resultDetail[0]['appointmentDate'] +   "  at  "+ resultDetail[0]['slot']
        )
      
      
    ],
    

  );

}
part2(){
  return Container();

}



  void transferdata() async {
    final patdet = await shareddata.getpatdata();
    setState(() {
         appId=patdet.appId;    
      
      print("appId:"+appId.toString());
      
      
      
    });
  }

}

// }