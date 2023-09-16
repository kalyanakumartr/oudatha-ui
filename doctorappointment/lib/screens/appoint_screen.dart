import 'package:doctorappointment/common/common.dart';
import 'package:doctorappointment/common/sharedPreferences.dart';
import 'package:doctorappointment/screens/payload_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../services/notificationServices.dart';


Map<String, dynamic>? user;
Map<String, dynamic>? DoctorSlot;
final shareddata = SharedPref();

List<dynamic> doctorslot = [];
List<dynamic> doctorbookslot = [];
List<dynamic> emptyslot = [];
List<dynamic> bookslot = [];

class AppointScreen extends StatefulWidget {
  const AppointScreen({super.key, required this.username});
  final Map<String, dynamic> username;
  @override
  State<AppointScreen> createState() => _AppointScreenState();
}

class _AppointScreenState extends State<AppointScreen> with common {
  TextEditingController dateinput = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  
  int? _currentIndex;
  int? currentSlotId;
  bool _dateSelected = false;
  bool _timeSelected = false;
  int? userIdhere;
  String? name;
  late final NotificationService  service;
 
  void transferdata() async {
    final patdet = await shareddata.getpatdata();
    setState(() {
      userIdhere = patdet.userId;
      var userIdhere1 = patdet.userType;
      name=patdet.userName;
      print(userIdhere);
      print(userIdhere1);
    });
  }

  void _showDatePicker() async {
    bool _decideWhichDayToEnable(DateTime day) {
      if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
          day.isBefore(DateTime.now().add(Duration(days: 30))))) {
        return true;
      }
      return false;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      selectableDayPredicate: _decideWhichDayToEnable,
    );
    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        dateinput.text = formattedDate;
        
      });
       //checkSlot(dateinput.text);
    //   setState(() {
    //          checkSlot(dateinput.text);
    //       });
     }
  }

  @override
  void initState() {
    user = widget.username;
    transferdata();
    doctorslot.clear();
    
    service=NotificationService();
    service.initNotification();
    listenToNotification();
   checkSlot(dateinput.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      // centerTitle: true,
      // title: Text(""),),
      body: CustomScrollView(
        //color: Color(0xFFD9E4EE),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.8,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      
                      image: widget.username['gender']=='female'? AssetImage(
                        "images/doctor4.jpeg",)
                      :AssetImage(
                        "images/doctor1.jpeg",),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.withOpacity(0.9),
                            Colors.blue.withOpacity(0),
                            Colors.blue.withOpacity(0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: 30, left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF2F8FF),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.blue,
                                        size: 26,
                                      ),
                                    ),
                                  ),
                                ),
                                // Container(
                                //   margin: EdgeInsets.all(8),
                                //   height: 20,
                                //   width: 20,
                                //   decoration: BoxDecoration(
                                //     color: Color(0xFFF2F8FF),
                                //     borderRadius: BorderRadius.circular(10),
                                //     boxShadow: [
                                //       BoxShadow(
                                //         color: Colors.black12,
                                //         blurRadius: 4,
                                //         spreadRadius: 2,
                                //       ),
                                //     ],
                                //   ),
                                //   // child: Center(
                                //   //   // child: Icon(
                                //   //   //   Icons.favorite_outline,
                                //   //   //   color: Colors.blue,
                                //   //   //   size: 26,
                                //   //   // ),
                                //   // ),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Patients",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      "3",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Experience",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      widget.username['docexpreience'].toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Rating",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      widget.username['DocId'].toString(),
                                      //doctortype[index]['DocName'].toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: 
                              [
                                Text("Dr "+widget.username['DocName'].toUpperCase(),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                              )),
                              SizedBox(width:5,),
                              Text( widget.username['drDesignation'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                              )),
                            ],
                      ),
                          
                      SizedBox(height: 8),
                      Row(
                        children: [
                          // Icon(MdiIcons.heartPulse,
                          //     color: Colors.red, size: 28),
                          SizedBox(width: 5),
                          Text(widget.username['categories'].toString(),
                            //"Surgon",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.blue.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: 15),
                      // Text(
                      //   "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     color: Colors.black.withOpacity(0.6),
                      //   ),
                      //   textAlign: TextAlign.justify,
                      // ),
                      SizedBox(height: 18),
                      Text(
                        "Appointment Date",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),

                      TextFormField(
                          controller: dateinput,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Select Date",
                            // "${_dateTime.toLocal()}".split(' ')[0],
                            suffixIcon: Icon(
                              Icons.calendar_view_month,
                            ),
                          ),
                          readOnly: true,
                          onTap: () {
                            _showDatePicker();
                            // print("::"+dateinput.text);
                            //  print(":::"+widget.username['DocId'].toString());
                             checkSlot(dateinput.text);
                          }),
                      SizedBox(height: 10),
                      Text(
                        "Select Consultation Time",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        height: 60,
                        child: ListView.builder(
                            controller: _scrollController,
                            // reverse: true,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: doctorslot.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    //_dateSelected?
                                    doctorslot[index]['booked']==1
                                        ? null
                                        : setState(() {
                                            _currentIndex = index;
                                            _timeSelected = true;
                                            currentSlotId =
                                                doctorslot[index]['slotId'];
                                          });
                                  },
                                  child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: _currentIndex == index
                                            ? Colors.grey
                                            : Colors.white,
                                        // index == 0
                                        //     ? Colors.blue:
                                        // Color(0xFFF2F8FF),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 4,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Text(
                                              doctorslot[index]['slot'],
                                              //  '${index + 7}:00 ${index +7> 11 ? "PM" : "AM"}',
                                              //"${index + 07}: 00 AM",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  // color: _currentIndex == index
                                                  //     ? Colors.black45
                                                  //     : null,
                                                  color: doctorslot[index]
                                                          ['booked']==1
                                                      ? Colors.green
                                                      : null
                                                  // index==0
                                                  //     ? Colors.white :
                                                  // Colors.black.withOpacity(0.6),
                                                  ),
                                            ),
                                          ],
                                        ),
                                      )));
                            }),
                      ),

                      SizedBox(height: 30),
                      Material(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                             NotificationService()
               .showNotification( id:0,title:'your appointment booked', body: 'sucessfully!',payload: "hi payload");
                            print(userIdhere as int);
                            print(widget.username['DocId'] as int);
                            print(currentSlotId);
                            bookAppointment(
                                userIdhere!,
                                widget.username['DocId'],
                                currentSlotId!,
                                context);
                               
                          },
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                "Book Apointment",
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
                    ],
                    
                          
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> checkSlot(date) async {
    doctorslot.clear();
    //print("???"+widget.username['DocId'].toString());
    await getdrslot(widget.username['DocId'], date.toString());
    //print("doctorslot" + doctorslot.toString());
    if (doctorslot.length > 0) {
      // print("bookslot");
      for (int i = 0; i < doctorslot.length; i++) {
        //print(doctorbookslot[0]['slotId'].toString()+".....");
        List<dynamic> bookedslot =
            doctorbookslot[0]['slotId'].toString().split(',');
        if (bookedslot.contains(doctorslot[i]['slotId'].toString())) {
          doctorslot[i]['booked'] = 1;
        } else {
          doctorslot[i]['booked'] = 0;

          print(bookedslot.toString() +
              "++" +
              doctorslot[i]['slotId'].toString() +
              "+" +
              bookedslot
                  .contains(doctorslot[i]['slotId'].toString())
                  .toString());
        }
        print(doctorslot.toString());
      }
    }
  }
void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);
  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => payLoadScreen(payload: payload))));
    }
  }



}
