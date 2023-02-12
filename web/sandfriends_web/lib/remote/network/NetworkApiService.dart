import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../AppException.dart';
import 'BaseApiService.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future getResponse(String baseUrl, String aditionalUrl) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(baseUrl + aditionalUrl));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postResponse(String baseUrl, String aditionalUrl, String body) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(
            Uri.parse(baseUrl + aditionalUrl),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: body,
          )
          .then((value) => print(value.statusCode));
      //responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        //dynamic responseJson = jsonDecode(response.body);
        Map<String, dynamic> responseBody = json.decode(response.body);
        return responseBody;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}
