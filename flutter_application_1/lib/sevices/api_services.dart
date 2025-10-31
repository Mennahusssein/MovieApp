import 'dart:convert';

import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/movie_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<void> fetchMovies() async {
    final String endpoint = "https://api.themoviedb.org/3/movie/popular";
    final String apikey =
        "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZDVmZWQ2MWU1MzgzOWU2MDY2ZDZlMjY2MWYzNmY0ZSIsIm5iZiI6MTcyODkzNzQwMi4xNTkwMDAyLCJzdWIiOiI2NzBkN2RiYTlmMzUzMWU2YjI2YzFhODUiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.C6_Tu-WhsulYBvjx7lMzBE74AbNSoerdKLOXeHQAYxU";
    final Map<String, String> headers = {"Authorization": "Bearer $apikey"};
    var url = Uri.parse(endpoint);
    var response = await http.get(url, headers: headers);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print("response String is $responseString");
    }
    final mapResponse = jsonDecode(response.body);
    print(mapResponse);
    final results = mapResponse["results"];
    print(results);
    final models =
        (results as List).map((map) => MovieModel.fromJson(map)).toList();
    appBrain.moviesnotifier.value = models;
  }

  Future<Map<int, String>> fetchGenres() async {
    const endpoint = "https://api.themoviedb.org/3/genre/movie/list";
    const apikey =
        "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZDVmZWQ2MWU1MzgzOWU2MDY2ZDZlMjY2MWYzNmY0ZSIsIm5iZiI6MTcyODkzNzQwMi4xNTkwMDAyLCJzdWIiOiI2NzBkN2RiYTlmMzUzMWU2YjI2YzFhODUiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.C6_Tu-WhsulYBvjx7lMzBE74AbNSoerdKLOXeHQAYxU";
    final headers = {"Authorization": "Bearer $apikey"};

    final url = Uri.parse(endpoint);
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final genres = data["genres"] as List;
      final genreMap = {
        for (var genre in genres) genre["id"] as int: genre["name"] as String,
      };
      return genreMap;
    } else {
      throw Exception("Failed to fetch genres");
    }
  }
}
