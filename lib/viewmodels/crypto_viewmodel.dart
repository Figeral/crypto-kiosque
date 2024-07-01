import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto_kiosque/models/crypto_model.dart';
import 'package:crypto_kiosque/Configs/crypto_endpoint.dart';

///Implementation of a Singleton class cuz this class is resource draining , hence will be great to only have on instance of it
class CryptoViewModel {
  //Creation of broadcasting stream

  final _controller = StreamController.broadcast();
  Stream<dynamic> get stream => _controller.stream;
  void addStream() async => _controller.sink.add(await response);

//Creation of the Singleton class
  static final _instance = CryptoViewModel._();
  factory CryptoViewModel() {
    return _instance;
  }
  CryptoViewModel._();

  Future<List<dynamic>> fetchCrypto() async {
    final response = await http.get(Uri.parse(CryptoEndPoint().endPoint));
    return await jsonDecode(response.body) as List;
  }

  Future<List<dynamic>> get response async {
    final data = await fetchCrypto();
    print(" before de desirialization  ${data.first} \n \n");
    List<CryptoModel> result = [];
    data.forEach((element) {
      result.add(CryptoModel.fromJson(element));
    });
    final t = result
        .map((crypto) => [
              crypto.id,
              crypto.symbol,
              crypto.name,
              crypto.image,
              crypto.currentPrice,
              crypto.high24H,
              crypto.low24H,
              crypto.priceChange24H,
              crypto.priceChangePercentage24H,
              crypto.lastUpdated,
              crypto.marketCapChange24H,
              crypto.marketCapChangePercentage24H,
              crypto.totalVolume
            ])
        .toList();

    print("here is data ${t.first} \n \n");
    return t;
  }
}
