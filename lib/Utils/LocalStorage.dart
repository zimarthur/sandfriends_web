import 'dart:html';

void storeToken(String accessToken) {
  window.localStorage["sfToken"] = accessToken;
}

String? getToken() {
  return window.localStorage["sfToken"];
}
