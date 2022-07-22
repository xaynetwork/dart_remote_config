class RemoteConfigParserException implements Exception {
  final String message;

  const RemoteConfigParserException(this.message);

  @override
  String toString() => "RemoteConfigParserException: $message";
}
