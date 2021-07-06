import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/genresModel.dart';
import '../model/movieModel.dart';

class MovieProvider extends ChangeNotifier {
  List<Results> listMovie = [];
  List<Genres> genres = [];

  var apiKey = "631bd15e86228214bc2c69c29e283a01";

  Future<void> getMovieList(String query) async {
    var url =
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query';
    var response = await http.get(Uri.parse(url));
    var r = json.decode(response.body);
    MovieModel movieModel = MovieModel.fromJson(r);
    listMovie = movieModel.results;
    notifyListeners();
  }

  Future<void> getGenres() async {
    var url = 'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey';
    var response = await http.get(Uri.parse(url));
    var r = json.decode(response.body);
    GenresModel genresModel = GenresModel.fromJson(r);
    genres = genresModel.genres;
    notifyListeners();
  }
}
