import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class BuyTransaction extends StatefulWidget {
  const BuyTransaction({super.key});

  @override
  State<BuyTransaction> createState() => _BuyTransactionState();
}

class _BuyTransactionState extends State<BuyTransaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buy crypto"),
      ),
    );
  }
}
