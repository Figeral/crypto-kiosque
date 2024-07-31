import 'package:otp/otp.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:crypto_kiosque/utils/snackbars.dart';
import 'package:crypto_kiosque/utils/app_colors.dart';
import 'package:crypto_kiosque/utils/errors_messages.dart';
import 'package:crypto_kiosque/Configs/backend_server.dart';
import 'package:crypto_kiosque/views/MainContentScreens/Maincontent.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({super.key});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  final _controller = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  final RecordModel _userModel = Server().server.authStore.model;
  String _otp = '';

  @override
  void initState() {
    setState(() {
      _otp = otpGenerator();
    });
    mailer(_otp);
    print(_otp);
    super.initState();
  }

  @override
  void dispose() {
    for (var element in _controller) {
      element.dispose();
    }
    super.dispose();
  }

  void mailer(String otp) async {
    final TwilioFlutter twilioClient = TwilioFlutter(
        accountSid: 'ACd3e546dd94ebb9ee03bfcf8f05744280',
        authToken: 'afd719b1ebe937c0e203e39f9e90ce1c',
        twilioNumber: '+18102158548');
    try {
      final res = await twilioClient.sendSMS(
          toNumber: '+237690462556',
          // toNumber: "+" + _userModel.data["telephone"].toString(),
          messageBody: "your code : $otp");
      print(res);
    } on TwilioFlutterException {
      ErrorModal.showErrorDialog(context,
          "Error during send code \n check your internet connection or phone number and  restart again");
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SvgPicture.asset(
                  "assets/images/otp.svg",
                  width: screenSize.width / 1.5,
                  alignment: Alignment.topCenter,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 5, 30, 25),
                  child: Column(
                    children: [
                      const Text(
                        "Verification Code",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(
                        width: screenSize.width * 0.75,
                        child: Column(
                          children: [
                            Text(
                              "A confirmation code was send to ${_userModel.data["telephone"].toString().substring(0, 6)}**** \n if not received click on resend ",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                          ],
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
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 10),
                                  child: SizedBox(
                                    height: 68,
                                    width: 68,
                                    child: TextFormField(
                                      controller: _controller[0],
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 10),
                                  child: SizedBox(
                                    height: 68,
                                    width: 68,
                                    child: TextFormField(
                                      controller: _controller[1],
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 10),
                                  child: SizedBox(
                                    height: 68,
                                    width: 68,
                                    child: TextFormField(
                                      controller: _controller[2],
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 10),
                                  child: SizedBox(
                                    height: 68,
                                    width: 68,
                                    child: TextFormField(
                                      controller: _controller[3],
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 10, 50),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  fixedSize: WidgetStateProperty.all(
                                      Size(screenSize.width * 0.38, 60)),
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.white),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: AppColors.lightPurple,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _otp = otpGenerator();
                                  });
                                  mailer(_otp);
                                  SnackBarMessenger().stateSnackMessenger(
                                      context: context,
                                      message: "Code resend",
                                      type: "pending");
                                },
                                child: Text(
                                  'Resend',
                                  style: TextStyle(
                                      color:
                                          AppColors.deepPurple.withOpacity(0.5),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 50),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  fixedSize: WidgetStateProperty.all(
                                      Size(screenSize.width * 0.38, 60)),
                                  backgroundColor: WidgetStateProperty.all(
                                      AppColors.lightPurple),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (_otp ==
                                      _controller[0].text +
                                          _controller[1].text +
                                          _controller[2].text +
                                          _controller[3].text) {
                                    Future.delayed(const Duration(seconds: 3), () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  const MainContent())));
                                    });
                                  } else {
                                    SnackBarMessenger().stateSnackMessenger(
                                        context: context,
                                        message: "Code Incorrect \n restart",
                                        type: "error");
                                  }
                                },
                                child: Text(
                                  'Confirm',
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
                        ),
                      ],
                    )),
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(screenSize.width * 0.20, 0, 0, 0),
                  child: const Row(
                    children: [
                      Text(
                        "Resend Code after ",
                      ),
                      Text(
                        "02:00",
                        style: TextStyle(
                            color: AppColors.tapButton,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String otpGenerator() => OTP.generateTOTPCodeString(
      length: 4,
      'JBSWY3DPEHPK3PXP',
      DateTime.now().millisecondsSinceEpoch,
      interval: 1,
      algorithm: Algorithm.SHA512);
}
