import 'package:doctorappointment/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:http/http.dart' as http;

import '../common/common.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen(int i, {super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with common{
  final _formKey = GlobalKey<FormState>();

  bool passToggle = true;
  int _value = 1;
  String gender = "male";
  String usertype="2";
  var FullNameController = TextEditingController();
  var PasswordController = TextEditingController();
  var PhoneNumberController = TextEditingController();
  var EmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
            child: SafeArea(
                child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(10)),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Image.asset("images/doctors.png",width: 250,height:250),
                      
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
                               
                                saveuserdetails(
                                    FullNameController.text,
                                    EmailController.text,
                                    PhoneNumberController.text,
                                    PasswordController.text,
                                    gender, usertype,context);
                                FullNameController.clear();
                                PasswordController.clear();
                                EmailController.clear();
                                PhoneNumberController.clear();
                                gender = "";

                                //  showDialog(
                                //       context: context,
                                //       builder: (BuildContext context) {
                                //         return alertDialog("Sucess","Your account has been created sucessfully.",context);
                                //       },
                                //     );
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
                    ])
                  ],
                )),
          ],
        ))));
  }

  // Future saveuserdetails(String FullName, String Email, String PhoneNumber,
  //     String Password, String gender ,String usertype,context) async {
  //   //var url ="http://192.168.1.8:3002/users/addregister";
  //   final response = await http
  //       .post(Uri.parse("http://192.168.1.3:3002/users/addregister"), body: {
  //     'username': FullName,
  //     'password': Password,
  //     'phonenumber': PhoneNumber,
  //     'email': Email,
  //     'gender': gender,
  //     'usertype':usertype,
  //   });

  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     showdialog(context, "Added Sucessfully");
  //     //Navigator.pop(context);
  //   } else if (response.statusCode == 204) {
  //     print("Already exixts email");
  //     showdialog(context, "Already email id exist give correct email id");
  //   } else if (response.statusCode == 201) {
  //     print("Invalid data");
  //     showdialog(context, "Invalid Data");
  //   }
  // }

  }



 

  // AlertDialog alertDialog(String title, String content, BuildContext context) {
  // return AlertDialog(
  //   title: Text(title),
  //   content: Text(content),
  //   actions: [
  //     TextButton(
  //       child: Text(
  //         "OK",
  //         style: TextStyle(color: Colors.white),
  //       ),
  //       style: ButtonStyle(
  //           backgroundColor: MaterialStateProperty.all(Colors.black38)),
  //       onPressed: () {
  //         Navigator.of(context).pop();
  //       },
  //     ),
  //   ],
  // );
  //}

