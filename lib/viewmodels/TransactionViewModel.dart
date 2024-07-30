import 'package:pocketbase/pocketbase.dart';
import 'package:crypto_kiosque/models/usermodel.dart';
import 'package:crypto_kiosque/Configs/backend_server.dart';
import 'package:crypto_kiosque/viewmodels/user_viewmodel.dart';

class TransactionViewmodel {
  final _transactionCollection = Server().server;
  RecordService get instance =>
      _transactionCollection.collection("transactions");

  TransactionViewmodel._();
  static final _instance = TransactionViewmodel._();

  factory TransactionViewmodel() => _instance;

  ///Method to create user
  Future<RecordModel> createTransaction({
    required Map<String, dynamic> json,
  }) async {
    // _transactionCollection.a;

    print(json);
    return await instance.create(body: {
      "user": json["userId"],
      "wallet": json["wallet"],
      "crypto": json['crypto'],
      'amount': json['amount'],
      'phone': json['phone'],
      'payment': json['payment'],
    });
  }

  ///update User information
  Future<RecordModel> updateUser({
    required String username,
    required String email,
    required String tel,
  }) async {
    return await instance.update(_transactionCollection.authStore.model.id,
        body: {"username": username, "email": email, "telephone": tel});
  }

  Future<dynamic> getMessage() async {
    return await instance.getFullList(
      sort: '-created',
      expand: 'user',
      filter: "user='${Server().server.authStore.model.id}'",
    );
  }

  Future<List<dynamic>> fetchMessage() async {
    List<dynamic> data = await getMessage();
    instance.subscribe('*', (e) async {
      data = await getMessage();
    });
    return data;
  }
}
