import 'package:crypto_kiosque/models/usermodel.dart';
import 'package:crypto_kiosque/Configs/backend_server.dart';

class TransactionModel {
  UserModel user;
  String wallet;
  String crypto;
  double amount;
  int phone;
  String payment;
  TransactionModel(
      {required this.user,
      required this.wallet,
      required this.crypto,
      required this.amount,
      required this.phone,
      required this.payment});

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      user: UserModel.userGenerator(json['user']),
      wallet: json['wallet'],
      crypto: json['crypto'],
      amount: json['amount'],
      phone: json['phone'],
      payment: json['payment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': Server().server.authStore.model.id,
      'wallet': wallet,
      'crypto': crypto,
      'amount': amount,
      'phone': phone,
      'payment': payment,
    };
  }
}
