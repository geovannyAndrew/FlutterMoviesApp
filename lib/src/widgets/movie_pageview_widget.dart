import 'package:flutter/material.dart';
import '../models/movie_model.dart';

class MoviePageView extends StatelessWidget {
  
  final List<Movie> movies;

  MoviePageView({ this.movies });

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final _height = _screenSize.height * 0.3;
    return Container(
      height: _height,
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 0,

        ),
        pageSnapping: false,
        scrollDirection: Axis.horizontal,
        itemCount: movies?.length ?? 0,
        itemBuilder: (BuildContext context, int position){
          final movie = movies[position];
          return _buildCardMovie(context,movie);
        },
      ),
    );
  }


  Widget _buildCardMovie(BuildContext context, Movie movie){
    return Container(
      margin: EdgeInsets.only(right: 8.0),
      child: Column(
        children: <Widget>[
          /*FadeInImage(
            image: NetworkImage(movie.posterImageUrl),
            placeholder: AssetImage('assets/no-image.jpg'),
            fit: BoxFit.fill,
          )*/
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.network(movie.posterImageUrl,
              height: 160,
            ),
          ),
          Text(movie.title,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subhead,
          )
        ],
      ),
    );
  }
}