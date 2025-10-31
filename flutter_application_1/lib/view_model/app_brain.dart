import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/models/movie_model.dart';

class AppBrain {
  // final List<MovieModel> movies = [];
  final ValueNotifier<List<MovieModel>> moviesnotifier = ValueNotifier([]);
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  Map<int, String> genres = {};
}
