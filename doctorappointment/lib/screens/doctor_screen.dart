import 'package:doctorappointment/common/common.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

import '../services/notificationServices.dart';
import 'login_screen.dart';
import 'package:doctorappointment/common/sharedPreferences.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

final drName = SharedPref();

SharedPreferences? prefs;
List<dynamic> userName = [];
List<dynamic> createList = [];

var totalList;

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> with common {
  TextEditingController dateinput = TextEditingController();
  // DateTime _dateTime = DateTime.now();
  SampleItem? selectedMenu;
  String? docName;
  int? docId;

  @override
  void initState() {
    // getDrAppointment();
    transferdata();
    createList.clear();
    // getDrAppointment(docId!, dateinput.text);
    //getDrAppointment(22, "2023-07-25");
    super.initState();
  }

  void transferdata() async {
    final patdet = await drName.getpatdata();
    setState(() {
      docName = patdet.userName;
      docId = patdet.userId;
    });
  }

  Future<void> _refresh() {
    return Future.delayed(const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("WELCOME  " + "Dr "+docName.toString().toUpperCase()),
          actions: [
            PopupMenuButton<SampleItem>(
              initialValue: selectedMenu,
              // Callback that sets the selected popup menu item.
              onSelected: (value) async {
                // setState(() {
                //   selectedMenu = item;

                // });
                switch (value) {
                  case SampleItem.itemOne:
                    prefs = await SharedPreferences.getInstance();
                    await prefs?.clear();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (c) => LoginScreen()),
                        (route) => false);
                    break;
                  case SampleItem.itemTwo:
                    
                    break;
                  case SampleItem.itemThree:
                    
                    break;
                }
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<SampleItem>>[
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
            ),
          ]),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(15),
          child: TextField(
            controller: dateinput,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Choose Date",
              // "${_dateTime.toLocal()}".split(' ')[0],
              suffixIcon: Icon(Icons.calendar_view_month),
            ),
            readOnly: true,
            onTap: () {
              _showDatePicker();
            },
            // onChanged:(value){
            //    setState(() {
            //  getDrAppointment(docId!,dateinput.text);

            // });
            // }
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: createList.length,
                itemBuilder: (BuildContext context, index) {
                  return Card(
                      child: ListTile(
                    title: Text(createList[index]['username'].toUpperCase()),
                    leading: CircleAvatar(
                      radius: 20,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.blue,
                        backgroundImage: createList[index]['gender'] =='female'?AssetImage(
                          "images/female.jpg",
                        ):AssetImage(
                          "images/male.jpeg"),
                        // NetworkImage(user!['image']),
                        // AssetImage("images/doctor1.jpeg")
                      ),
                    ),
                    subtitle: Text(createList[index]['slot']),
                    trailing: Wrap(
                      spacing: 8,
                      children: [
                        Tooltip(
                           message: 'approval',
                             preferBelow: false,
                       child:
                        IconButton(
                         
                          icon: const Icon(Icons.approval),
                          color: Colors.green,
                          onPressed: () {
                            reviewPending(createList[index]['id']);
                            //  openRatingDialog(context,createList[index]['id']);
                          },
                        ),
                         
                          ),
                        
                         Tooltip(
                          message:"followup",
                          preferBelow: false,
                         child: IconButton(
                           
                            icon:Icon(
                              Icons.follow_the_signs,
                              color: Color.fromARGB(255, 19, 152, 219),
                            ),
                            onPressed: () {
                              
                            },
                          ),
                     
                         ),
                          Tooltip(
                          message: 'cancel',
                            preferBelow: false,
                       child: IconButton(
                         
                          icon:Icon(
                            Icons.cancel,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                             NotificationService()
              .showNotification(id:0,title: 'your appointment has been cancled', body: 'by doctor!',payload: "hi payload");
                             drCancel(createList[index]['id'], context);
                            // Navigator.of(context).pop();
                          },
                        ),
                         ),
                          
                      ],
                    ),
                  ));
                }),
          ),
        ),
        //  getList(),
      ]),
    );

   

  }

//   Widget getList() {
// //   => data.isEmpty
// //   ?Center(child: CircularProgressIndicator())
// //  :RefreshW{
//     // child:FutureBuilder<List>(builder: (context, snapshot) {
//       // if( snapshot.data == null){
//       //       return const Center(child: CircularProgressIndicator(),);
//       //     }else{
//       //       List createList = snapshot.data!;

//          print("-----------------------");
//        return Expanded(
//         child:ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: createList.length,
//           itemBuilder: (BuildContext context, index) {
//             return Card(
//                 child: ListTile(
//               title: Text(createList[index]['username']),
//               leading: CircleAvatar(
//                 radius: 20,
//                 child: CircleAvatar(
//                   radius: 100,
//                   backgroundColor: Colors.blue,
//                   backgroundImage: AssetImage(
//                     "images/doctor1.jpeg",
//                   ),
//                   // NetworkImage(user!['image']),
//                   // AssetImage("images/doctor1.jpeg")
//                 ),
//               ),
//               subtitle: Text(createList[index]['slot']),
//               trailing: Wrap(
//                 spacing: 8,
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.approval),
//                     color: Colors.green,
//                     onPressed: () {

//                     },
//                   ),
//                   IconButton(
//                     icon: const Icon(
//                       Icons.cancel,
//                       color: Colors.redAccent,
//                     ),
//                     onPressed: () {
//                       drCancel(createList[index]['id'],context);
//                     },
//                   ),
//                 ],
//               ),
//             ));
//           }),
//           );

//     // });

//   }

  void _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    print("picked" + picked.toString());
    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        dateinput.text = formattedDate;
        print(dateinput.text);

          getDrAppointment(docId!, dateinput.text);
        // //  var total=
        // totalList=total;
        // print(total);
      });
    }

    //createList=getDrAppointment(docId!, dateinput.text) as List;
  }

 



}
