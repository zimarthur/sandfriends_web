import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'AppException.dart';
import 'BaseApiService.dart';
import 'NetworkResponse.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future<NetworkResponse> getResponse(
      String baseUrl, String aditionalUrl) async {
    try {
      final response = await http.get(Uri.parse(baseUrl + aditionalUrl));
      return returnResponse(
        response,
      );
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  @override
  Future<NetworkResponse> postResponse(
    String baseUrl,
    String aditionalUrl,
    String body,
  ) async {
    print(body);
    print(baseUrl);
    print(aditionalUrl);
    final response = await http.post(
      Uri.parse(baseUrl + aditionalUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    return returnResponse(response);
  }

  NetworkResponse returnResponse(http.Response response) {
    String statusCode = response.statusCode.toString();
    if (statusCode.startsWith("2")) {
      if (statusCode == "200" || statusCode == "231") {
        return NetworkResponse(
          requestSuccess: true,
          responseBody: response.body,
        );
      } else {
        return NetworkResponse(
            requestSuccess: false, errorMessage: response.body);
      }
    } else if (statusCode.startsWith("5")) {
      return NetworkResponse(
          requestSuccess: false,
          errorMessage:
              "Ops, ocorreu um problema de conexão.\n Tente Novamente");
    } else {
      return NetworkResponse(
          requestSuccess: false,
          errorMessage: "Ops, ocorreu erro.\n Tente Novamente");
    }
  }
}
