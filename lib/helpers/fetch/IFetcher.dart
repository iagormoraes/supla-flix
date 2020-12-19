import 'package:http/http.dart';

abstract class IFetcher {
  Future<Response> get(String endpoint);
}