import 'dart:math' as math;
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:crypto_kiosque/utils/app_colors.dart';
import 'package:crypto_kiosque/utils/errors_messages.dart';
import 'package:crypto_kiosque/viewmodels/crypto_viewmodel.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:crypto_kiosque/views/MainContentScreens/home%20screen/crypto_list_search.dart';

class BuyTransaction extends StatefulWidget {
  const BuyTransaction({super.key});

  @override
  State<BuyTransaction> createState() => _BuyTransactionState();
}

class _BuyTransactionState extends State<BuyTransaction> {
  String? _scanBarcode;
  static final vm = CryptoViewModel();
  final listener = vm.stream.listen((event) {});
  String? _selectedOption = 'MTN Mobile Money';
  final List<String> _options = [
    'MTN Mobile Money',
    'Orange Mobile Money',
  ];
  int _textCounter = 0;
  final _controller = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
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

    return Column(
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
              const SizedBox(
                height: 100,
              ),
              SingleChildScrollView(
                child: SizedBox(
                  width: screenSize.width * 0.85,
                  child: Form(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Wallet Address'),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          SizedBox(
                            width: screenSize.width * 0.7,
                            child: TextField(
                              controller: _controller[0],
                              enabled: false,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
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
                              icon: const Icon(Icons.qr_code_scanner_sharp))
                        ],
                      ),
                      const Text('Phone Number'),
                      const SizedBox(height: 8.0),
                      TextField(
                        onChanged: (value) => setState(() =>
                            _textCounter = _controller[1].value.text.length),
                        controller: _controller[1],
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(9),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          hintText: 'Mobile Money number',
                          suffix: Text("${_textCounter}/9"),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text('Mobile Money'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          dropDownButton(screenSize),
                          chooseCrypto(context),
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
        fixedSize: MaterialStateProperty.all(
            Size(MediaQuery.of(context).size.width * 0.87, 60)),
        backgroundColor: MaterialStateProperty.all(AppColors.lightPurple),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {}
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

  SizedBox dropDownButton(Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.47,
      child: DropdownButtonFormField<String>(
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
          fixedSize: MaterialStateProperty.all(
              Size(MediaQuery.of(context).size.width * 0.35, 65)),
          backgroundColor: MaterialStateProperty.all(
              Theme.of(context).scaffoldBackgroundColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          side: MaterialStateProperty.all(const BorderSide(width: 0.6))),
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
      child: const Text(
        "Choose Crypto ",
        style: TextStyle(
          // color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
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
