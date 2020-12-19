import 'dart:ui';
import 'package:flutter_netflix/pages/home/services/Movie.service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_netflix/pages/home/models/Movie.model.dart';

class HomeTitle extends StatefulWidget {
  const HomeTitle({ Key key, this.active: true }) : super(key: key);

  final bool active;

  @override
  _HomeTitleState createState() => _HomeTitleState();
}

class _HomeTitleState extends State<HomeTitle> {
  Future<Movie> movie;

  @override
  void initState() {
    super.initState();

    movie = MovieService().find("final fantasy advent");
  }

  getColorStyle() {
    if(widget.active) {
      return Colors.transparent;
    }

    return Colors.grey.shade900;
  }

  getHeightStyle(BuildContext context) {
    final statusBarPadding = MediaQuery.of(context).padding.top;
    final deviceHeight = MediaQuery.of(context).size.height / 2;

    if(widget.active) {
      return deviceHeight.toDouble();
    }

    return statusBarPadding + 54.0;
  }

  getAnimatedStyle() {
    if(widget.active) {
      return GoogleFonts.montserratAlternates(color: Colors.redAccent, fontSize: 32, fontWeight: FontWeight.bold);
    }

    return GoogleFonts.montserratAlternates(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final statusBarPadding = MediaQuery.of(context).padding.top;
    final headerVerticalPadding = 12.0;

    return IgnorePointer(
      child: Stack(
        children: [
          AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: getHeightStyle(context),
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Stack(
                        children: [
                          Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Opacity(
                                opacity: 0.95,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  color: getColorStyle(),
                                ),
                              )
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: AnimatedOpacity(
                              opacity: widget.active ? 0.5 : 0.2,
                              duration: const Duration(milliseconds: 300),
                              child: FutureBuilder<Movie>(
                                future: movie,
                                builder: (context, snapshot) {
                                  if(snapshot.hasData) {
                                    return FittedBox(
                                      fit: BoxFit.cover,
                                      child: Image.network(snapshot.data.poster),
                                    );
                                  }

                                  return Container();
                                },
                              )
                            )
                          ),
                        ],
                      )
                  ),
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: FittedBox(
                        fit: BoxFit.none,
                        child: Container(
                            width: deviceWidth,
                            padding: EdgeInsets.only(top: statusBarPadding + headerVerticalPadding, bottom: headerVerticalPadding),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedDefaultTextStyle(
                                    child: Text("Supla Flix",
                                        softWrap: true,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                    style: getAnimatedStyle(),
                                    duration: const Duration(milliseconds: 300)
                                ),
                                FutureBuilder<Movie>(
                                  future: movie,
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData) {
                                      return FittedBox(
                                        fit: BoxFit.cover,
                                        child: Text(snapshot.data.title,
                                            softWrap: true,
                                            style: TextStyle(color: Colors.white),
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis
                                        ),
                                      );
                                    }

                                    return Container();
                                  },
                                )
                              ],
                            )
                        ),
                      )
                  ),
                ],
              )
          ),
        ],
      )
    );
  }
}
