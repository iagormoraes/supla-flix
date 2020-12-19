class Movie {
  String title;
  String year;
  String type;
  String poster;

  Movie(this.title, this.year, this.type, this.poster);

  factory Movie.fromJson(Map<String, dynamic> json) {
    var mapKey = Map();

    for(var key in json.keys) {

      if(json[key].toString().contains("N/A")) {
        mapKey[key] = "https://images-na.ssl-images-amazon.com/images/I/518eSNguuYL._SX466_.jpg";
      } else {
        mapKey[key] = json[key];
      }
    }

    return Movie(mapKey["Title"], mapKey["Year"], mapKey["Type"], mapKey["Poster"]);
  }
}
