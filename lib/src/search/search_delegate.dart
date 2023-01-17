import 'package:flutter/material.dart';

import 'package:peliculas/src/models/movies_model.dart';
import 'package:peliculas/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {
  String selection = '';
  final moviesProvider = new MoviesProvider();

  final movies = [
    'Spider-man',
    'Aqua-man',
    'Batman',
    'Shazam!',
    'Ironman',
    'Capitan America',
    'Superman',
    'Ironman 2',
    'Ironman 3',
    'Ironman 4',
    'Ironman 5',
  ];

  final recentMovies = ['Spider-man', 'Capitan America'];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(selection),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data!;

          return ListView(
              children: movies.map((movie) {
            return ListTile(
              leading: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                width: 50.0,
                fit: BoxFit.contain,
              ),
              title: Text(movie.title!),
              subtitle: Text(movie.originalTitle!),
              onTap: () {
                close(context, null);
                Navigator.pushNamed(context, 'details', arguments: movie);
              },
            );
          }).toList());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
