
import "package:http/http.dart" as http;

class Fetcher {
  const Fetcher({ this.baseUrl });

  final String baseUrl;

  Future <http.Response> get(String endpoint) async {
    return await http.get("${this.baseUrl}$endpoint");
  }
}
