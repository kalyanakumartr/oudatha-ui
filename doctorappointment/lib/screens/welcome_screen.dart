import 'package:doctorappointment/screens/home_screen.dart';
import 'package:doctorappointment/screens/login_screen.dart';
import 'package:doctorappointment/screens/signup_screen.dart';
import 'package:flutter/material.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key, });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
 

  @override
  Widget build(BuildContext context) {
    return  Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/3,
        padding: EdgeInsets.all(10),
        child: Column(
          children:[
            SizedBox(height: 30),
            Align(alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: (){
              //   Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder:(context) => HomeScreen(),
              //             ));
               }, 
              child: Text("",
                //"SKIP",
                style:TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
                ),

            ),
            ),
            SizedBox(height: 35),
            Padding( 
              padding: EdgeInsets.all(10),
              child: Image.asset("images/doctors.png",width: 250,height:250 ),
              ),
              SizedBox(height: 20),
              Text(
                 "Doctors Appointment",
                 style:TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  wordSpacing: 2,
                 ),
                 ),
                  SizedBox(height: 20),
                 Text(
                  "Book your Doctor here",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize:18,
                    fontWeight: FontWeight.w500,
                  ),
                  ),
                 SizedBox(height: 70), 
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Material(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:(context) => LoginScreen(),
                          ));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 40),
                          child:Text(
                            "Log In",
                             style: TextStyle(
                             color: Colors.white,
                             fontSize:20,
                             fontWeight: FontWeight.bold,
                            ),
                          ),
                          ),
                      ),

                    ),
                    Material(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:(context) => SignUpScreen(3),
                          ));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 40),
                          child:Text(
                            "Sign Up",
                             style: TextStyle(
                             color: Colors.white,
                             fontSize:20,
                             fontWeight: FontWeight.bold,
                            ),
                          ),
                          )
                      )

                    )
                  ],
                  )
            
          ]
        )

      ) ,
      );
      
  
  }
}

