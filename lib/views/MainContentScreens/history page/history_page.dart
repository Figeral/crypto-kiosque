import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:crypto_kiosque/constants/app_colors.dart';
import 'package:crypto_kiosque/views/MainContentScreens/history%20page/soldTransaction.dart';
import 'package:crypto_kiosque/views/MainContentScreens/history%20page/allTranscations.dart';
import 'package:crypto_kiosque/views/MainContentScreens/history%20page/boughtTransaction.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      child: Center(
          child: Column(
        children: [
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: SizedBox(
                  width: screenSize.width * 0.875,
                  //height: 80,
                  child: Card(
                    elevation: 2,
                    // color: AppColors.lightPurple.withOpacity(0.2),
                  ),
                ),
              )),
          Expanded(
              flex: 6,
              child: SizedBox(
                width: screenSize.width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Transactions",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: screenSize.width * 1,
                        child: TabBar(controller: _tabController, tabs: [
                          tabMaker("All"),
                          tabMaker("Bought"),
                          tabMaker("Sold")
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: screenSize.width * 1,
                        height: screenSize.height * 0.43,
                        child: TabBarView(
                            controller: _tabController,
                            children: const [
                              AllTransactions(),
                              BoughtTransactions(),
                              SoldTransactions()
                            ]),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      )),
    );
  }
}

Tab tabMaker(String text) {
  return Tab(
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}
