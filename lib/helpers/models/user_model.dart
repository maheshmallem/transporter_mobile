// To parse this JSON data, do
//
//     final getUserModel = getUserModelFromJson(jsonString);

import 'dart:convert';

getUserModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String getUserModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    required this.mobileNummber,
    required this.email,
    required this.role,
    required this.gender,
    required this.active,
    required this.verifiedPhone,
    required this.verifiedEmail,
    required this.dateOfBirth,
    required this.createdDate,
    required this.lastLoginDate,
    required this.updatedDate,
  });

  String id;
  String firstName;
  String lastName;
  String imageUrl;
  String mobileNummber;
  String email;
  String role;
  String gender;
  bool active;
  bool verifiedPhone;
  bool verifiedEmail;
  DateTime dateOfBirth;
  DateTime createdDate;
  DateTime lastLoginDate;
  DateTime updatedDate;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        imageUrl: json["image_url"],
        mobileNummber: json["mobile_nummber"],
        email: json["email"],
        role: json["role"],
        gender: json["gender"],
        active: json["active"],
        verifiedPhone: json["verified_phone"],
        verifiedEmail: json["verified_email"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        createdDate: DateTime.parse(json["created_date"]),
        lastLoginDate: DateTime.parse(json["last_login_date"]),
        updatedDate: DateTime.parse(json["updated_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "image_url": imageUrl,
        "mobile_nummber": mobileNummber,
        "email": email,
        "role": role,
        "gender": gender,
        "active": active,
        "verified_phone": verifiedPhone,
        "verified_email": verifiedEmail,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "created_date":
            "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "last_login_date":
            "${lastLoginDate.year.toString().padLeft(4, '0')}-${lastLoginDate.month.toString().padLeft(2, '0')}-${lastLoginDate.day.toString().padLeft(2, '0')}",
        "updated_date":
            "${updatedDate.year.toString().padLeft(4, '0')}-${updatedDate.month.toString().padLeft(2, '0')}-${updatedDate.day.toString().padLeft(2, '0')}",
      };
}
