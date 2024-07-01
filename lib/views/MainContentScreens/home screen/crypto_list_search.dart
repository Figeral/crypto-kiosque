import 'dart:async';
import 'package:flutter/material.dart';
import 'package:crypto_kiosque/models/crypto_model.dart';
import 'package:crypto_kiosque/viewmodels/crypto_viewmodel.dart';

class CryptoList extends SearchDelegate<CryptoModel> {
  List data;
  CryptoList({required this.data});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Text("");
  }
}
