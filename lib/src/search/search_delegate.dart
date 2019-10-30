import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate{

  String _selectedMovie = '';

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
  }

}