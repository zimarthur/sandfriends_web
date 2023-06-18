import 'dart:html';

void storeToken(String accessToken) {
  window.localStorage["sfToken"] = accessToken;
}

String? getToken() {
  return window.localStorage["sfToken"];
}

void storeLastPage(int pageIndex) {
  window.localStorage["sfLastPageIndex"] = pageIndex.toString();
}

int? getLastPage() {
  return window.localStorage["sfLastPageIndex"] != null
      ? int.parse(window.localStorage["sfLastPageIndex"]!)
      : null;
}
