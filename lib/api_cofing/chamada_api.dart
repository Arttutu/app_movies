import 'dart:convert';
import 'package:tmdb_api/tmdb_api.dart';

import '../models/movies_and_series.model.dart';
import 'variaveis_constantes.dart';
import "package:http/http.dart" as http;

class PosterRequest {
  dynamic response;
  Future<MoviesAndSeriesModel> getSearchMoviesAndSeries(String query) async {
    try {
      response = await http.get(Uri.parse(
          '$url/3/search/multi?language=pt-BR&api_key=$key&query=$query'));

      if (query != '') {
        if (response.statusCode == 200 && query != '') {
          return MoviesAndSeriesModel.fromJson(jsonDecode(response.body));
        } else {
          throw Exception('Failed to load album');
        }
      }
      return MoviesAndSeriesModel.fromJson(jsonDecode(response.body));
    } on Exception catch (e) {
      print('não foi possivel obter o fazer a pesquisa $e');
      rethrow;
    }
  }
}
