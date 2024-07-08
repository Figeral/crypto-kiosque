class CryptoModel {
  final int id;
  final String name;
  final String symbol;
  final String slug;
  final Quote quote;
  final double circulatingSupply;

  CryptoModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.slug,
    required this.circulatingSupply,
    required this.quote,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      slug: json['slug'],
      circulatingSupply: double.parse((json['circulating_supply']).toString()),
      quote: Quote.fromJson(json['quote']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'symbol': symbol,
      'slug': slug,
      'circulating_supply': circulatingSupply,
      'quote': quote.toJson(),
    };
  }
}

class Quote {
  final double price;
  final double percentChange1h;
  final double percentChange24h;
  final double marketCap;

  Quote({
    required this.price,
    required this.percentChange1h,
    required this.percentChange24h,
    required this.marketCap,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      price: json['USD']['price'],
      percentChange1h: json['USD']['percent_change_1h'],
      percentChange24h: json['USD']['percent_change_24h'],
      marketCap: json['USD']['market_cap'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'percent_change_1h': percentChange1h,
      'percent_change_24h': percentChange24h,
      'market_cap': marketCap,
    };
  }
}
