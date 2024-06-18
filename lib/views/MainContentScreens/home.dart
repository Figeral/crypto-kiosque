import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:crypto_kiosque/constants/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final sHeight = MediaQuery.of(context).size.height;
    final sWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.deepPurple,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/user.png"),
            ),
          )
        ],
      ),
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
                width: double.infinity,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(),
                  ],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      color: Colors.orange.shade100,
                      width: 400,
                      height: 800,
                    ),
                    Container(
                      color: Colors.amber.shade100,
                      width: 400,
                      height: 800,
                    )
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
