import 'dart:convert';
import 'package:doctorappointment/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'login_screen.dart';
import 'package:doctorappointment/common/sharedPreferences.dart';

final shareddata = SharedPref();


class DoctorRegistration extends StatefulWidget {
  const DoctorRegistration({super.key});

  @override
  State<DoctorRegistration> createState() => _DoctorRegistrationState();
}

class _DoctorRegistrationState extends State<DoctorRegistration> with common{
  final _formKey = GlobalKey<FormState>();

  bool passToggle = true;
  int _value = 1;
  String gender = "male";
  
  String usertype= "1";
  var FullNameController = TextEditingController();
  var PasswordController = TextEditingController();
  var PhoneNumberController = TextEditingController();
  var EmailController = TextEditingController();
  var ExperienceController = TextEditingController();
  var DesignationController = TextEditingController();
  var CertificateNoController= TextEditingController();
List categoryList = [];
String? categoryId;
 

Future<List?> getcategoryList() async {
final patdet = await shareddata.getpatdata();
var Token=patdet.accessToken; 
   print("+++++"+Token);
       final response =
        await http.get(Uri.parse("http://192.168.1.4:3002/users/getcategory"),
        headers: {
          'contentType':'application/json;charset=UTF-8',
          'Authorization':'Bearer $Token',
        }
        );
   var  category = json.decode(response.body);
   print(category);
   setState(() {
      categoryList=category;
   });
        return category;
 }


 @override
  void initState() {
        super.initState();
        this.getcategoryList();
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
      centerTitle: true,
      title: Text("Doctor Registration"),
        
      ),
      
      body:Center(
        child: 
          SingleChildScrollView(
             child: SafeArea(
                child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(10)),
                    Text(
                      "Sign Up as a Doctor",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Image.asset("images/doctors.png",width: 200,height: 200,),
                    ),

          
        SizedBox(height: 10),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      child: TextFormField(
                        controller: FullNameController,
                        //maxLength: 10,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Full Name",
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (val) {
                          if (val!.isEmpty ||
                              !RegExp(r'^[a-z A-Z 0-9]+$').hasMatch(val)) {
                            return "Please enter your Name";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      child: TextFormField(
                        controller: EmailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (val) {
                          if ((val!.isEmpty) ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=/^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val)) {
                            return "Enter a valid email address";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: PhoneNumberController,
                        //maxLength: 13,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Phone Number",
                          prefixIcon: Icon(Icons.phone),
                        ),
                        validator: (val) {
                          if ((val!.isEmpty) ||
                              !RegExp(r'^[0-9]+$').hasMatch(val)) {
                            return "Enter a valid phone number";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      child: TextFormField(
                        controller: PasswordController,
                        //maxLength: 10,
                        obscureText: passToggle ? true : false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: InkWell(
                            onTap: () {
                              if (passToggle == true) {
                                passToggle = false;
                              } else {
                                passToggle = true;
                              }
                              setState(() {});
                            },
                            child: passToggle
                                ? Icon(CupertinoIcons.eye_slash_fill)
                                : Icon(CupertinoIcons.eye_fill),
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter your password";
                          }
                          return null;
                        },
                       
                      ),
                    ),
                    
                  
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Gender:",
                                style: TextStyle(
                                  //color: Colors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Radio(
                                  value: 1,
                                  groupValue: _value,
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value!;
                                      print(_value);
                                      gender = "male";
                                    });
                                  }),
                              SizedBox(
                                width: 6.0,
                              ),
                              Text("Male",
                                  style: TextStyle(
                                    //color: Colors.blue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    //fontWeight: FontWeight.bold,
                                  ))
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: 2,
                                  groupValue: _value,
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value!;
                                      print(_value);
                                      gender = "female";
                                    });
                                  }),
                              SizedBox(
                                width: 6.0,
                              ),
                              Text("Female",
                                  style: TextStyle(
                                    //color: Colors.blue,
                                    fontSize: 15,
                                    //fontWeight: FontWeight.bold,
                                  ))
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: 3,
                                  groupValue: _value,
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value!;
                                      print(_value);
                                      gender = "other";
                                    });
                                  }),
                              SizedBox(
                                width: 6.0,
                              ),
                              Text("Other",
                                  style: TextStyle(
                                    //color: Colors.blue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    //fontWeight: FontWeight.bold,
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                          child: DropdownButtonFormField(
                            items:categoryList.map((item){
                              return new DropdownMenuItem(
                                //  hintText:"Select Category",
                                child: new Text(
                                  item['categories'],
                                  style:TextStyle(
                                    fontSize:15,),     
                                ),   
                                value:item['catid'].toString(),
                            );
                           
                            }).toList(), 
                            onChanged: ( newVal) {
                              setState(() {
                                categoryId=newVal!;
                                print(categoryId);
                              });
                            },
                            value: categoryId,
                            ),
                    
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      child: TextFormField(
                        controller: ExperienceController,
                        keyboardType: TextInputType.number,
                        // WithOptions(decimal: true),
                        //maxLength: 10,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Experience",
                          //prefixIcon: Icon(Icons.person),
                        ),
                        validator: (val) {
                         if ((val!.isEmpty) ||
                              !RegExp(r'^[0-9.0-9]+$').hasMatch(val)) {
                            return "Enter a valid Experience";
                          }
                          return null;
                        },
                      ),
                    ),
                    
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      child: TextFormField(
                        controller: CertificateNoController,
                        //maxLength: 10,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Certificate Id",
                          //prefixIcon: Icon(Icons.person),
                        ),
                        validator: (val) {
                         if ((val!.isEmpty) ||
                               !RegExp(r'^[a-z A-Z 0-9]+$').hasMatch(val)) {
                            return "Enter a valid CertificateNo";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      child: TextFormField(
                        controller: DesignationController,
                        // keyboardType: TextInputType.number,
                        // WithOptions(decimal: true),
                        //maxLength: 10,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Designation",
                          //prefixIcon: Icon(Icons.person),
                        ),
                        validator: (val) {
                          if (val!.isEmpty ||
                              !RegExp(r'^[a-z A-Z 0-9]+$').hasMatch(val)) {
                            return "Please enter your Designation";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: double.infinity,
                        child: Material(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: () {
                              
                              if (_formKey.currentState!.validate()) {
                                savedoctordetails(
                                  
                                    FullNameController.text,
                                    EmailController.text,
                                    PhoneNumberController.text,
                                    PasswordController.text,
                                    gender, usertype ,
                                    int.parse(categoryId!),
                                  double.parse(ExperienceController.text),
                                 
                                  CertificateNoController.text ,
                                   DesignationController.text,context
                                    
                                   );
                                FullNameController.clear();
                                PasswordController.clear();
                                EmailController.clear();
                                PhoneNumberController.clear();
                                ExperienceController.clear();
                                CertificateNoController.clear();
                                DesignationController.clear();
                                gender = "";
                               
                              
                                }
                             },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              child: Center(
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        "Already have account?",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ));
                          },
                          child: Text("Log In",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ))),
                    ]),
                ])),
                ])),
      )),
        );
  }


        

   // );
  }
//}