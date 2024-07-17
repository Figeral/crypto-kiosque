import 'package:pocketbase/pocketbase.dart';
import 'package:pocketbase/src/client.dart';
import 'package:crypto_kiosque/Configs/backend_server.dart';

class User {
  final _user = Server().server;
  RecordService get instance => _user.collection("users");
}
