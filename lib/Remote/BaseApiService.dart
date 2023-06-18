abstract class BaseApiService {
  final String sandfriendsUrl = "https://sandfriends.com.br";
  final String cnpjUrl = "https://minhareceita.org/";

  Future<dynamic> getResponse(String baseUrl, String aditionalUrl);
  Future<dynamic> postResponse(
      String baseUrl, String aditionalUrl, String body);
}
