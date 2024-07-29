import 'package:flutter/widgets.dart';

class UserModel {
  String? id;
  String username;
  String email;
  String? profile;
  int tel;
  String pinCode;
  //DateTime created;
//DateTime updated;
  UserModel(
      {this.id,
      required this.username,
      required this.email,
      required this.tel,
      required this.pinCode,
      this.profile});
  factory UserModel.userGenerator(Map<String, dynamic> data) {
    return UserModel(
        // id: data["id"],
        username: data['username'],
        email: data["email"],
        tel: data['telephone'],
        profile: data['profile'],
        pinCode: data["pincode"]);
  }

  Map<String, dynamic> toJson() {
    return {
      //'id': id,
      'username': username,
      'email': email,
      'profile': profile,
      'tel': tel,
    };
  }

  @override
  String toString() => "${[id, username, email, tel, profile]}";
}
