class CommonException implements Exception {
  final int code;
  final String message;

  CommonException({required this.code, required this.message});

  @override
  String toString() => '$code, $message';
}

class FixedException {
  static const errorUnknown = 'Unknown error occurred! Please check your internet connection and try again!';
  static const errorTimeout = 'Sorry, not able to connect to server! Try after sometime.';
}