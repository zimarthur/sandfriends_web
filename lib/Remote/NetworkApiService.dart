import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'BaseApiService.dart';
import 'NetworkResponse.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future<NetworkResponse> getResponse(
      String baseUrl, String aditionalUrl) async {
    try {
      final response = await http.get(Uri.parse(baseUrl + aditionalUrl));
      print(response);
      return returnResponse(
        response,
      );
    } on SocketException {
      return NetworkResponse(
        responseStatus: NetworkResponseStatus.error,
        responseTitle: "Ops, você está sem acesso à internet",
        responseDescription: "Tente Novamente",
      );
    }
  }

  @override
  Future<NetworkResponse> postResponse(
    String baseUrl,
    String aditionalUrl,
    String body,
  ) async {
    print(baseUrl + aditionalUrl);
    print(body);
    try {
      final response = await http
          .post(
            Uri.parse(baseUrl + aditionalUrl),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: body,
          )
          .timeout(
            Duration(
              seconds: 10,
            ),
          );
      return returnResponse(response);
    } on SocketException {
      return NetworkResponse(
        responseStatus: NetworkResponseStatus.error,
        responseTitle: "Ops!",
        responseDescription: "você está sem acesso à internet",
      );
    } on TimeoutException catch (_) {
      return NetworkResponse(
        responseStatus: NetworkResponseStatus.error,
        responseTitle: "Ops!",
        responseDescription: "ocorreu um problema de conexão.",
      );
    }
  }

  NetworkResponse returnResponse(http.Response response) {
    String statusCode = response.statusCode.toString();
    print(statusCode);
    print(response.body);
    if (statusCode.startsWith("2")) {
      if (statusCode == "200") {
        return NetworkResponse(
          responseStatus: NetworkResponseStatus.success,
          responseBody: response.body,
        );
      }
      Map<String, dynamic> responseBody = json.decode(
        response.body,
      );
      if (statusCode == "231") {
        return NetworkResponse(
          responseStatus: NetworkResponseStatus.alert,
          responseTitle: responseBody['Title'],
          responseDescription: responseBody['Description'],
        );
      } else {
        return NetworkResponse(
          responseStatus: NetworkResponseStatus.error,
          responseTitle: responseBody['Title'],
          responseDescription: responseBody['Description'],
        );
      }
    } else if (statusCode.startsWith("5")) {
      return NetworkResponse(
        responseStatus: NetworkResponseStatus.error,
        responseTitle: "Ops!",
        responseDescription: "Ocorreu um problema de conexão.",
      );
    } else {
      return NetworkResponse(
        responseStatus: NetworkResponseStatus.error,
        responseTitle: "Ops, ocorreu erro.",
        responseDescription: "Tente Novamente",
      );
    }
  }
}
