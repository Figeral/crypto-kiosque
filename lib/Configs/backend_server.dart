import 'package:pocketbase/pocketbase.dart';

class Server {
  final _pb = PocketBase('https://katika.pockethost.io');
  // final _pb = PocketBase("http://127.0.0.1:8090");
  PocketBase get server => _pb;
}
