import 'package:flutter/material.dart';
import 'package:movies_app/src/providers/movies_provider.dart';
import 'package:movies_app/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  
  final _moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
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
          children: <Widget>[
            _swipeCards()
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
}