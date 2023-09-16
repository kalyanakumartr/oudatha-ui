import 'dart:convert';

List<DoctorModel> dataModelFromJson(String str) =>
    List<DoctorModel>.from(json.decode(str).map((x) => DoctorModel.fromJson(x)));

String dataModelToJson(List<DoctorModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class DoctorModel{
  int userId;
  int categoryId;
  int docexpreience;
  

  DoctorModel( {required this.userId, required this.categoryId ,required this.docexpreience});
 factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      DoctorModel(
        userId: json["userId"],
        categoryId: json["categoryId"],
        docexpreience: json["docexpreience"]
      );

  Map<String, dynamic> toJson() =>
      {
        " userId":  userId,
        "categoryId":categoryId,
        "docexpreience":docexpreience
      };

}