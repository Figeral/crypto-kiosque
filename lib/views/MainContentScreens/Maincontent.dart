import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:crypto_kiosque/constants/app_colors.dart';
import 'package:crypto_kiosque/views/MainContentScreens/home.dart';
import 'package:crypto_kiosque/models/app_modal/destion_icons.dart';
import 'package:crypto_kiosque/views/MainContentScreens/setting.dart';
import 'package:crypto_kiosque/views/MainContentScreens/history_page.dart';
import 'package:crypto_kiosque/views/MainContentScreens/support_client.dart';

class MainContent extends StatefulWidget {
  const MainContent({super.key});

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  final destination = [
    DestinationIcons(icon: Icon(Icons.home), label: "Home"),
    DestinationIcons(icon: Icon(Icons.history), label: "History"),
    DestinationIcons(icon: Icon(Icons.chat), label: "Support"),
    DestinationIcons(icon: Icon(Icons.settings), label: "Setting")
  ];
  navItem() {
    return destination
        .map(
            (item) => NavigationDestination(icon: item.icon, label: item.label))
        .toList();
  }

  final body = const <Widget>[
    HomePage(),
    HistoryPage(),
    SupportPage(),
    SettingPage()
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        body: body[_currentIndex],
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 20, left: 5, right: 5),
          width: 500,
          decoration: BoxDecoration(
              // color: Theme.of(context).scaffoldBackgroundColor,
              color: Colors.transparent,
              border: Border.all(width: 5, color: AppColors.deepPurple),
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: NavigationBar(
            backgroundColor: Colors.transparent,
            indicatorColor: AppColors.verylightpurple,
            elevation: 0,
            destinations: List.of(navItem()),
            selectedIndex: _currentIndex,
            onDestinationSelected: (value) =>
                setState(() => _currentIndex = value),
          ),
        ),
      ),
    );
  }
}
