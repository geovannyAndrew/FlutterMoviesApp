import 'package:flutter/material.dart';
import 'package:movies_app/src/providers/movies_provider.dart';
import 'package:movies_app/src/widgets/card_swiper_widget.dart';
import 'package:movies_app/src/widgets/movie_pageview_widget.dart';

class HomePage extends StatelessWidget {
  
  final _moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {

    _moviesProvider.getPopulars();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Movies at cinema'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swipeCards(),
            _footer()
          ],
        ),
      )
    );
  }

  Widget _swipeCards() {
    return FutureBuilder(
      future: _moviesProvider.getNowPlaying(),
      //initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
         return CardSwiper(movies: snapshot.data);
        }
        else{
          return Container(
            height: 400,
            child: Center(
              child: CircularProgressIndicator()
            ),
          );
        }
      },
    );
    
  }

  Widget _footer() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Popular'),
          ),
          StreamBuilder(
            stream: _moviesProvider.popularsStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if(snapshot.hasData){
                return MoviePageView(
                  movies: snapshot.data,
                  onNextPage: _moviesProvider.getPopulars,
                );
              }
              else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}