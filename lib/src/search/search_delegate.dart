import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movie_model.dart';
import 'package:movies_app/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate{

  String _selectedMovie = '';
  final _moviesProvider = MoviesProvider();

  final movies = [
    'Spiderman',
    'Captain América',
    'Batman',
    'Movie other',
    'Iron man',
    'The mummy',
    'Shazam'
  ];

  final moviesRecent = [
    'Spiderman',
    'Shazam'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    //Actions for Appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon to the left of appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Create results thta we want to show
    return Center(
      child: Container(
        height: 100,
        width: 100,
        color: Colors.blueAccent,
        child: Text(_selectedMovie),
      ),
    );
  }

  /*
  This is for mocking build suggestions
  @override
  Widget buildSuggestions(BuildContext context) {
    //Suggestions that appear when person writes

    final listSuggestions = query.isEmpty ? moviesRecent : movies.where((p)=>
      p.toLowerCase().startsWith(query.toLowerCase())
    ).toList();
    return ListView.builder(
      itemCount: listSuggestions.length,
      itemBuilder: (BuildContext context, int index){
        final movie = listSuggestions[index];
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(movie),
          onTap: (){
            _selectedMovie = movie;
            showResults(context);
          },
        );
      },
    );
  }*/

  @override
  Widget buildSuggestions(BuildContext context) {
    //Suggestions that appear when person writes
    if(query.isEmpty){
      return Container();
    }
    return FutureBuilder(
      future: _moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot){
        final movies = snapshot.data;
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index){
              final movie = movies[index];
              movie.heroId = 'search_movie_${movie.id}';
              return ListTile(
                leading: Hero(
                  tag: movie.heroId,
                  child: FadeInImage(
                    image: NetworkImage(movie.posterImageUrl),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.contain,
                  ),
                ),
                title: Text(movie.title),
                subtitle: Text(movie.originalTitle),
                onTap: () => Navigator.pushNamed(context, '/detail_movie', arguments: movie),
              );
            },
          );
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

}