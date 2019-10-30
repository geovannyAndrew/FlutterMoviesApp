import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/src/models/actor_model.dart';
import 'package:movies_app/src/models/movie_model.dart';

class MoviesProvider{

    String _apiKey = '313c09930994b08741a0bc4bb9711cfc';
    String _url = 'api.themoviedb.org';
    String _language = 'en';


    int _pagePopulars = 0;
    bool _loadingPopulars = false;
    List<Movie> _populars = new List();
    final _popularsStreamController = StreamController<List<Movie>>.broadcast();
    Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;
    Stream<List<Movie>> get popularsStream => _popularsStreamController.stream; 

    disposeStreams(){
      _popularsStreamController?.close();
    }

    Future<dynamic> _get(String endPath, Map<String, String> params) async{
      final url = Uri.https(_url, endPath,params);
      final response = await http.get(url);
      return jsonDecode(response.body);
    }

    Future<List<Movie>> getNowPlaying() async{
      final decodedData = await _get('3/movie/now_playing',{
        'api_key'   : _apiKey,
        'language'  : _language
      });
      final movies = Movies.fromJsonList(decodedData['results']);
      return movies.items;
    }

    Future<List<Movie>> getPopulars() async{
      if(_loadingPopulars) return [];
      _loadingPopulars = true;
      print('LOading new items...');
      _pagePopulars++;
      final decodedData = await _get('3/movie/popular',
      {
        'api_key'   : _apiKey,
        'language'  : _language,
        'page'      : _pagePopulars.toString(),
      });
      final movies = Movies.fromJsonList(decodedData['results']);
      _populars.addAll(movies.items);
      popularsSink(_populars);
      _loadingPopulars = false;
      return movies.items;
    } 

    Future<List<Actor>> getCast(String movieId) async{
      final decodedData = await _get('3/movie/$movieId/credits',{
        'api_key'   : _apiKey,
        'language'  : _language
      });
      final cast = Cast.fromJsonList(decodedData['cast']);
      return cast.actors;
    }

     Future<List<Movie>> searchMovie(String query) async{
      final decodedData = await _get('3/search/movie',{
        'api_key'   : _apiKey,
        'language'  : _language,
        'query'     : query
      });
      final movies = Movies.fromJsonList(decodedData['results']);
      return movies.items;
    }


}