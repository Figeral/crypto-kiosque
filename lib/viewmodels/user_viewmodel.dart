import 'package:pocketbase/pocketbase.dart';
import 'package:crypto_kiosque/models/usermodel.dart';
import 'package:crypto_kiosque/Configs/backend_server.dart';

class UserViewmodel {
  final _userCollection = Server().server;
  RecordService get instance => _userCollection.collection("users");

  UserViewmodel._();
  static final _instance = UserViewmodel._();

  factory UserViewmodel() => _instance;

  ///Get current user data
  UserModel get currentUser =>
      UserModel.userGenerator(_userCollection.authStore.model.data);

  ///Method to create user
  Future<RecordModel> createUser(
      {required String username,
      required String email,
      required int tel,
      required String pw,
      required String cpw}) async {
    return await instance.create(body: {
      "usernames": username,
      "email": email,
      "telephone": tel,
      'password': pw,
      'passwordConfirm': pw
    });
  }

  ///Register's a  user  and  returns an exception if the user's not found d
  Future<RecordAuth> loginUser(
      {required String email, required String pw}) async {
    return await instance.authWithPassword(email, pw);
  }

  ///update User information
  Future<RecordModel> updateUser(
      {required String username,
      required String email,
      required int tel,
      required String pincode}) async {
    return await instance.update(_userCollection.authStore.model.id, body: {
      "username": username,
      "email": email,
      "telephone": tel,
      "pincode": pincode
    });
  }

  ///deletes user
  Future<void> deleteUser() async {
    await instance.delete(_userCollection.authStore.model.id);
  }

  ///logout user
  Future<void> logoutUser() async => _userCollection.authStore.clear();
}
