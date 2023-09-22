import 'dart:convert';
// import 'package:doctorappointment/common/common.dart';
// import 'package:doctorappointment/models/patientDetailsModel.dart';
import 'package:doctorappointment/screens/details_screen.dart';
// import 'package:doctorappointment/screens/home_screen.dart';
// import 'package:doctorappointment/screens/login_screen.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Map<String, dynamic>? PatientList;

List<dynamic> list = [];

class PatientDetails extends StatefulWidget {
  Map<String, dynamic>? PatientList;
  PatientDetails();

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  Future<Map<String, dynamic>> getpatientdata() async {
    final response =
        await http.get(Uri.parse("http://192.168.1.3:3002/users/getregister"));
    PatientList = json.decode(response.body);

    for (String key in PatientList!.keys) {
      list = (PatientList!['result']);
      print(list.length);
    }
    if (list.length > 0) getList();
    return PatientList!;
  }

  List<dynamic> searchList = [];
  void searchFilter(String enterKeyword) {
    List<dynamic> result = [];
    if (enterKeyword.isEmpty) {
      result = list;
      // print(list);
      // print(result);
    } else {
      result = list
          .where((user) => user["username"]
              .toLowerCase()
              .contains(enterKeyword.toLowerCase()))
          .toList();
      //  print(result);
    }
    setState(() {
      searchList = result;
      // print(result);
    });
  }

  @override
  void initState() {
    setState(() {
//       var postresult=await getdata("http://192.168.1.7:3002/users/posts");

// print(postresult);
// if(postresult=="Success"){
      //if(PatientList == null)
      getpatientdata();

      //   }
      // else{
      // }
    });
    super.initState();
    //result=widget.patientList!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PatientDetails')),
      body: Column(
        children: [
          // SizedBox(height:10),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              onChanged: (value) => searchFilter(value),
              decoration: InputDecoration(
                labelText: "Search",
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          if (list.length > 0) getList()
        ],
      ),
    );
  }

  Widget getList() {
    return Expanded(
      child: ListView.builder(
          itemCount: searchList.length == 0 ? list.length : searchList.length,
          itemBuilder: (BuildContext context, index) {
            return ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (c) => DetailScreen(list[index])));
              },
              //crossAxisAlignment: CrossAxisAlignment.start,
              title: Card(
                //elevation: 5,
                //width: double.infinity,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  searchList.length == 0
                      ? list[index]['username']
                      : searchList[index]['username'],
                ),
              ),
            );
          }),
    );
  }
}
