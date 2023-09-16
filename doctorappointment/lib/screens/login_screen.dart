import 'dart:convert';

import 'package:doctorappointment/common/common.dart';
import 'package:doctorappointment/screens/home_screen.dart';
import 'package:doctorappointment/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with common {
  final _formKey = GlobalKey<FormState>();
  bool passToggle = true;
  var UsernameController = TextEditingController();
  var PasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "Login",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(10),
                child: Image.asset("images/doctors.png",width:250,height: 250,),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: UsernameController,
                  maxLength: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Enter Name"),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (val) {
                    if (val!.isEmpty ||
                        !RegExp(r'^[a-z A-Z]+$').hasMatch(val)) {
                      return "Please enter your Name";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(8),
                  child: TextFormField(
                    controller: PasswordController,
                    obscureText: passToggle ? true : false,
                    maxLength: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Password"),
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
                  )),
              SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(10),
                          onPrimary: Colors.blue,
                        ),
                        onPressed: () {
                          logincall(UsernameController.text,
                              PasswordController.text, context);
                        },
                        child: Text("Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                      ))),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Dont have any account?",
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
                            builder: (context) =>SignUpScreen (3),
                          ));
                    },
                    child: Text("Create Account",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ))),
              ])
            ],
          ),
        ),
      ),
    );
  }

  // // Create Function to Call Login POST API
  //}

  void logincall(String username, String password, BuildContext context) async {
    var result = await login(username, password, context);

    UsernameController.clear();
    PasswordController.clear();

// if(result.statusCode==401){
 //showdialog(context, "");
// }
// else{

// var postresult=await getdata("http://192.168.1.7:3002/users/posts");

// print(postresult);
// if(postresult=="Success"){
    //  Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => HomeScreen(),
    //         ));
// }
// else{
//    Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => LoginScreen(),
//           ));
//   }
  }
}
