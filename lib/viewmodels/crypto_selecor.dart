import 'dart:async';

class CryptoSelectorStream {
  CryptoSelectorStream._();
  static final _instance = CryptoSelectorStream._();
  factory CryptoSelectorStream() {
    return _instance;
  }
  final _controller = StreamController<String>.broadcast();
  Stream<String> get stream => _controller.stream;
  void addStream(String value) {
    _controller.add(value);
  }
}
