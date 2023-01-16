import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwiper({required this.peliculas});

  @override
  Widget build(BuildContext context) {
    //peliculas![index].uniqueId = '${peliculas![index].id}-tarjeta';
    //() => Navigator.pushNamed(context, 'detalle', arguments: peliculas![index])

    return CarouselSlider.builder(
      itemCount: peliculas.length,
      itemBuilder: (context, index, realIndex) =>
          MoviePosterImage(pelicula: peliculas[index]),
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        
      ),
    );
  }
}

class MoviePosterImage extends StatelessWidget {
  final Pelicula pelicula;

  const MoviePosterImage({Key? key, required this.pelicula}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      image: NetworkImage(pelicula.getPosterImg()),
      placeholder: AssetImage('assets/img/no-image.jpg'),
      fit: BoxFit.cover,
    );
  }
}
