import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../common/common.dart';

  dynamic  user;
 
class ProfilePicture extends StatefulWidget {
  const ProfilePicture(   {super.key, required this.username,  });
  final  username;
 

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

 

class _ProfilePictureState extends State<ProfilePicture> with common{
  
 File? imagepath; 
// String? imagename;
// String? imagedata;  
int? userIdhere;
int?userId;
 

ImagePicker imagePicker= new ImagePicker();
void transferdata() async {
    final patdet = await shareddata.getpatdata();
    setState(() {
      userIdhere = patdet.userId;
          print(userIdhere);
      //  getUserImage(userIdhere!); 
      // print(userIdhere1);
    });
  }
@override
  void initState() {    
   user=widget.username;
    transferdata(); 
   
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    // int a=45;
    print("+++"+widget.username.toString() );

    return Scaffold(
     
        appBar: AppBar(title: Text("Update your profile")),
        body: Container(
        
            child: SingleChildScrollView(
                 child: Center(
                  child:Padding(
                     padding: EdgeInsets.all(20),
                  child: Column(                       
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                           Stack(
                            children:[
                              CircleAvatar(
                                radius: 100,
                                backgroundImage: 
                              //  imagepath == null
                              //  ?AssetImage("images/male.jpeg"):
                               NetworkImage( 'http://172.20.10.4:3002/users/getuserimagefromlocal?id=${widget.username}')
                                 
    // 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                                      //  FileImage(File(imageUrl.path)) ,                      
                                           
                                  // AssetImage("images/male.jpeg"),
                              
                              ),
                            
                         Positioned(
                              bottom:10,right:10,
                              child:InkWell(
                                onTap:(){
                                  showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
                                },
                              child:Icon(Icons.add_a_photo,
                              color:Colors.blue,
                              size:35.0
                              )
                            ),
                            )
                            ]
                           ),
                          
                          ],
                        )
                        ),
                ))
                 ),

                );
             
  }
  Widget bottomSheet(){
    return Container(
      height:100,
      width:MediaQuery.of(context).size.width,
      margin:EdgeInsets.symmetric(
        horizontal: 20,vertical: 20
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, 
    
          children: <Widget>[
            
           FloatingActionButton.extended(
              icon: Icon(Icons.camera),
              onPressed: () {
                // takePhoto(ImageSource.camera);
                   getImage(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
SizedBox(
            width: 20,
          ),
           FloatingActionButton.extended(
              
              icon: Icon(Icons.image),
              onPressed: () {
                // takePhoto(ImageSource.gallery);
                  getImage(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
    

  }
  Future <void> getImage(ImageSource source) async{
var getimage = await imagePicker.pickImage(source: source,
// maxWidth: 300,
// maxHeight: 300,
);
setState(() {
  imagepath=File(getimage!.path);
print(imagepath);
 uploadImage();


});

   }


    Future uploadImage()async{
    final uri = Uri.parse("http://192.168.1.4:3002/users/updateuserimage");
    var request = http.MultipartRequest('POST',uri);
    request.fields['id'] = userIdhere.toString();
    var pic = await http.MultipartFile.fromPath("images", imagepath!.path);
    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image Uploded');
    }else{
      print('Image Not Uploded');
    }
    setState(() {
         
      
    });
   }


Future getUserImage(int id) async {
//     final patdet = await shareddata.getpatdata();
// var Token=patdet.accessToken; 
//    print("+++++"+Token);
 print("Hi+++id:"+id.toString());

       final response = await http
        .get(Uri.parse("http://192.168.1.4:3002/users/getuserimagefromlocal?id="+id.toString())
        //  headers: {
        //   'contentType':'application/json;charset=UTF-8',
        //   'Authorization':'Bearer $Token',
        // }
        
         );
        //  netImage=response.body;
         print(response.body);
        //  print("****"+ '$Token');
         
    // File result = json.decode(response.body);
    // print(result);
    
 
    return response;
    
  }






}
