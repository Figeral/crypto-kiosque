class CryptoEndPoint {
  final String _domain = "pro-api.coinmarketcap.com";
  final String _path = "/v1/cryptocurrency/listing/latest";

  final _headers = <String, String>{
    'Accepts': 'application/json',
    'X-CMC_PRO_API_KEY': 'a4f3d604-c523-42c0-8eb5-a4defaf85743',
  };

  final Map<String, String> _params = {
    'start': '1',
    'limit': '500',
    'convert': 'USD'
  };
  Map<String, String> get headers => _headers;
  Map<String, String> get params => _params;
  String get domain => _domain;
  String get path => _path;
}
