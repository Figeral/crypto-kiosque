import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:crypto_kiosque/utils/app_colors.dart';
import 'package:crypto_kiosque/views/MainContentScreens/home%20screen/buy.dart';
import 'package:crypto_kiosque/views/MainContentScreens/home%20screen/sell.dart';

class TransactionActionButton extends StatelessWidget {
  final BuildContext context;
  const TransactionActionButton({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    final parentSize = MediaQuery.of(context).size;
    final size = MediaQuery.of(context).size.width;
    final screenConstraints = [0.446, 0.179];
    return Padding(
      padding: EdgeInsets.only(
        left: size * 0.07,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          transactionButton(size, screenConstraints, context, parentSize, "Buy",
              const BuyTransaction()),
          transactionButton(size, screenConstraints, context, parentSize,
              "Sell", const SellTransaction()),
        ],
      ),
    );
  }

  Opacity transactionButton(double size, List<double> screenConstraints,
      BuildContext context, Size parentSize, String label, Widget destination) {
    return Opacity(
      opacity: 0.8,
      child: ElevatedButton(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(AppColors.deepPurple),
          elevation: WidgetStateProperty.all(5),
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
          fixedSize: WidgetStateProperty.all(
              Size(size * screenConstraints[0], size * screenConstraints[1])),
        ),
        onPressed: () {
          bottomSheet(context, parentSize, destination);
        },
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Future<dynamic> bottomSheet(
      BuildContext context, Size parentSize, Widget child) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        isScrollControlled: true,
        context: context,
        builder: (context) => Container(
              //color: Colors.white,
              child: SizedBox(
                  width: parentSize.width,
                  height: parentSize.height * 0.9,
                  child: child),
            ));
  }
}
