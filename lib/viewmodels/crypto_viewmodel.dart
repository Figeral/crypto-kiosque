import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto_kiosque/models/crypto_model.dart';
import 'package:crypto_kiosque/Configs/crypto_endpoint.dart';

///Implementation of a Singleton class cuz this class is resource draining , hence will be great to only have on instance of it
class CryptoViewModel {
  //Creation of broadcasting stream
  final _controller = StreamController<List>.broadcast();
  Stream<dynamic> get stream => _controller.stream;
  Future<void> addStream() async => _controller.sink.add(await response);

//Creation of the Singleton class
  CryptoViewModel._();
  static final _instance = CryptoViewModel._();
  factory CryptoViewModel() {
    return _instance;
  }

  final _endpoint = CryptoEndPoint();
  Future<List<dynamic>> fetchCrypto() async {
    final response = await http.get(
        Uri.parse(
            "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=20&convert=USD"),
        // Uri.https(
        //   _endpoint.domain,
        //   _endpoint.path,
        //   _endpoint.params,
        // ),
        headers: _endpoint.headers);

    return await jsonDecode(response.body)['data'] as List;
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
              crypto.name,
              crypto.symbol,
              crypto.slug,
              crypto.quote.price,
              crypto.quote.percentChange1h,
              crypto.quote.percentChange24h,
              crypto.quote.marketCap,
              crypto.circulatingSupply,
            ])
        .toList();

    return t;
  }
}
