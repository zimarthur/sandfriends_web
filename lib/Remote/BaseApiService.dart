import 'package:flutter/material.dart';

import 'Url.dart';

abstract class BaseApiService {
  Future<dynamic> getResponse(
    BuildContext context,
    String url,
  );
  Future<dynamic> postResponse(
    BuildContext context,
    String url,
    String body,
  );
}
