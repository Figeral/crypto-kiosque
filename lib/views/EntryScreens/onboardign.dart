import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:crypto_kiosque/constants/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:crypto_kiosque/views/EntryScreens/auth/login.dart';

//import 'package:flutter_gif/flutter_gif.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  int _pageIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sHeight = MediaQuery.of(context).size.height;
    final sWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (value) => setState(() {
              _pageIndex = value;
            }),
            controller: _pageController,
            children: [
              PageDetail(
                sHeight: sHeight,
                sWidth: sWidth,
                image: "assets/images/BitcoinP2P.png",
                text:
                    "page1 /nLorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce quis magna vel magna efficitur dictum. Vivamus ac lacus sed magna efficitur dictum. Vivamus ac lacus sed magna efficitur dictum.",
              ),
              PageDetail(
                sHeight: sHeight,
                sWidth: sWidth,
                image: "assets/images/Server.png",
                text:
                    "page2 /n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce quis magna vel magna efficitur dictum. Vivamus ac lacus sed magna efficitur dictum. Vivamus ac lacus sed magna efficitur dictum.",
              ),
              PageDetail(
                sHeight: sHeight,
                sWidth: sWidth,
                image: "assets/images/Coins-amico.png",
                text: "page1 /nLorem ipsum dolor sit amet, consectetur",
                button: button(context, sWidth),
              ),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Visibility(
                  visible: _pageIndex > 0 ? true : false,
                  child: InkWell(
                    onTap: () {
                      _pageController.previousPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeIn);
                    },
                    child: const SizedBox(
                      width: 55,
                      child: Text("prev"),
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  effect: const WormEffect(
                      activeDotColor: Colors.deepPurple,
                      spacing: 10,
                      type: WormType.normal),
                  controller: _pageController,
                  count: 3,
                  onDotClicked: (index) {
                    if (index > _pageIndex) {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeIn);
                    } else {
                      _pageController.previousPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeIn);
                    }
                  },
                ),
                Visibility(
                  visible: _pageIndex < 2 ? true : false,
                  child: InkWell(
                    onTap: () {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeIn);
                    },
                    child: const SizedBox(
                      width: 55,
                      child: Text("next"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton button(BuildContext context, double sWidth) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Login()));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightPurple,
        minimumSize: Size(
          sWidth * 0.6,
          60.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: const Text(
        'Commencer',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}

Widget PageDetail(
    {required double sHeight,
    required double sWidth,
    required String image,
    required String text,
    Widget? button}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(0, sWidth * 0, 0, sWidth * 0.3),
    child: Container(
      //color: Colors.grey,
      width: sWidth,
      height: sHeight * 0.50,
      child: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, sWidth * 0.3, 0, 0),
          child: Column(
            children: [
              Image(
                width: sWidth * 0.8,
                image: AssetImage(image),
              ),
              SizedBox(
                height: sHeight * 0.08,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 0, 10),
                child: Text(
                  text,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: sHeight * 0.05,
              ),
              button ?? const SizedBox()
            ],
          ),
        ),
      ),
    ),
  );
}
