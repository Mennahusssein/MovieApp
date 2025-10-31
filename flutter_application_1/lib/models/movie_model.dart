// import 'package:flutter/foundation.dart';

class MovieModel {
  final bool adult;
  final String? backdropPath;
  final List genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String releaseDate;
  final String title;
  final double voteAverage;
  final int voteCount;

  MovieModel({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      adult: json["adult"],
      id: json["id"],
      backdropPath: json["backdrop_path"],
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      popularity: json["popularity"],
      posterPath: json["poster_path"],
      releaseDate: json["release_date"],
      title: json["title"],
      voteAverage: json["vote_average"],
      voteCount: json["vote_count"],
      genreIds: json["genre_ids"],
    );
  }
}
