import 'package:doctorappointment/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'doctorregestration_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SampleItem { itemOne, itemTwo, itemThree }
SharedPreferences? prefs;
class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
   SampleItem? selectedMenu;
  @override
  Widget build(BuildContext context) {
     return   Scaffold
    (
      appBar: AppBar(
      centerTitle: true,
      title: Text("Admin"),
      actions:[PopupMenuButton<SampleItem>(
          initialValue: selectedMenu,
          // Callback that sets the selected popup menu item.
          onSelected: (value)  async {
            // setState(() {
            //   selectedMenu = item;
              
            // });
            switch (value){
              case SampleItem.itemOne:
                prefs = await SharedPreferences.getInstance();
                await prefs?.clear();
               Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c)=>LoginScreen()),
               (route) => false);
              break;
              case SampleItem.itemTwo:
                // TODO: Handle this case.
                break;
              case SampleItem.itemThree:
                // TODO: Handle this case.
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
            const PopupMenuItem<SampleItem>(
              value: SampleItem.itemOne,
              child: Text('Logout'),
            ),
            // const PopupMenuItem<SampleItem>(
            //   value: SampleItem.itemTwo,
            //   child: Text('Item 2'),
            // ),
            // const PopupMenuItem<SampleItem>(
            //   value: SampleItem.itemThree,
            //   child: Text('Item 3'),
            // ),
          ],
          // onSelected : (value){
            
          // }
         ),]


      ),
     body: Center(
              child: Column(children: <Widget>[
                Padding(padding: EdgeInsets.all(20)),
            Material(
              
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      //padding:EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:(context) => 
                            DoctorRegistration(),
                          ));
                        },
                        child: Padding(
                          
                          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 40),
                          child:Text(
                            "Doctor Registration",
                             style: TextStyle(
                             color: Colors.white,
                             fontSize:20,
                             fontWeight: FontWeight.bold,
                            ),
                          ),
                          ),
                      ),

                    ),
          ])
          )
          );
    
  }
  }
