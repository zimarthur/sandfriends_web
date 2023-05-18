import 'dart:convert';

import '../../../../Remote/ApiEndPoints.dart';
import '../../../../Remote/BaseApiService.dart';
import '../../../../Remote/NetworkApiService.dart';
import '../../../../Remote/NetworkResponse.dart';
import 'EmployeeInfoRepo.dart';

class EmployeeInfoRepoImp implements EmployeeInfoRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<NetworkResponse> RenameEmployee(
      String firstName, String lastName, String accessToken) {
    // TODO: implement RenameEmployee
    throw UnimplementedError();
  }

  @override
  Future<NetworkResponse> addEmployee(
      String accessToken, String employeeEmail) async {
    NetworkResponse response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().addEmployee,
      jsonEncode(<String, Object>{
        "AccessToken": accessToken,
        "Email": employeeEmail,
      }),
    );
    return response;
  }

  @override
  Future<NetworkResponse> changeEmployeeAdmin(
    String accessToken,
    int employeeId,
    bool isAdmin,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().changeEmployeeAdmin,
      jsonEncode(<String, Object>{
        "AccessToken": accessToken,
        "IdEmployee": employeeId,
        "IsAdmin": isAdmin,
      }),
    );
    return response;
  }

  @override
  Future<NetworkResponse> renameEmployee(
    String accessToken,
    String firstName,
    String lastName,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().renameEmployee,
      jsonEncode(<String, Object>{
        "AccessToken": accessToken,
        "FirstName": firstName,
        "LastName": lastName,
      }),
    );
    return response;
  }

  @override
  Future<NetworkResponse> removeEmployee(
    String accessToken,
    int idEmployee,
  ) async {
    NetworkResponse response = await _apiService.postResponse(
      _apiService.sandfriendsUrl,
      ApiEndPoints().removeEmployee,
      jsonEncode(<String, Object>{
        "AccessToken": accessToken,
        "IdEmployee": idEmployee,
      }),
    );
    return response;
  }
}
