class NetworkResponse {
  bool requestSuccess;
  String? errorMessage;
  dynamic responseBody;

  NetworkResponse({
    required this.requestSuccess,
    this.errorMessage,
    this.responseBody,
  });
}
