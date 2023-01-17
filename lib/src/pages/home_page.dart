import 'package:flutter/material.dart';

import 'package:peliculas/src/models/movies_model.dart';
import 'package:peliculas/src/providers/movies_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    moviesProvider.getPopular();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('In Theaters'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
                // query: 'Hola'
              );
            },
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _cardsSwiper(),
              _footer(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardsSwiper() {
    return FutureBuilder(
      future: moviesProvider.getOnTheaters(),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(movies: snapshot.data!);
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Popular',
                  style: Theme.of(context).textTheme.headlineSmall)),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: moviesProvider.popularStream,
            builder:
                (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  movies: snapshot.data,
                  nextPage: moviesProvider.getPopular,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
