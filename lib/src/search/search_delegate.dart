import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate{

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
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Suggestions that appear when person writes
    return Container();
  }

}