import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:crypto_kiosque/utils/app_colors.dart';
import 'package:crypto_kiosque/views/EntryScreens/auth/signin.dart';
import 'package:crypto_kiosque/views/EntryScreens/auth/recovery.dart';
import 'package:crypto_kiosque/views/EntryScreens/auth/confirmation.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isObscure = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final sWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SvgPicture.asset(
                  "assets/images/login.svg",
                  width: 400,
                  alignment: Alignment.topCenter,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 5, 30, 25),
                  child: Column(
                    children: [
                      const Text(
                        "welcome back !",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(
                        width: sWidth * 0.68,
                        child: const Text(
                          "Please login to your account or create one ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 15, 30, 10),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Email Address",
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 15, 30, 10),
                          child: TextFormField(
                            obscureText: isObscure,
                            decoration: InputDecoration(
                              hintText: "Password",
                              suffix: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                                child: isObscure
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(sWidth * 0.60, 0, 0, 0),
                          child: GestureDetector(
                              //style: ButtonStyle(),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => RecoveryPage()));
                              },
                              child: const Text(
                                "forgot Password ?",
                                style: TextStyle(color: AppColors.tapButton),
                              )),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 50),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                  Size(sWidth * 0.87, 60)),
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.lightPurple),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: const Text(
                                        "A confirmation code was send to your address"),
                                    action: SnackBarAction(
                                      label: "undo",
                                      onPressed: () {},
                                    ),
                                  ),
                                );
                                Future.delayed(Duration(seconds: 3), () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) =>
                                          const ConfirmationPage())));
                                });
                              }
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .withOpacity(0.5),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.fromLTRB(sWidth * 0.20, 0, 0, 0),
                  child: GestureDetector(
                      //style: ButtonStyle(),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SigninPage()));
                      },
                      child: const Row(
                        children: [
                          Text(
                            "Don't have an account? ",
                          ),
                          Text(
                            "SignIn",
                            style: TextStyle(
                                color: AppColors.tapButton,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
