import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:crypto_kiosque/constants/app_colors.dart';
import 'package:crypto_kiosque/views/MainContentScreens/action%20buttons/transcation_actions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: TransactionActionButton(context: context),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              stops: [105, 210],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [AppColors.deepPurple, AppColors.lightPurple]),
        ),
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("New day"),
                        ],
                      ),
                    ],
                  ),
                )),
            Expanded(
              flex: 10,
              child: Container(
                width: screenSize.width,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(),
                  ],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Column(children: [
                        Container(
                          color: Colors.orange.shade100,
                          width: screenSize.width * 0.85,
                          height: 800,
                        ),
                        Container(
                          color: Colors.black38,
                          width: screenSize.width * 0.85,
                          height: 800,
                        )
                      ]),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
