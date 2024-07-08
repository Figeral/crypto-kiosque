import 'dart:math' as math;
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:crypto_kiosque/constants/app_colors.dart';
import 'package:crypto_kiosque/viewmodels/crypto_viewmodel.dart';
import 'package:crypto_kiosque/views/MainContentScreens/home%20screen/crypto_list_search.dart';

class BuyTransaction extends StatefulWidget {
  const BuyTransaction({super.key});

  @override
  State<BuyTransaction> createState() => _BuyTransactionState();
}

class _BuyTransactionState extends State<BuyTransaction> {
  static final vm = CryptoViewModel();
  final listener = vm.stream.listen((event) {});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        // const SizedBox(
        //   height: 15,
        // ),
        // const Divider(
        //   height: 10,
        //   thickness: 05,
        //   indent: 180,
        //   endIndent: 180,
        // ),
        const SizedBox(
          height: 20,
        ),
        appBar(context),
        const SizedBox(
          height: 15,
        ),
        const Divider(
          height: 10,
          indent: 20,
          endIndent: 20,
        ),
        SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  width: screenSize.width * 0.68,
                  child: Text(
                    "Agent must have client's cash before \n handling any purchase Transaction",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Colors.grey.shade500),
                  ),
                ),
                // Sample content screen
                const SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await vm.addStream();
                    listener.onData((data) async {
                      print(" Data from Listener $data");
                      await showSearch(
                        context: context,
                        delegate: CryptoList(searchList: data),
                      );
                    });
                  },
                  child: const Text("Choose Crypto "),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        "BUY CRYPTO",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton.filledTonal(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Transform.rotate(
              angle: (math.pi / 4),
              child: Icon(
                Icons.add,
                size: 40,
              ),
            ))
      ],
    );
  }
}
