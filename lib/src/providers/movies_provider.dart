import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/src/models/movie_model.dart';

class MoviesProvider{

    String _apiKey = '313c09930994b08741a0bc4bb9711cfc';
    String _url = 'api.themoviedb.org';
    String _language = 'en';


    Future<List<Movie>> getNowPlaying() async{
      final url = Uri.https(_url, '3/movie/now_playing',{
        'api_key'   : _apiKey,
        'language'  : _language
      });
      final response = await http.get(url);
      final decodedData = jsonDecode(response.body);
      print(decodedData);
      final movies = Movies.fromJsonList(decodedData['results']);
      return movies.items;
    }
}