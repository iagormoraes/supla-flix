import 'package:flutter_netflix/helpers/fetch/IFetcher.dart';
import 'package:flutter_netflix/pages/home/models/Movie.model.dart';

abstract class IMovieFetcher extends IFetcher {
  Future<List<Movie>> index(String type);
  Future<Movie> find(String movieTitle);
}