import 'dart:convert';

import 'package:flutter_netflix/helpers/fetch/fetch_config.dart';
import 'package:flutter_netflix/pages/home/models/Movie.model.dart';

import 'IMovieFetcher.service.dart';

class MovieService extends Fetcher implements IMovieFetcher {
  final String baseUrl = "https://www.omdbapi.com/?apikey=a74aa390";

  const MovieService();

  Future <List<Movie>> index(String type) async {
    var response = await get("&y=${DateTime.now().year}&s=$type");

    if(response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var list = json["Search"] as List;

      List<Movie> movieList = list.map((item) => Movie.fromJson(item)).toList();

      return movieList;
    } else {
      throw Exception("failed to fetch list");
    }
  }

  Future <Movie> find(String movieTitle) async {
    var response = await get("&s=$movieTitle");

    if(response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var list = json["Search"] as List;

      return Movie.fromJson(list[0]);
    } else {
      throw Exception("movie not found");
    }
  }
}
