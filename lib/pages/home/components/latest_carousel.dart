import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_netflix/pages/home/models/Movie.model.dart';
import 'package:flutter_netflix/pages/home/services/Movie.service.dart';

class LatestCarousel extends StatefulWidget {
  const LatestCarousel({ this.title, this.type, this.ratio: 1.0, this.autoPlay: true });

  final bool autoPlay;
  final double ratio;
  final String title;
  final String type;

  @override
  _LatestCarouselState createState() => _LatestCarouselState();
}

class _LatestCarouselState extends State<LatestCarousel> {
  Future<List<Movie>> movies;

  @override
  void initState() {
    movies = MovieService().index(widget.type);

    super.initState();
  }

  List<Widget> renderList(List<Movie> movies) {
    return movies.map((item) => Container(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(item.poster, fit: BoxFit.cover, width: 1000.0, height: 1000,),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      item.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: mediaQuery.size.width,
            margin: EdgeInsets.only(bottom: 26),
            child: Text(widget.title, style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          FutureBuilder<List<Movie>>(
            future: movies,
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                return CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: widget.autoPlay,
                    aspectRatio: widget.ratio,
                    enlargeCenterPage: true,
                  ),
                  items: renderList(snapshot.data),
                );
              } else if(snapshot.hasError) {
                return Text("Erro ao carregar lista", style: TextStyle(color: Colors.white, fontSize: 16));
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator()
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
