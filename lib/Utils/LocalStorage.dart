import 'dart:html';

void storeToken(String accessToken) {
  window.localStorage["sfToken"] = accessToken;
}

String? getToken() {
  return window.localStorage["sfToken"];
}

void storeLastPage(String pageName) {
  window.localStorage["sfLastPageName"] = pageName;
}

String? getLastPage() {
  return window.localStorage["sfLastPageName"];
}
