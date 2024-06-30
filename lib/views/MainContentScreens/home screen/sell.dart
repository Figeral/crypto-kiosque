import 'dart:math' as math;
import 'package:flutter/material.dart';

class SellTransaction extends StatefulWidget {
  const SellTransaction({super.key});

  @override
  State<SellTransaction> createState() => _SellTransactionState();
}

class _SellTransactionState extends State<SellTransaction> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        appBar(context)
      ],
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        "SELL CRYPTO",
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
