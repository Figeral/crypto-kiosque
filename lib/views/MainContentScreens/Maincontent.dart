import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:crypto_kiosque/constants/app_colors.dart';
import 'package:crypto_kiosque/models/app_modal/destion_icons.dart';
import 'package:crypto_kiosque/views/MainContentScreens/home%20screen/home.dart';
import 'package:crypto_kiosque/views/MainContentScreens/settings%20screen/setting.dart';
import 'package:crypto_kiosque/views/MainContentScreens/history%20page/history_page.dart';
import 'package:crypto_kiosque/views/MainContentScreens/support_client%20screen/support_client.dart';
import 'package:crypto_kiosque/views/MainContentScreens/action%20buttons/principal_action_button.dart';

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
        appBar: AppBar(
          backgroundColor: _currentIndex == 0
              ? AppColors.deepPurple
              : Theme.of(context).scaffoldBackgroundColor,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: const CircleAvatar(
                backgroundImage: AssetImage("assets/images/user.png"),
              ),
            )
          ],
        ),
        body: body[_currentIndex],
        bottomNavigationBar: SafeArea(
          child: NavigationBar(
            backgroundColor: Colors.transparent,
            indicatorColor: AppColors.verylightpurple,
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
