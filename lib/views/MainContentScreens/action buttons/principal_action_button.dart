import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:crypto_kiosque/constants/app_colors.dart';
import 'package:crypto_kiosque/views/MainContentScreens/home%20screen/transcations/buy.dart';
import 'package:crypto_kiosque/views/MainContentScreens/home%20screen/transcations/sell.dart';

class PrimaryActionButton extends StatelessWidget {
  final BuildContext context;
  const PrimaryActionButton({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    final sWidth = MediaQuery.of(context).size.width;
    final sHeight = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
        left: sWidth * 0.07,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Opacity(
            opacity: 0.8,
            child: ElevatedButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(AppColors.deepPurple),
                elevation: MaterialStateProperty.all(5),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
                fixedSize: MaterialStateProperty.all(const Size(200, 80)),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const BuyTransaction()));
              },
              child: const Text(
                "Buy",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Opacity(
            opacity: 0.8,
            child: ElevatedButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(AppColors.deepPurple),
                // backgroundColor:
                //     MaterialStateProperty.all(AppColors.lightPurple),
                elevation: MaterialStateProperty.all(5),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
                fixedSize: MaterialStateProperty.all(const Size(200, 80)),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SellTransaction()));
              },
              child: const Text(
                "Sell",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
