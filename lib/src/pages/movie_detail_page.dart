import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movie_model.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
    );
  }
}