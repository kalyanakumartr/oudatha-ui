
class PatientDetails {
  String accessToken;
  int userId;
  String userType;
  String userName;
  String Gender;
  int stsId;
  String email;
  String phoneNumber;
  int appId;
  PatientDetails(
      {required this.userId, 
      required this.userType ,
      required this.accessToken,
      required this.userName,
      required this.Gender,
      required this.stsId,
      required this.email,
      required this. phoneNumber,
      required this.appId
      });
}