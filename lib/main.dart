import 'package:flutter/material.dart';
import 'package:crypto_kiosque/Configs/backend_server.dart';
import 'package:crypto_kiosque/views/EntryScreens/auth/login.dart';
import 'package:crypto_kiosque/views/EntryScreens/onboardign.dart';
import 'package:crypto_kiosque/views/MainContentScreens/Maincontent.dart';

void main() async {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Poppins"),
      // home: const Onboard(),
      // home: const MainContent(),
      home: Server().server.authStore.token != null
          ? const MainContent()
          : const Login(),
    );
  }
}
