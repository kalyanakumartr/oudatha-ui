import 'package:doctorappointment/screens/welcome_screen.dart';

import 'package:flutter/material.dart';



void main(){  
  //  WidgetsFlutterBinding.ensureInitialized();
  // NotificationService().initNotification();
  runApp(
    MyApp()
  );
}




class MyApp extends StatelessWidget {
  const MyApp({super.key });

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:WelcomeScreen(),
    );
  }
}