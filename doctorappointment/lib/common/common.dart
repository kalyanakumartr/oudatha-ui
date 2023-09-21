import 'dart:convert';
import 'dart:io';
import 'package:doctorappointment/screens/admin_screen.dart';
import 'package:doctorappointment/screens/doctor_screen.dart';
import 'package:doctorappointment/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/appoint_screen.dart';
import 'package:doctorappointment/common/sharedPreferences.dart';
import '../screens/ratingdialog_screen.dart';

final shareddata = SharedPref();

SharedPreferences? prefs;

mixin common {
  Future showdialog(BuildContext context, String message) async {
       return showDialog(
             builder: (context) =>
             new AlertDialog(title: new Text(message), actions: <Widget>[
             new FloatingActionButton(
                 onPressed: () => Navigator.pop(context),
                  child: new Text("OK"))
            ]),
        context: context);
  }
 
 openRatingDialog(BuildContext context,int id){
  print(id);
      showDialog(context: context, 
      builder: (context){
        return Dialog(
          backgroundColor: Colors.white,
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child:RatingView(),
        );
      }
      );
    }

 //to login, callfrom login_screen
  Future login(String userName, String password, BuildContext context) async {
    final response =
        await http.post(Uri.parse("http://192.168.1.4:3002/users/auth"),
            // headers: <String, String>{
            //   'Content-Type': 'application/json; charset=UTF-8',
            //   'Authorization': 'Bearer $getToken()',
            // },
            body: ({
              'username': userName,
              'password': password,
            }));
    if (response.statusCode == 200) {
      print(response.body);
      var result = json.decode(response.body);
      print(result['usertype']);
      setToken(result);
      // getToken();
      if (result['usertype'] == "Doctor") {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorScreen(),
            ));
      } else if (result['usertype'] == "Patient") {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(user:result['userId']),
            ));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminScreen(),
            ));
      }

      return (response.body);

// return json.decode(response.body);
    } else {
      // if (response.statusCode == 401) {
      print("Error");

      showdialog(context, "Incorrect username or password");
      return 'error';
    }
  }



Future<dynamic> setToken(dynamic value) async {
    prefs = await SharedPreferences.getInstance();
   // print("value"+value);
    prefs!.setString('userType',value['usertype']);
    prefs!.setInt('userId',value['userId']);
    prefs!.setString('accessToken',value['accesstoken']);
    prefs!.setString('userName',value['username']);
    prefs!.setString('Gender',value['Gender']);
    // print("###:"+value['stsId']);
    // if(value['stsId'] == null){
    //   prefs!.setInt('stsId',value[0]);
    // }else{
    //    prefs!.setInt('stsId',value['stsId']);
    // }
    prefs!.setInt('stsId',value['stsId']);
    prefs!.setInt('appId',value['appId']);
    prefs!.setString('email',value['email']);
    prefs!.setString('phoneNumber',value['phonenumber']);

    return prefs;
  }

  Future getToken() async {
    prefs = await SharedPreferences.getInstance();
   // print( prefs!.getString(('accesstoken') ));
   print( "gettoken:"+ prefs!.getInt(('appId') ).toString());
     prefs!.getString(('accesstoken'));
      prefs!.getInt('appId');
     
 
    return prefs;
   

  }


//SignUp for patient registration from signup_screen

 Future saveuserdetails(String FullName, String Email, String PhoneNumber,
      String Password, String gender ,String usertype,BuildContext context) async {

    final response = await http
        .post(Uri.parse("http://192.168.1.4:3002/users/adduser"),
        
         body: {
      'username': FullName,
      'password': Password,
      'phonenumber': PhoneNumber,
      'email': Email,
      'gender': gender,
      'usertype':usertype,
    },
   
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      showdialog(context, "Added Sucessfully");
      //Navigator.pop(context);
    } else if (response.statusCode == 204) {
      print("Already exixts email");
      showdialog(context, "Already email id exist give correct email id");
    } else if (response.statusCode == 201) {
      print("Invalid data");
      showdialog(context, "Invalid Data");
    }
  }

  //to get doctor category ,call from home_screen
  Future<Map<String, dynamic>> getdoctorcategorydata(int id) async {
     final patdet = await shareddata.getpatdata();
var Token=patdet.accessToken; 
   print("+++++"+Token);
    final response = await http.get(Uri.parse(
        "http://192.168.1.4:3002/users/getDoctorByCategory?categoryId=" +
            id.toString()),
            headers: {
          'contentType':'application/json;charset=UTF-8',
          'Authorization':'Bearer $Token',
        }
            );
    var result = json.decode(response.body);
    doctorlist = result['result'];
    print(doctorlist);
    return result;
  }

//to get doctor slots to book appointment from appoint_screen
  Future<Map<String, dynamic>> getdrslot(int id, String date) async {
    final patdet = await shareddata.getpatdata();
var Token=patdet.accessToken; 
   print("+++++"+Token);
    final response = await http.get(Uri.parse(
        "http://192.168.1.4:3002/users/getdoctorslot?appDrId=" +
            id.toString() +
            "&drAppDate=" +
            date),
             headers: {
          'contentType':'application/json;charset=UTF-8',
          'Authorization':'Bearer $Token',
        }
            );
    var result = json.decode(response.body);
    doctorslot = result['Slots'];
    doctorbookslot = result['BookedSlots'];
    print(doctorslot);

    print(doctorbookslot);
    return result;
  }

//post method to book appointment from appoint_screen
  Future bookAppointment(int appPatientId, int appDrId, int appSlotId,BuildContext context) async {
    // print(appPatientId.toString() +
    //     "-" +
    //     appDrId.toString() +
    //     "-" +
    //     appSlotId.toString());
    final patdet = await shareddata.getpatdata();
var Token=patdet.accessToken; 
   print("+++++"+Token);

    final response = await http
        .post(Uri.parse("http://192.168.1.4:3002/users/addappointment"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $Token',
            },
            body:jsonEncode( {
          'appPatientId': appPatientId.toString(),
          'appDrId': appDrId.toString(),
          'appSlotId': appSlotId.toString()
        }));
        print("^^^^"+'$Token');
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("Your  appointment has been booked Sucessfully");
      showdialog(context, "Your  appointment has been booked Sucessfully");
    }
    return response.body;
  }

//to view doctors appointments booked from doctor_screeen
Future<List<dynamic>> getDrAppointment(int id, String date) async {
  final patdet = await shareddata.getpatdata();
var Token=patdet.accessToken; 
   print("+++++"+Token);
  // createList.clear();
   print(id.toString() + "-" + date);
    final response = await http.get(Uri.parse(
        "http://192.168.1.4:3002/users/getappointment?appDrId=" +
            id.toString() +
            "&drAppDate=" +
            date),
             headers: {
          'contentType':'application/json;charset=UTF-8',
          'Authorization':'Bearer $Token',
        }
            );
            
    var result = json.decode(response.body);  
    userName = result;
    //print(userName.length);
    print(userName);
    createList.clear();
    
    if(userName.length>0){
      for(var i=0;i<userName.length;i++){
       if( userName[i]['appStatusId']==2){
         
          createList.add(userName[i]);
          print(createList.length);
          print(createList);
       }
       
      }
      
    }
  //if (userName['appStatusId'] == 2){}
    return result;
    
    
}

//for doctor registration in doctorregistration_screen
Future savedoctordetails(String FullName, String Email, String PhoneNumber,
      String Password, String gender,String usertype,int mycategory,double Experience, String CertificateNo,String Designation,BuildContext context) async {
       final patdet = await shareddata.getpatdata();
var Token=patdet.accessToken; 
   print("+++++"+Token);
    final response = await http
        .post(Uri.parse("http://192.168.1.4:3002/users/adduserwithlogin"), 
         headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $Token',
            },
        body:jsonEncode( {
      'username': FullName,
      'password': Password,
      'phonenumber': PhoneNumber,
      'email': Email,
      'gender': gender,
      'usertype':usertype,
      'docexpreience': Experience.toString(),
      'doccertificatenum': CertificateNo,
      'categoryId': mycategory.toString(),
      'drDesignation':Designation,

    },)
    );
      print("^^^^"+'$Token');
    print(response.statusCode);
    if (response.statusCode == 200) {
      showdialog(context, "Added Sucessfully");
      //Navigator.pop(context);
    } else if (response.statusCode == 204) {
      print("Already exixts email");
      showdialog(context, "Already email id exist give correct email id");
    } else if (response.statusCode == 201) {
      print("Invalid data");
      showdialog(context, "Invalid Data");
    }
  }

  
   //drCancel from doctor_screen

 Future drCancel(int id ,BuildContext context)async{
   final patdet = await shareddata.getpatdata();
var Token=patdet.accessToken; 
   print("+++++"+Token);
  final response = await http
        .post(Uri.parse("http://192.168.1.4:3002/users/doctorAppointmentCancel/$id"), 
         headers: {
          'contentType':'application/json;charset=UTF-8',
          'Authorization':'Bearer $Token',
        },
        body:jsonEncode( {

        }));
        if(response.statusCode==200){
          showdialog(context, "Doctor Cancelled");

        }

 }


 //get getDocList() from home_screen 

 Future<Map<String, dynamic>> getDocList() async {
   
    final patdet = await shareddata.getpatdata();
var Token=patdet.accessToken; 
   print("+++++"+Token);
       final response = await http
        .get(Uri.parse("http://192.168.1.4:3002/users/doctorcategorymap"),
         headers: {
          'contentType':'application/json;charset=UTF-8',
          'Authorization':'Bearer $Token',
        }
        
         );
         print("****"+ '$Token');
         
    var result = json.decode(response.body);
    print(result);
    docImage = result['result'];
    print(docImage);
  
    return result;
    
  }


Future getDoctorDetail(int id) async {
//     final patdet = await shareddata.getpatdata();
// var Token=patdet.accessToken; 
//    print("+++++"+Token);
 print("Hi+++id:"+id.toString());

       final response = await http
        .get(Uri.parse("http://192.168.1.4:3002/users/doctordetail?id="+id.toString())
        //  headers: {
        //   'contentType':'application/json;charset=UTF-8',
        //   'Authorization':'Bearer $Token',
        // }
        
         );
         var result =json.decode(response.body);
         print(response.body);
        
         resultDetail=result;
         print(resultDetail);
         print(resultDetail[0]['userName']);
         
        //  print(result[0]['userName']);
        //  print("****"+ '$Token');   
          return result;

}

// post rating in ratingdialod_screen
Future postRating(int rating,String comment,int appId)async{
   final patdet = await shareddata.getpatdata();
var Token=patdet.accessToken; 
   print("+++++"+Token);
  print("+++"+rating.toString()+"---"+comment+"***"+appId.toString());
  final response = await http
        .post(Uri.parse("http://192.168.1.4:3002/users/rating"), 
         headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $Token',
            },
        body: jsonEncode({
      'appId': appId.toString(),
      'ratingStars': rating.toString(),
      'ratingReviewCmd': comment,
      

    },
        ));
     
    print(response.statusCode);
    // if(rating>0 && commentController.text.isEmpty){
    //                    Navigator.of(context).pop();
    //                   showdialog(context, "Thank You");
    //                  }
    //                else
    //                  showdialog(context, "Please Enter Some Value");
                    
                   
    return response.body;
  }

//post reviewpending in doctor_screen
Future reviewPending(int id) async{
  print("*** start");
   final response = await http
        .post(Uri.parse("http://192.168.1.4:3002/users/doctorreviewpending"), 
        body: {
          'id':id.toString(),
        }
        );
        print(response.statusCode);
        return response.body;
 }
 

 
 
  
  }







  // Future getdata(String URL) async {
  //   // if(PasswordController.text.isNotEmpty && UsernameController.text.isNotEmpty){
  //   //var token;
  //   var usertype;
  //   prefs = await SharedPreferences.getInstance();

  //   usertype = prefs!.getString('usertype');
  //   // print(token);

  //   final response = await http.get(
  //     Uri.parse(URL),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $usertype',
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body);
  //   } else if (response.statusCode == 201) {
  //     return 'error';
  //   } else {
  //     print("Error");

  //     return 'error';
  //   }
  //   //}
  // }

  
  // Future postdata(String URL, Map<String, dynamic> body) async {
  //   var token;
  //   prefs = await SharedPreferences.getInstance();

  //   token = prefs!.getString('token');
  //   print(token);
  //   final response = await http.post(Uri.parse(URL),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: jsonEncode(body));
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body);
  //   } else if (response.statusCode == 201) {
  //     return 'error';
  //   } else if (response.statusCode == 204) {
  //     print("Error");
  //     return 'error';
  //   }
  //   //}
  // }

