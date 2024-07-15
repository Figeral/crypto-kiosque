import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            //color: Colors.blueAccent.shade400,
            width: screenSize.width * 0.8,
            height: screenSize.height * 0.4,
            child: Text("Support client"),
          ),
        ),
      ],
    );
  }
}
