import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies_app/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {

  final List<dynamic> movies;

  CardSwiper({ @required this.movies });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;
    final _widthCard = _screenSize.width * 0.7;
    final _heightCard = _widthCard;

    return Container(
      padding: EdgeInsets.all(10.0),
      child: Swiper(
          itemBuilder: (BuildContext context,int index){
            final Movie movie = movies[index];
            return Hero(
              tag: movie.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: FadeInImage(
                  image: NetworkImage(movie.posterImageUrl),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          itemCount: this.movies.length,
          //pagination: SwiperPagination(),
          itemWidth: _widthCard,
          itemHeight: _heightCard,
          layout: SwiperLayout.STACK,
        ),
    );
  }
}