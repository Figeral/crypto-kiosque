import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:crypto_kiosque/utils/snackbars.dart';
import 'package:crypto_kiosque/utils/app_colors.dart';
import 'package:crypto_kiosque/utils/errors_messages.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:crypto_kiosque/viewmodels/user_viewmodel.dart';
import 'package:crypto_kiosque/views/EntryScreens/auth/login.dart';
import 'package:crypto_kiosque/views/EntryScreens/auth/recovery.dart';
import 'package:crypto_kiosque/views/EntryScreens/auth/confirmation.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  String _code = "+237";
  int _textCounter = 0;
  bool isObscure = true;
  final _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  @override
  void dispose() {
    _controllers.forEach((e) => e.dispose());
    super.dispose();
  }

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
                  "assets/images/signIn.svg",
                  width: 400,
                  alignment: Alignment.topCenter,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 5, 30, 25),
                  child: Column(
                    children: [
                      const Text(
                        "Let\'s get started ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(
                        width: sWidth * 0.68,
                        child: const Text(
                          "A confirmation code will be send to your e-mail address",
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
                            validator: (value) {
                              if (!(value!.contains("@"))) {
                                return "The email format is incorrect";
                              }
                            },
                            controller: _controllers[0],
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
                            validator: (value) {
                              if (value!.length < 9) {
                                return "Phone number too short , atleast 9 digit needed";
                              }
                            },
                            onChanged: (value) => setState(() =>
                                _textCounter = _controllers[1].text.length),
                            controller: _controllers[1],
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(9),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              suffix: Text("$_textCounter/9"),
                              prefixIcon: CountryCodePicker(
                                onChanged: (value) {
                                  setState(() {
                                    _code = value.toString();
                                  });
                                },
                                dialogSize: Size(500, 450),
                                hideMainText: true,
                                showFlagMain: true,
                                showFlag: true,
                                initialSelection: 'CM',
                                showOnlyCountryWhenClosed: true,
                              ),
                              hintText: "Telephone",
                              border: const OutlineInputBorder(
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
                            validator: (value) {
                              if (value!.length <= 4) {
                                return "Passord too short , atleast 5 characters needed";
                              }
                            },
                            controller: _controllers[2],
                            decoration: InputDecoration(
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
                              hintText: "Password",
                              border: const OutlineInputBorder(
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
                            validator: (value) {
                              if (_controllers[2].text !=
                                  _controllers[3].text) {
                                return "input different from password";
                              }
                            },
                            controller: _controllers[3],
                            decoration: InputDecoration(
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
                              hintText: "Confirmation",
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                          ),
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
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await addUser(
                                  context: context,
                                  userName: '',
                                  email: _controllers[0].text,
                                  tel: int.parse(_code + _controllers[1].text),
                                  pw: _controllers[3].text,
                                );
                              }
                            },
                            child: Text(
                              'SignIn',
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
                            builder: (context) => const Login()));
                      },
                      child: const Row(
                        children: [
                          Text(
                            "Already have an account? ",
                          ),
                          Text(
                            "Login",
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

  Future<void> addUser(
      {required BuildContext context,
      required String userName,
      required String email,
      required int tel,
      required String pw,
      String? link}) async {
    try {
      final user = User().instance;
      await user.create(body: {
        "usernames": userName,
        "email": email,
        "telephone": tel,
        'password': pw,
        'passwordConfirm': pw
      });
      SnackBarMessenger().stateSnackMessenger(
          context: context,
          message: "Credential confirmation Pending",
          type: "pending");

      Navigator.of(context)
          .push(MaterialPageRoute(builder: ((context) => const Login())));
    } catch (e) {
      print(e.toString());
      ErrorModal.showErrorDialog(
          context, e.toString().split("message:")[1].split(",")[0]);
    }
  }
}
