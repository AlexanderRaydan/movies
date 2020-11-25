import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:peliculas/src/models/actors_model.dart';
import 'package:peliculas/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieProvider{

  String _apiKey = '045bbbc48a29888820d4bc2cc297f176';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  int _popular_page = 0;
  bool _load = false;

  List<Movie> _populars = new List();

  final _popularStreamController = StreamController<List<Movie>>.broadcast();


  Function(List<Movie>) get popularsSink => _popularStreamController.sink.add;

  Stream<List<Movie>> get popularsStream => _popularStreamController.stream;


  void disposeStreams(){

    _popularStreamController?.close();
  }


  Future <List<Movie>> get_now_playing() async {

    final url = Uri.https(_url, '3/movie/now_playing', {

      'api_key'  : _apiKey,
      'language' : _language,
    } );

    return await _get_results(url);
  }

  Future <List<Movie>> get_popular_movies() async {

    if(_load) return [];

    _load = true;
    
    _popular_page ++;

    final url = Uri.https(_url, '3/movie/popular', {

      'api_key'  : _apiKey,
      'language' : _language,
      'page'     : _popular_page.toString(),

    } 
  );

    final res = await _get_results(url);

    _populars.addAll(res);
    popularsSink(_populars);
  
    _load = false;

    return res;
  }

  Future <List<Movie>> _get_results(Uri url) async{

    final res = await http.get(url);
    final decodeData = json.decode(res.body);
    final movies = new Movies.fromJsonList(decodeData['results']);

    return movies.items;
  }

  Future <List<Actor>> _get_cast_results(Uri url) async{

    final res = await http.get(url);
    final decodeData = json.decode(res.body);
    final cats = new Cast.fromJsonList(decodeData['cast']);

    return cats.actors ;
  }

  Future <List<Actor>> get_cast(String movie_id) async {

    final url = Uri.https(_url, '3/movie/$movie_id/credits', {

      'api_key'  : _apiKey,
      'language' : _language,
    });

    return await _get_cast_results(url);
  }


  Future <List<Movie>> search_movie(String query) async {

    final url = Uri.https(_url, '3/search/movie', {

      'api_key'  : _apiKey,
      'language' : _language,
      'query'    : query,
    } );

    return await _get_results(url);
  }

}