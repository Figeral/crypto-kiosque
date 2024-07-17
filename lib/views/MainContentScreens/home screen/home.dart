import 'package:otp/otp.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:crypto_kiosque/models/usermodel.dart';
import 'package:crypto_kiosque/utils/app_colors.dart';
import 'package:crypto_kiosque/Configs/backend_server.dart';
import 'package:crypto_kiosque/views/MainContentScreens/action%20buttons/transcation_actions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  RecordModel _model = Server().server.authStore.model;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final _user = UserModel.userGenerator(_model.data);

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
                          Text(Server().server.authStore.model),
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
