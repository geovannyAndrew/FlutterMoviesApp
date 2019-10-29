import 'package:flutter/material.dart';
import '../models/movie_model.dart';

class MoviePageView extends StatelessWidget {
  
  final List<Movie> movies;
  final Function onNextPage;

  MoviePageView({ this.movies, this.onNextPage });

  final _pageController = PageController(
    viewportFraction: 0.3,
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final _height = _screenSize.height * 0.3;

    _pageController.addListener((){
      if(_pageController.position.pixels >=  _pageController.position.maxScrollExtent){
        onNextPage();
      }
    });

    return Container(
      height: _height,
      child: PageView.builder(
        controller:_pageController,
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
    final card = Container(
      margin: EdgeInsets.only(right: 8.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: movie.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: FadeInImage(
                image: NetworkImage(movie.posterImageUrl),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.fill,
                height: 160,
                fadeInDuration: Duration(
                  milliseconds: 400
                ),
              ),
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

    return GestureDetector(
      child: card,
      onTap: (){
        Navigator.pushNamed(context, '/detail_movie',
          arguments: movie
        );
      },
    );
  }
}