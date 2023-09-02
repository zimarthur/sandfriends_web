import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sandfriends_web/SharedComponents/ViewModel/EnvironmentProvider.dart';
import 'BaseApiService.dart';
import 'NetworkResponse.dart';
import 'package:provider/provider.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future<NetworkResponse> getResponse(
    BuildContext context,
    String url,
  ) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (Provider.of<EnvironmentProvider>(context, listen: false).isDev()) {
        print(response);
      }
      return returnResponse(
        context,
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
    BuildContext context,
    String url,
    String body,
  ) async {
    if (Provider.of<EnvironmentProvider>(context, listen: false).isDev()) {
      print(url);
      print(body);
    }

    try {
      final response = await http
          .post(
            Uri.parse(url),
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
      return returnResponse(context, response);
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

  NetworkResponse returnResponse(BuildContext context, http.Response response) {
    String statusCode = response.statusCode.toString();
    if (Provider.of<EnvironmentProvider>(context, listen: false).isDev()) {
      print(statusCode);
      print(response.body);
    }

    if (statusCode.startsWith("2")) {
      if (statusCode == "200") {
        return NetworkResponse(
          responseStatus: NetworkResponseStatus.success,
          responseBody: response.body,
        );
      }
      if (statusCode == "232") {
        return NetworkResponse(
          responseStatus: NetworkResponseStatus.expiredToken,
          responseTitle: "",
          responseDescription: "",
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
