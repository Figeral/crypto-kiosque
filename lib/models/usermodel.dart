import 'package:flutter/widgets.dart';

class UserModel {
  String id;
  String username;
  String email;
  String? profile;
  int tel;
  //DateTime created;
//DateTime updated;
  UserModel(
      {required this.id,
      required this.username,
      required this.email,
      required this.tel,
      this.profile});
  factory UserModel.userGenerator(Map<String, dynamic> data) {
    return UserModel(
      id: data["id"],
      username: data['username'],
      email: data["email"],
      tel: data['telephone'],
      // profile: data['profile']
    );
  }
  @override
  String toString() => "${[id, username, email, tel, profile]}";
}
