import 'package:flutter/material.dart';
import 'package:flutter_netflix/pages/home/components/latest_carousel.dart';

import 'package:flutter_netflix/pages/home/components/title.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController;
  bool scrollTop = true;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _scrollController.addListener(() {
        setState(() {
          scrollTop = _scrollController.offset <= 0;
        });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = MediaQuery.of(context).size.height / 2;

    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: mediaQuery.size.width,
              height: mediaQuery.size.height,
              color: Colors.black,
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 26,
                top: scrollTop ? deviceHeight : mediaQuery.padding.top + 54.0
              ),
              child: ListView(

                controller: _scrollController,
                children: [
                  Column(children: <Widget>[
                    LatestCarousel(title: "Últimos lançamentos", type: "final", ratio: 2),
                    LatestCarousel(title: "Filmes", type: "movie", autoPlay: false,),
                    LatestCarousel(title: "Séries", type: "series", autoPlay: false,),
                    LatestCarousel(title: "Episódios", type: "episodes", autoPlay: false,),
                    Text("${DateTime.now().year} Supla Flix. Todos os direitos reservados.", style: TextStyle(color: Colors.white),)
                  ],),
                ],
              )
          ),
          Positioned(child: HomeTitle(active: scrollTop), top: 0, left: 0, right: 0),
        ],
      )
    );
  }
}
