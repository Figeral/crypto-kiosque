import 'package:flutter/material.dart';
import 'package:crypto_kiosque/constants/app_colors.dart';

class CryptoCard extends StatelessWidget {
  CryptoCard({
    Key? key,
    required this.name,
    required this.symbol,
    required this.currentPrice,
    required this.percentageChange1h,
    required this.percentageChange24h,
    required this.marketCap,
  }) : super(key: key);

  String name;
  String symbol;
  double currentPrice;
  double marketCap;
  double percentageChange1h;
  double percentageChange24h;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          // color: AppColors.deepPurple,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.deepPurple,
                      borderRadius: BorderRadius.circular(20),
                      //
                    ),
                    height: 60,
                    width: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.network(
                          "https://assets.coincap.io/assets/icons/${symbol}@2x.png"),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          name,
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        symbol,
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "\$${currentPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\%${percentageChange1h.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: percentageChange1h > percentageChange24h
                              ? Colors.greenAccent.shade400
                              : Colors.redAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Market Cap: ",
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$${marketCap.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
