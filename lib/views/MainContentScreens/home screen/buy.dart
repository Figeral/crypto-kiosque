import 'dart:math' as math;
import 'package:http/http.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:crypto_kiosque/utils/app_colors.dart';
import 'package:crypto_kiosque/utils/errors_messages.dart';
import 'package:crypto_kiosque/Configs/backend_server.dart';
import 'package:crypto_kiosque/models/transaction_model.dart';
import 'package:crypto_kiosque/viewmodels/user_viewmodel.dart';
import 'package:crypto_kiosque/viewmodels/crypto_selecor.dart';
import 'package:crypto_kiosque/viewmodels/crypto_viewmodel.dart';
import 'package:crypto_kiosque/viewmodels/TransactionViewModel.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:crypto_kiosque/views/MainContentScreens/home%20screen/crypto_list_search.dart';

class BuyTransaction extends StatefulWidget {
  const BuyTransaction({super.key});

  @override
  State<BuyTransaction> createState() => _BuyTransactionState();
}

class _BuyTransactionState extends State<BuyTransaction> {
  final _userVm = UserViewmodel();

  String cryptoInfo = "";
  String? _scanBarcode;
  static final vm = CryptoViewModel();
  final listener = vm.stream.listen((event) {});
  String? _selectedOption = '';
  final List<String> _options = [
    '',
    'MTN Mobile Money',
    'Orange Mobile Money',
  ];
  int _textCounter = 0;
  final _controller = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.forEach((element) => element.dispose());
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 15),
            child: appBar(context),
          ),
          const Divider(
            height: 10,
            indent: 20,
            endIndent: 20,
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  width: screenSize.width * 0.68,
                  child: Text(
                    "Agent must have client's cash before  handling any purchase Transaction",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Colors.grey.shade500),
                  ),
                ),
                // Sample content screen
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    width: screenSize.width * 0.85,
                    child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12.0),
                            const Text('Wallet Address'),
                            Row(
                              children: [
                                SizedBox(
                                  width: screenSize.width * 0.7,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (_scanBarcode == null ||
                                          _scanBarcode!.length < 1) {
                                        return "must input wallet address";
                                      }
                                      return null;
                                    },
                                    controller: _controller[0],
                                    enabled: false,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      hintText: _scanBarcode ??
                                          'Scan client wallet qr code',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                    onPressed: scanQR,
                                    icon:
                                        const Icon(Icons.qr_code_scanner_sharp))
                              ],
                            ),
                            const SizedBox(height: 12.0),
                            const Text('Phone Number'),
                            TextFormField(
                              validator: (value) {
                                if (_controller[1].text.isEmpty) {
                                  return "must input a phone number";
                                }
                                return null;
                              },
                              onChanged: (value) => setState(() =>
                                  _textCounter =
                                      _controller[1].value.text.length),
                              controller: _controller[1],
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(9),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                hintText: 'Mobile Money number',
                                suffix: Text("${_textCounter}/9"),
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            const Text('Amount'),
                            Row(
                              children: [
                                SizedBox(
                                  width: screenSize.width * 0.48,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (_controller[2].text.isEmpty) {
                                        return "must enter volume of coins";
                                      }
                                      return null;
                                    },
                                    controller: _controller[2],
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(9),
                                      //\ FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        hintText: 'crypto amount',
                                        suffix: Text("\$")),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                chooseCrypto(context),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            const Text('Mobile payment'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                dropDownButton(screenSize),
                              ],
                            ),
                            const SizedBox(height: 30.0),
                            purchaseButton(context),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> scanQR() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  ElevatedButton purchaseButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(
            Size(MediaQuery.of(context).size.width * 0.87, 60)),
        backgroundColor: WidgetStateProperty.all(AppColors.lightPurple),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: () {
        try {
          if (_formKey.currentState!.validate()) {
            purchaseDialog(context);
          }
        } catch (e) {
          print(e.toString());
        }
      },
      child: Text(
        'Buy',
        style: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
            fontWeight: FontWeight.bold,
            fontSize: 20),
      ),
    );
  }

  Future<dynamic> purchaseDialog(BuildContext context) async {
    final _transaction = TransactionModel(
      wallet: _scanBarcode!,
      phone: int.parse(_controller[1].text),
      amount: double.parse(_controller[2].text),
      crypto: cryptoInfo.split("+")[0],
      payment: _selectedOption ?? "choose payement",
      user: _userVm.currentUser,
    );
    final controller = TextEditingController();
    final sendKey = GlobalKey<FormState>();
    return await showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
              title: const Text("Confirmation"),
              children: [
                Text(
                  "Purchase Operation ordered by ${_transaction.phone}  willing to recharge ${_transaction.amount}  ${_transaction.crypto} coins in his wallet ${_transaction.wallet} \n which is actually at ${double.parse(cryptoInfo.split("+")[1]).toStringAsFixed(3)} \$  Using ${_transaction.payment} method \n\n enter your code pin to confirm",
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: sendKey,
                  child: TextFormField(
                    autofocus: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "must enter a confirmation pin Code";
                      } else if (value != _userVm.currentUser.pinCode) {
                        return "input pin code is correct";
                      }
                      return null;
                    },
                    controller: controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      hintText: 'confirm transaction',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Text("cancel")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          onPressed: () async {
                            if (sendKey.currentState!.validate()) {
                              try {
                                await TransactionViewmodel().createTransaction(
                                    json: _transaction.toJson());
                                Navigator.of(context).pop();
                              } catch (e) {
                                // print(e.toString());
                                ErrorModal.showErrorDialog(context,
                                    "Error arose during transaction \n check your network or crypto currency ");
                              }
                            }
                          },
                          icon: const Text("ok")),
                    )
                  ],
                )
              ],
            ));
  }

  SizedBox dropDownButton(Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.47,
      child: DropdownButtonFormField<String>(
        validator: (value) {
          if (_selectedOption!.length < 2) {
            return "choose a payment method";
          }
          return null;
        },
        value: _selectedOption,
        elevation: 10,
        onChanged: (newValue) {
          print(_selectedOption);

          _selectedOption = newValue!;
        },
        items: _options.map((option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }

  ElevatedButton chooseCrypto(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          fixedSize: WidgetStateProperty.all(
              Size(MediaQuery.of(context).size.width * 0.35, 60)),
          backgroundColor: WidgetStateProperty.all(
              Theme.of(context).scaffoldBackgroundColor),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          side: WidgetStateProperty.all(const BorderSide(width: 0.6))),
      onPressed: () async {
        try {
          await vm.addStream();
          listener.onData((data) async {
            await showSearch(
              context: context,
              delegate: CryptoList(searchList: data),
            );
          });
        } catch (e) {
          ErrorModal.showErrorDialog(context,
              "Failed to load \n probably no  Internet connection . Check your internet connection status and restart again");
        }
      },
      child: CryptoName(
        changeName: (crypto) {
          cryptoInfo = crypto;
        },
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        "BUY CRYPTO",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton.filledTonal(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Transform.rotate(
              angle: (math.pi / 4),
              child: Icon(
                Icons.add,
                size: 40,
              ),
            ))
      ],
    );
  }
}

class CryptoName extends StatelessWidget {
  final cryptoSelector = CryptoSelectorStream();
  void Function(String crypto) changeName;
  CryptoName({super.key, required this.changeName});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: cryptoSelector.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            changeName(snapshot.data.toString());
            return Text(
              snapshot.data.toString().split('+')[0],
              style: TextStyle(
                // color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            );
          }
          return const Text(
            "Choose Crypto ",
            style: TextStyle(
              // color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          );
        });
  }
}
