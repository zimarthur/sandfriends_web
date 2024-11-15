import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../../../../Remote/NetworkResponse.dart';

class LoginRepo {
  Future<NetworkResponse?> login(
    BuildContext context,
    String email,
    String password,
    Tuple2<bool?, String?>? notificationsConfig,
  ) async {}
  Future<NetworkResponse?> validateToken(
      BuildContext context, String accessToken) async {}
}
