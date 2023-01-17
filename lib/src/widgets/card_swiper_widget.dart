import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:peliculas/src/models/movies_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  CardSwiper({required this.movies});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: movies.length,
      itemBuilder: (context, index, realIndex) =>
          MoviePosterImage(movie: movies[index]),
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
    );
  }
}

class MoviePosterImage extends StatelessWidget {
  final Movie movie;

  const MoviePosterImage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
      child: Hero(
        tag: movie.uniqueIdBanner,
        child: FadeInImage(
          image: NetworkImage(movie.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
