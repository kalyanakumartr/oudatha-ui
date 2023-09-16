import 'package:shared_preferences/shared_preferences.dart';
import '../models/patientDetailsModel.dart';
class SharedPref {
  Future setdata(PatientDetails patientDetails) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt('userId', patientDetails.userId  );
    await preferences.setString('userType', patientDetails.userType);
    await preferences.setString('accessToken', patientDetails.accessToken);
    await preferences.setString('userName', patientDetails.userName);
    await preferences.setString('Gender', patientDetails.Gender);
    await preferences.setInt('stsId', patientDetails.stsId  );
    await preferences.setInt('appId', patientDetails.appId );
    await preferences.setString('email', patientDetails.email  );
    await preferences.setString('phoneNumber', patientDetails.phoneNumber  );
    //print(patientDetails.userId+"inside shared set" + preferences.getString('userId').toString());
  }
  Future<PatientDetails> getpatdata() async {
    final preferences = await SharedPreferences.getInstance();
    final userId = preferences.getInt('userId');
    final userType = preferences.getString('userType');
    final accessToken = preferences.getString('accessToken');
    final userName = preferences.getString('userName');
    final Gender = preferences.getString('Gender');
    final stsId = preferences.getInt('stsId');
    final email = preferences.getString('email');
    final phoneNumber = preferences.getString('phoneNumber');
    final appId = preferences.getInt('appId');
    //print("inside shared get" + preferences.getInt('userId'));
    return PatientDetails(userId:userId?.toInt()?? 0,
                          stsId:stsId?.toInt()?? 0,
                          appId:appId?.toInt()?? 0,
                          userType:userType.toString(),
                          accessToken: accessToken.toString(),
                          userName: userName.toString(),
                          Gender: Gender.toString(),
                          email: email.toString(),
                          phoneNumber:phoneNumber.toString()
                          );
  }
}