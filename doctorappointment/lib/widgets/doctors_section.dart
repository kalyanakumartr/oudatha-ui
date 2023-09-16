import 'dart:convert';
import 'package:doctorappointment/screens/appoint_screen.dart';
import 'package:doctorappointment/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/CategoriesModel.dart';

   //List <dynamic> user;
class DoctorsSection extends StatefulWidget {
  const DoctorsSection({super.key, });

  @override
  State<DoctorsSection> createState() => _DoctorsSectionState();
  // final List <dynamic> username;
 
}

   //const DoctorsSection({super.key});


  // DoctorsSection({super.key, required this.username});
 @override
  void initState() {
    //user = widget.username;
    //var username=searchDoc;
  //   searchDoc=doctortype;
  //   //print(user!['DocName'].toString());
  //   // TODO: implement initState
  //   super.initState();
   }

class _DoctorsSectionState extends State<DoctorsSection> {
  @override
  Widget build(BuildContext context) {
   return Container(
      height: 340,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount:docImage.length,
        itemBuilder: (context, index){
          return Column(
            children: [
              Container(
                height: 300,
                width: 200,
                margin:EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFF2F8FF),    
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      spreadRadius: 2,
                    ),
                  ] ,         
                  ),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context)=> AppointScreen(username: docImage[index],)
                                ));
                              },
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                             child: docImage[index]['gender'] == 'female'?Image.asset(
                              "images/doctor3.jpeg",
                              height: 220,  
                              width: 220,
                              fit: BoxFit.cover,)
                              :Image.asset(
                              "images/doctor1.jpeg",
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                               ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              margin: EdgeInsets.all(8),
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: Color(0xFFF2F8FF),
                                shape:BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child:Center(
                                child: Icon(
                                  Icons.favorite_outline,
                                  color: Colors.blue,
                                  size: 28,
                                  ),
                              ),
                              ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                             docImage[index]['DocName'], 
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                              )
                            ),
                            Text(                    
                              docImage[index]['categoryId'].toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color:Colors.amber,
                                ),
                                SizedBox(width: 5),
                            Text(
                             docImage[index]['docexpreience'].toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                              ],
                            ),
                            
                          ],
                          ),
                        ),
                    ],
                  )
              )
            ],
          );
        }
        ),
    );
  }

  }


// class DoctorsSection extends StatelessWidget {
  
//   final List <dynamic> username;
//   //const DoctorsSection({super.key});


//    DoctorsSection({super.key, required this.username});
//  @override
//   void initState() {
//     user = widget.username;
//   //   searchDoc=doctortype;
//   //   //print(user!['DocName'].toString());
//   //   // TODO: implement initState
//   //   super.initState();
//   // }
 
  
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 340,
//       child: ListView.builder(
//         shrinkWrap: true,
//         scrollDirection: Axis.horizontal,
//         itemCount: widget.username.length,
//         itemBuilder: (context, index){
//           return Column(
//             children: [
//               Container(
//                 height: 300,
//                 width: 200,
//                 margin:EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//                 decoration: BoxDecoration(
//                   color: Color(0xFFF2F8FF),    
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 4,
//                       spreadRadius: 2,
//                     ),
//                   ] ,         
//                   ),
//                   child:Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Stack(
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               Navigator.push(context, MaterialPageRoute(
//                                 builder: (context)=> AppointScreen(username: docImage[index],)
//                                 ));
//                               },
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(15),
//                                 topRight: Radius.circular(15),
//                               ),
//                              child: docImage[index]['gender'] == 'female'?Image.asset(
//                               "images/doctor3.jpeg",
//                               height: 220,  
//                               width: 220,
//                               fit: BoxFit.cover,)
//                               :Image.asset(
//                               "images/doctor1.jpeg",
//                               height: 200,
//                               width: 200,
//                               fit: BoxFit.cover,
//                                ),
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment.topRight,
//                             child: Container(
//                               margin: EdgeInsets.all(8),
//                               height: 45,
//                               width: 45,
//                               decoration: BoxDecoration(
//                                 color: Color(0xFFF2F8FF),
//                                 shape:BoxShape.circle,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black12,
//                                     blurRadius: 4,
//                                     spreadRadius: 2,
//                                   ),
//                                 ],
//                               ),
//                               child:Center(
//                                 child: Icon(
//                                   Icons.favorite_outline,
//                                   color: Colors.blue,
//                                   size: 28,
//                                   ),
//                               ),
//                               ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 8),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 5),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               docImage[index]['DocName'],
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.blue,
//                               )
//                             ),
//                             Text(                    
//                               docImage[index]['categoryId'].toString(),
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.black.withOpacity(0.6),
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Row(
//                               children: [
//                                 Icon(
//                                   Icons.star,
//                                   color:Colors.amber,
//                                 ),
//                                 SizedBox(width: 5),
//                             Text(
//                              docImage[index]['docexpreience'].toString(),
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.black.withOpacity(0.6),
//                               ),
//                             ),
//                               ],
//                             ),
                            
//                           ],
//                           ),
//                         ),
//                     ],
//                   )
//               )
//             ],
//           );
//         }
//         ),
//     );
//   }

//   }
// }