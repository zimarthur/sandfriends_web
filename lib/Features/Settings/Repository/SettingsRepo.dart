import 'package:flutter/material.dart';

import '../../../Remote/NetworkResponse.dart';
import '../../../SharedComponents/Model/Store.dart';

class SettingsRepo {
  Future<NetworkResponse?> updateStoreInfo(
    BuildContext context,
    Store store,
    bool changedLogo,
  ) async {}

  Future<NetworkResponse?> allowNotifications(
    BuildContext context,
    String accessToken,
    bool allowNotifications,
    String notificationsToken,
  ) async {}

  Future<NetworkResponse?> deleteAccount(
    BuildContext context,
    String accessToken,
  ) async {}
}
