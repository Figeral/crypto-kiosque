import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:crypto_kiosque/constants/app_colors.dart';
import 'package:crypto_kiosque/views/EntryScreens/auth/login.dart';
import 'package:crypto_kiosque/views/MainContentScreens/Maincontent.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({super.key});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(children: [
              inputField(),
              ResendCode(context),
              gridView(),
              dialField()
            ]),
          ),
        ),
      ),
    );
  }

  GestureDetector ResendCode(BuildContext context) {
    return GestureDetector(
      //resend code,
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Login()));
      },
      child: Text(
        "Resend Code ",
        style: TextStyle(color: AppColors.dangerButton),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // FocusScope.of(context).requestFocus(FocusNode());
  }

  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  final textfield = TextEditingController();

  onNumberTapped(number) {
    setState(() {
      FocusScope.of(context).requestFocus(FocusNode());
      textfield.text += number;
    });
  }

  onCancelText() {
    if (textfield.text.isNotEmpty) {
      var newvalue = textfield.text.substring(0, textfield.text.length - 1);
      setState(() {
        textfield.text = newvalue;
      });
    }
  }

  Widget inputField() {
    return Container(
      color: Colors.white,
      height: 100,
      alignment: Alignment.bottomCenter,
      child: TextFormField(
        focusNode: _focusNode,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        controller: textfield,
        decoration: InputDecoration(
            border: InputBorder.none,
            suffix: GestureDetector(
              onTap: () => onCancelText(),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Icon(Icons.backspace),
              ),
            )),
      ),
    );
  }

  Widget gridView() {
    return Container(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 80, bottom: 0),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        children: [
          keyField("1", ""),
          keyField("2", "A B C"),
          keyField("3", "D E F"),
          keyField("4", "G H I"),
          keyField("5", "J K L"),
          keyField("6", "M N O"),
          keyField("7", "P Q R S"),
          keyField("8", "T U V"),
          keyField("9", "W X Y Z"),
          starField(),
          keyField("0", "+"),
          hashField(),

          // dialField(),
        ],
      ),
    );
  }

  Widget keyField(numb, dsc) {
    return InkWell(
      onTap: () => onNumberTapped(numb),
      child: Container(
        height: 40,
        width: 40,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Color.fromARGB(24, 150, 20, 183),
            borderRadius: BorderRadius.circular(60)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              numb,
              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            Text(
              dsc,
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }

  Widget starField() {
    return InkWell(
      onTap: () => onNumberTapped("*"),
      child: Container(
        height: 40,
        width: 40,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Color.fromARGB(24, 150, 20, 183),
            borderRadius: BorderRadius.circular(60)),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "*",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget hashField() {
    return InkWell(
      onTap: () => onNumberTapped("#"),
      child: Container(
        height: 40,
        width: 40,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: AppColors.verylightpurple,
            borderRadius: BorderRadius.circular(60)),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "#",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  backSpace() {
    if (textfield.text.isNotEmpty) {
      return InkWell(
        child: Container(
          height: 40,
          width: 40,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(60)),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.backspace_outlined,
                size: 30,
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(height: 0);
    }
  }

  Widget dialField() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.2),
      child: FittedBox(
        child: InkWell(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.lightPurple,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 60,
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Confirm",
                  style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MainContent()));
          },
        ),
      ),
    );
  }
}
