import 'package:doctorappointment/models/CategoriesModel.dart';
import 'package:doctorappointment/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'appoint_screen.dart';

Map<String, dynamic>? user;

class DentalScreen extends StatefulWidget {
  final CategoriesDataModel categoriesDataModel;
  final Map<String, dynamic> username;

  //final DoctorModel dataModel;
  DentalScreen({required this.categoriesDataModel, required this.username});

  //DentalScreen({ Key? key, required this.categoriesDataModel}) : super(key:key);

  @override
  State<DentalScreen> createState() => _DentalScreenState();
}

class _DentalScreenState extends State<DentalScreen> {


 List<dynamic> searchDoc = [];
  void searchDoctor(String enterKeyword) {
    List<dynamic> resultDoc = [];
    if (enterKeyword.isEmpty) {
      resultDoc = doctortype;
      print("+++++"+doctortype.toString());
     print(".....".toString()+resultDoc.toString());
    } else {
      resultDoc = doctortype
          .where((user) => user["DocName"]
              .toLowerCase()
              .contains(enterKeyword.toLowerCase()))
          .toList();
       print("-------".toString()+resultDoc.toString());
    }
    setState(() {
      searchDoc = resultDoc;
        print(resultDoc);
    });
  }

  @override
  void initState() {
    user = widget.username;
    searchDoc=doctortype;
    //print(user!['DocName'].toString());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.categoriesDataModel.name),
      ),
      body: Column(
        children: [
          // SizedBox(height:10),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              
              onChanged: (value) => searchDoctor(value),
              decoration: InputDecoration(
                  labelText: "Search",
                  suffixIcon: Icon(Icons.search),
                  ),
                
            ),
          ),
           getList()
        ],
      ),
    );
  }

  Widget getList() {
    return Expanded(
      child:searchDoc.isNotEmpty? ListView.builder(
          itemCount:searchDoc.length==0?doctortype.length:searchDoc.length,
          itemBuilder: (BuildContext context, index) {
            return Card(
                child: ListTile(
              title: Text(searchDoc.length==0
              ?"Dr "+doctortype[index]['DocName'].toUpperCase()
              :"Dr "+searchDoc[index]['DocName'].toUpperCase()  ),
              leading: CircleAvatar(
                
                radius: 20,
                child: CircleAvatar(
                  radius: 100,
                  
                  //backgroundColor: Colors.blue,
                  backgroundImage:doctortype[index]['gender']=='female' ?AssetImage(
                    "images/doctor4.jpeg",
                   )
                  :AssetImage(
                    "images/doctor1.jpeg",),
                  // NetworkImage(user!['image']),
                  // AssetImage("images/doctor1.jpeg")
                ),
              ),
              subtitle: Text(doctortype[index]['drDesignation']),
              trailing:Text(doctortype[index]['docexpreience'].toString()+" yr "),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AppointScreen(username:doctortype[index])));
              },
            ),
            
            ); 
            
            
          }): Center(child:Text("No Result",
          style: TextStyle(fontSize: 20),
          //textAlign: TextAlign.center,
          )),
    );
  }
}
