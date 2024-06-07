import 'package:flutter/material.dart';
import 'views/EntryScreens/splash.dart';
import 'package:crypto_kiosque/views/EntryScreens/onboardign.dart';

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
      home: const Onboard(),
    );
  }
}
