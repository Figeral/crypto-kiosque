import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:crypto_kiosque/utils/app_colors.dart';
import 'package:crypto_kiosque/models/transaction_model.dart';
import 'package:crypto_kiosque/viewmodels/TransactionViewModel.dart';

class AllTransactions extends StatefulWidget {
  const AllTransactions({super.key});

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  final _transcationVM = TransactionViewmodel();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: _transcationVM.fetchMessage(),
          builder: (context, snapshot) {
            print(snapshot.data?[1].data);
            if (snapshot.hasData) {
              final data = snapshot.data;

              return ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: CryptoMessage(json: data[index].data),
                    );
                  });
            } else {
              return const Center(
                child: SizedBox(
                    height: 100,
                    width: 150,
                    child: Row(
                      children: [
                        Text(
                          "Loading ...",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CircularProgressIndicator(),
                      ],
                    )),
              );
            }
          }),
    );
  }
}

class CryptoMessage extends StatelessWidget {
  CryptoMessage({
    Key? key,
    required this.json,
  }) : super(key: key);

  Map<String, dynamic> json;

  @override
  Widget build(BuildContext context) {
    // final _data = TransactionModel.fromJson(json);
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.deepPurple,
                    borderRadius: BorderRadius.circular(60),
                    //
                  ),
                  height: 80,
                  width: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(json['crypto']),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          json['crypto'],
                          style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "Purchase Operation ordered by ${json['phone']}  with  ${json['amount']}... ",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(15.0),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children: [
                //       Text(
                //         "\$${currentPrice.toStringAsFixed(2)}",
                //         style: TextStyle(
                //           color: Colors.grey[700],
                //           fontSize: 20,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       Text(
                //         "\%${percentageChange1h.toStringAsFixed(2)}",
                //         style: TextStyle(
                //           color: percentageChange1h > percentageChange24h
                //               ? Colors.greenAccent.shade400
                //               : Colors.redAccent,
                //           fontSize: 20,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
