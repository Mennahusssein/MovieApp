import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/movie_model.dart';
import 'package:flutter_application_1/details.dart';

class MyFavourites extends StatelessWidget {
  final List<MovieModel> favouriteMovies;

  const MyFavourites({super.key, required this.favouriteMovies});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text("MY FAVOURITES")),
        body:
            favouriteMovies.isEmpty
                ? Center(
                  child: Text(
                    "No favourite movies yet.",
                    style: TextStyle(fontSize: 18),
                  ),
                )
                : ListView.builder(
                  itemCount: favouriteMovies.length,
                  itemBuilder: (context, index) {
                    final model = favouriteMovies[index];
                    return ListTile(
                      contentPadding: EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w500${model.posterPath}",
                          width: 60,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(model.title),
                      subtitle: Text("Rating: ${model.voteAverage}"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Details(model: model),
                          ),
                        );
                      },
                    );
                  },
                ),
      ),
    );
  }
}
