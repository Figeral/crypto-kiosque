import 'dart:math' as math;
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:crypto_kiosque/constants/app_colors.dart';

class BuyTransaction extends StatefulWidget {
  const BuyTransaction({super.key});

  @override
  State<BuyTransaction> createState() => _BuyTransactionState();
}

class _BuyTransactionState extends State<BuyTransaction> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        AppBar(
          centerTitle: true,
          title: const Text(
            "BUY CRYPTO",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Transform.rotate(
                  angle: -math.pi / 3.7,
                  child: Icon(
                    Icons.add,
                    size: 40,
                  ),
                ))
          ],
        )
      ],
    );
  }
}
