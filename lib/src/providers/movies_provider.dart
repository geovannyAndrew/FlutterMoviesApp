import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/src/models/movie_model.dart';

class MoviesProvider{

    String _apiKey = '313c09930994b08741a0bc4bb9711cfc';
    String _url = 'api.themoviedb.org';
    String _language = 'en';

    Future<dynamic> _get(String endPath) async{
      final url = Uri.https(_url, endPath,{
        'api_key'   : _apiKey,
        'language'  : _language
      });
      final response = await http.get(url);
      return jsonDecode(response.body);
    }

    Future<List<Movie>> getNowPlaying() async{
      final decodedData = await _get('3/movie/now_playing');
      final movies = Movies.fromJsonList(decodedData['results']);
      return movies.items;
    }

    Future<List<Movie>> getPopulars() async{
      final decodedData = await _get('3/movie/popular');
      final movies = Movies.fromJsonList(decodedData['results']);
      return movies.items;
    }


}