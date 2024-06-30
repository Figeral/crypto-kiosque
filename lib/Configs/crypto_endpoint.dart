class CryptoEndPoint {
  String _endPoint =
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false";
  String get endPoint => _endPoint;
  set endPoint(String endpoint) => _endPoint = endpoint;
}
