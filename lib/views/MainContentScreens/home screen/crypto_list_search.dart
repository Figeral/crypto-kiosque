import 'dart:async';
import 'package:flutter/material.dart';
import 'package:crypto_kiosque/models/crypto_model.dart';
import 'package:crypto_kiosque/viewmodels/crypto_selecor.dart';
import 'package:crypto_kiosque/viewmodels/crypto_viewmodel.dart';
import 'package:crypto_kiosque/views/MainContentScreens/home%20screen/cryptocard.dart';

class CryptoList extends SearchDelegate<CryptoModel> {
  List searchList = [];
  CryptoList({required this.searchList});
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
    final List<dynamic> searchResults = searchList
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index]),
          onTap: () {
            // Handle the selected search result.
            close(context, searchResults[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final cryptoSelector = CryptoSelectorStream();
    final List<dynamic> suggestionList = query.isEmpty
        ? searchList
        : searchList
            .where(
                (item) => item[1].toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: CryptoCard(
              name: suggestionList[index][1],
              symbol: suggestionList[index][2].toString().toLowerCase(),
              currentPrice: suggestionList[index][4],
              percentageChange1h: suggestionList[index][5],
              percentageChange24h: suggestionList[index][6],
              marketCap: suggestionList[index][7]),
          onTap: () {
            cryptoSelector.addStream(suggestionList[index][1]);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
