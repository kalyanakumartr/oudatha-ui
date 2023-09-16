import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:doctorappointment/common/common.dart';
import 'package:doctorappointment/models/CategoriesModel.dart';
import 'package:doctorappointment/screens/appoint_screen.dart';
import 'package:doctorappointment/screens/dental_screen.dart';
import 'package:doctorappointment/screens/login_screen.dart';
import 'package:doctorappointment/screens/patient_details_screen.dart';
import 'package:doctorappointment/screens/profilepictureupload_screen.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doctorappointment/common/sharedPreferences.dart';
import '../screens/ratingdialog_screen.dart';
final shareddata = SharedPref();

Map<String, dynamic>? DoctorList;
var userdata;
List<dynamic> doctortype = [];
List<dynamic> doctorlist = [
  {"doctype": "Dental"},
  {"doctype": "Ophthalmologist"},
  {"doctype": "ENT"},
  {"doctype": "Neurologist"},
  {"doctype": "Cardiologist"}
];
List<dynamic> docImage = [];

enum SampleItem { itemOne, itemTwo, itemThree }

SharedPreferences? prefs;

class HomeScreen extends StatefulWidget {
  // const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with common {
  SampleItem? selectedMenu;
  static List<String> catNames = ["Dental", "Cardiologist", "Ophthalmologist", "Neurologist", "ENT"];
  static List<int> categoryType = [1, 2, 3, 4, 5];
  int? categoryId;
  int? userId;
  String? name;
  String?  gender;
  int?  stsId;
  int? appId;
  


  static List<Icon> catIcons = [
    Icon(MdiIcons.toothOutline, color: Colors.blue, size: 30),
    Icon(MdiIcons.heartPlus, color: Colors.blue, size: 30),
    Icon(MdiIcons.eye, color: Colors.blue, size: 30),
    Icon(MdiIcons.brain, color: Colors.blue, size: 30),
    Icon(MdiIcons.earHearing, color: Colors.blue, size: 30),
  ];

  int index = 0;
  final List<CategoriesDataModel> categorydata = List.generate(
      catNames.length,
      (index) => CategoriesDataModel('${catNames[index]}', '${catIcons[index]}',
          '${catNames[index]} description...', 'userId'));

  Future<void> _refresh() {
    return Future.delayed(const Duration(seconds: 3));
  }

  @override
  void initState() {
     
   searchDoc = docImage;
   
     transferdata();
     getDocList();
   // TODO: implement initState
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
final a=userId;
print("&&"+a.toString());
    return Scaffold(
        appBar: AppBar(title:  Text("Hi,   " + name.toString().toUpperCase()), actions: [
          PopupMenuButton<SampleItem>(
            initialValue: selectedMenu,
            // Callback that sets the selected popup menu item.
            onSelected: (value) async {
              // setState(() {
              //   selectedMenu = item;

              // });
              switch (value) {
                case SampleItem.itemOne:
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (c) => PatientDetails()));
                  // // }
                  break;

                case SampleItem.itemTwo:
                  // TODO: Handle this case.
                  prefs = await SharedPreferences.getInstance();
                  await prefs?.clear();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (c) => LoginScreen()),
                      (route) => false);
                  break;
                case SampleItem.itemThree:
                  // TODO: Handle this case.
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
              // const PopupMenuItem<SampleItem>(
              //   value: SampleItem.itemOne,
              //   child: Text('Patient details'),
              // ),
              const PopupMenuItem<SampleItem>(
                value: SampleItem.itemTwo,
                child: Text('Logout'),
              ),
              // const PopupMenuItem<SampleItem>(
              //   value: SampleItem.itemThree,
              //   child: Text('Item 3'),
              // ),
            ],
            // onSelected : (value){

            // }
          ),
        ]),
        body: Center(
          
            //color: Color(0xFFD9E4EE),
            child: RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.withOpacity(0.8),
                          Colors.blue.withOpacity(0.8),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                    ProfilePicture(username: userId,)));
                                    },
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                      
                                          NetworkImage('http://192.168.1.4:3002/users/getuserimagefromlocal?id=45'),
                                      // gender ==
                                      // 'female'?
                                      //     AssetImage("images/female.jpg")
                                      //     :AssetImage("images/male.jpeg"),
                                            
                                    ),
                                  ),
                                
                                  Icon(
                                    Icons.notifications_outlined,
                                    
                                    color: Colors.white,
                                    size: 25,
                                    
                                  ),
                                  
                                ],
                              ),
                               SizedBox(height: 10),
                              // Text(
                              //   "hi",
                              //   style: TextStyle(
                              //     color: Colors.white,
                              //     fontSize: 12,
                              //     fontWeight: FontWeight.w500,
                              //   ),
                              // ),
                              // SizedBox(height: 10),
                              Text(
                                "Your Health is Our First Priority",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10,),
                             Container(
                              //width:400,
                              width: MediaQuery.of(context).size.width,
                                height: 95,
                                child: Center(
                                child:Text("Advertisements here",
                                style:TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                ),),
                                color:Colors.blueAccent
                             ),
                              Container(
                                margin: EdgeInsets.only(top: 15, bottom: 20),
                                width: MediaQuery.of(context).size.width,
                                height: 55,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      spreadRadius: 3,
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search here...",
                                    hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      size: 25,
                                    ),
                                  ),
                                  onChanged: (value) => searchDoctor(value),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text("Categories",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.7),
                                ))),
                        SizedBox(height: 20),
                        Container(
                          height: 100,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: categorydata.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15),
                                    height: 60,
                                    width: 60,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFF2F8FF),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                          spreadRadius: 2,
                                        )
                                      ],
                                    ),
                                    child: Center(
                                        child: IconButton(
                                      icon: catIcons[index],
                                      onPressed: () {
                                        checkdoctortype(
                                            catNames[index].toString(), index);
                                      },
                                    )),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    categorydata[index].name,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                  ), 
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            "Recommended Doctors",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                        ),
                        //DoctorsSection(username:searchDoc),
                        Container(
                          height: 340,
                          child: searchDoc.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: searchDoc.length == 0
                                      ? docImage.length
                                      : searchDoc.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Container(
                                            height: 300,
                                            width: 200,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 20),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF2F8FF),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 4,
                                                  spreadRadius: 2,
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      AppointScreen(
                                                                          username:
                                                                              searchDoc[index])));
                                                        },
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    15),
                                                            topRight:
                                                                Radius.circular(
                                                                    15),
                                                          ),
                                                          child: searchDoc[index]['gender'] =='female'                                                              
                                                              ? Image.asset(
                                                                  "images/doctor4.jpeg",
                                                                  height: 180,
                                                                  width: 180,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )
                                                              : Image.asset(
                                                                  "images/doctor1.jpeg",
                                                                  height: 180,
                                                                  width: 180,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                        ),
                                                      ),
                                                      // Align(
                                                      //   alignment:
                                                      //       Alignment.topRight,
                                                      //   child: Container(
                                                      //     margin:
                                                      //         EdgeInsets.all(8),
                                                      //     height: 45,
                                                      //     width: 45,
                                                      //     decoration:
                                                      //         BoxDecoration(
                                                      //       color: Color(
                                                      //           0xFFF2F8FF),
                                                      //       shape:
                                                      //           BoxShape.circle,
                                                      //       boxShadow: [
                                                      //         BoxShadow(
                                                      //           color: Colors
                                                      //               .black12,
                                                      //           blurRadius: 4,
                                                      //           spreadRadius: 2,
                                                      //         ),
                                                      //       ],
                                                      //     ),
                                                      //     // child: Center(
                                                      //     //   child: Icon(
                                                      //     //     Icons
                                                      //     //         .favorite_outline,
                                                      //     //     color:
                                                      //     //         Colors.blue,
                                                      //     //     size: 28,
                                                      //     //   ),
                                                      //     // ),
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 25),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children:[ Text(
                                                              searchDoc.length==0?"Dr "+docImage[index]['DocName'].toUpperCase(): "Dr "+searchDoc[index]['DocName'].toUpperCase() ,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    Colors.blue,
                                                              )),
                                                      ]
                                                      

                                                      ),
                                                            Padding(
                                                              padding:EdgeInsets.fromLTRB(0,5,0,0),
                                                        child: Text(
                                                               docImage[index]
                                                                  ['drDesignation']
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.blue
                                                                
                                                          ),
                                                        ),
                                                            ),
                                                            Padding(
                                                              padding:EdgeInsets.fromLTRB(0,5,0,0),
                                                        child: Text(
                                                          
                                                           
                                                          docImage[index]
                                                                  ['docexpreience']
                                                              .toString() + " yr ",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            
                                                            color: Colors.blue
                                                                .withOpacity(
                                                                    0.6),
                                                          ),
                                                        ),
                                                            )
                                                        // SizedBox(height: 8),
                                                        // Row(
                                                        //   children: [
                                                        //     Icon(
                                                        //       Icons.star,
                                                        //       color:
                                                        //           Colors.amber,
                                                        //     ),
                                                        //     SizedBox(width: 5),
                                                        //     Text(
                                                        //       docImage[index][
                                                        //               'docexpreience']
                                                        //           .toString(),
                                                        //       style: TextStyle(
                                                        //         fontSize: 14,
                                                        //         color: Colors
                                                        //             .black
                                                        //             .withOpacity(
                                                        //                 0.6),
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ]))
                                      ],
                                    );
                                  })
                              : Center(
                                  child: Text(
                                  "No Result",
                                  style: TextStyle(fontSize: 20),
                                  //textAlign: TextAlign.center,
                                )),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        )));
  }

  Future<dynamic> checkdoctortype(String type, int position) async {
    doctorlist.clear();
    await getdoctorcategorydata(position + 1);

    doctortype.clear();
    if (doctorlist.length >= 0) {
      for (int i = 0; i < doctorlist.length; i++) {
        if (doctorlist[i]["categoryId"] == categoryType[position]) {
          doctortype.add(doctorlist[i]);
          // print(doctortype);
        }
      }
    }
    if (doctortype.length > 0) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DentalScreen(
              categoriesDataModel: categorydata[position],
              username: doctortype[index])));
    }
    return doctortype;
  }

 


  List<dynamic> searchDoc = [];
  void searchDoctor(String enterKeyword) {
    List<dynamic> resultDoc = [];
    if (enterKeyword.isEmpty) {
      resultDoc = docImage;
      print("+++++" + docImage.toString());
      print(".....".toString() + resultDoc.toString());
    } else {
      resultDoc = docImage
          .where((user) => user["DocName"] 
              .toLowerCase()
              .contains(enterKeyword.toLowerCase()))
          .toList();
      print("-------".toString() + resultDoc.toString());
    }
    setState(() {
      searchDoc = resultDoc;
      print(resultDoc);
    });
  }

  void transferdata() async {
    final patdet = await shareddata.getpatdata();
    setState(() {
      userId = patdet.userId;
      var userType = patdet.userType;
      name=patdet.userName;
      gender=patdet.Gender;
       stsId=patdet.stsId;
      var Email=patdet.email;
      var phoneNo=patdet.phoneNumber;
       appId=patdet.appId;
      var token=patdet.accessToken;
       
if(stsId== 4){
          
     openRatingDialog( context,appId!);         
     }
     else{
      print("NO Review");
     }

      print("token:"+token);
      print("id:"+userId.toString());
      print("usertype:"+userType);
      print("username:"+name.toString());
      print("gender:"+gender.toString());
      print("stsId:" + stsId.toString());
      print("appId:"+appId.toString());
      print("email:"+Email);
      print("phNo:"+phoneNo);
      
      
    });
  }

}
