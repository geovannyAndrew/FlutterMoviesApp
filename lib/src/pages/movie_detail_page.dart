import 'package:flutter/material.dart';
import 'package:movies_app/src/models/actor_model.dart';
import 'package:movies_app/src/models/movie_model.dart';
import 'package:movies_app/src/providers/movies_provider.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 10.0,
                ),
                _posterTitle(context, movie),
                _description(movie),
                _buildCasting(movie),
              ]
            ),
          )
        ],
      ),
    );
  }

  Widget _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(movie.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0
          )),
        centerTitle: true,
        background: FadeInImage(
          fit: BoxFit.cover,
          image: NetworkImage(movie.backgroundImageUrl,
            scale: 1.0
          ),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(
            milliseconds: 200
          ),
        ),
      ),
    );
  }

  Widget _posterTitle(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image(
              image: NetworkImage(movie.posterImageUrl),
              height: 160,
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(movie.title,
                  style: Theme.of(context).textTheme.title,
                ),
                Text(movie.originalTitle,
                  style: Theme.of(context).textTheme.subhead,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.star),
                    Text(movie.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subhead,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _description(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 16.0
      ),
      child: Text(movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildCasting(Movie movie) {
    final moviesProvider = MoviesProvider();

    return FutureBuilder(
      future: moviesProvider.getCast(movie.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          return _buildCastPageView(snapshot.data);
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildCastPageView(List<Actor> cast) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
        pageSnapping: false,
        itemCount: cast.length,
        itemBuilder: (BuildContext context, int index){
          final actor = cast[index];
          return _cardActor(context, actor);
        },
      ),
    );
  }

  Widget _cardActor(BuildContext context, Actor actor){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: FadeInImage(
              image: NetworkImage(actor.profilePathUrl),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
              height: 150,
            ),
          ),
          Text(actor.name,
            style: Theme.of(context).textTheme.subtitle,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}