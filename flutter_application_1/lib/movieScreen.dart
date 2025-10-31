import 'package:flutter/material.dart';
import 'package:flutter_application_1/details.dart';
import 'package:flutter_application_1/favourites.dart';
import 'package:flutter_application_1/sevices/api_services.dart';
import 'package:flutter_application_1/models/movie_model.dart';
import 'package:flutter_application_1/main.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final ScrollController _scrollController = ScrollController();
  final ApiServices apiServices = ApiServices();

  Set<int> favouriteMovieIds = {};
  List<MovieModel> favouriteMovies = [];
  Map<int, String> genreMap = {};

  @override
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

    loadGenresAndMovies();
  }

  void loadGenresAndMovies() async {
    genreMap = await apiServices.fetchGenres();
    await apiServices.fetchMovies();
    setState(() {});
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print('Reached the bottom of the list');
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Popular Movies"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => MyFavourites(favouriteMovies: favouriteMovies),
                  ),
                );
              },
              icon: const Icon(Icons.favorite, color: Colors.red),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.bedtime)),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder<List<MovieModel>>(
                valueListenable: appBrain.moviesnotifier,
                builder: (context, movieList, _) {
                  if (movieList.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: movieList.length,
                    itemBuilder: (context, index) {
                      final model = movieList[index];
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Details(model: model),
                              ),
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Hero(
                                  tag: model.id.toString(),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w500${model.posterPath}",
                                    fit: BoxFit.cover,
                                    width: 120,
                                    height: 180,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      model.title,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(model.voteAverage.toString()),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 4,
                                      children:
                                          model.genreIds.map((id) {
                                            final genreName =
                                                genreMap[id] ?? 'Unknown';
                                            return Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 6,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[800],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                genreName,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                    ),

                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.access_alarm_outlined,
                                          size: 16,
                                          color: Colors.green,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(model.releaseDate),
                                        const SizedBox(width: 20),
                                        TweenAnimationBuilder<Color?>(
                                          duration: const Duration(
                                            milliseconds: 100,
                                          ),
                                          tween: ColorTween(
                                            begin: Colors.grey,
                                            end:
                                                favouriteMovieIds.contains(
                                                      model.id,
                                                    )
                                                    ? Colors.red
                                                    : Colors.grey,
                                          ),
                                          builder: (context, color, child) {
                                            return IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (favouriteMovieIds
                                                      .contains(model.id)) {
                                                    favouriteMovieIds.remove(
                                                      model.id,
                                                    );
                                                    favouriteMovies.removeWhere(
                                                      (movie) =>
                                                          movie.id == model.id,
                                                    );
                                                  } else {
                                                    favouriteMovieIds.add(
                                                      model.id,
                                                    );
                                                    favouriteMovies.add(model);

                                                    // Navigator.push(
                                                    //   context,
                                                    //   MaterialPageRoute(
                                                    //     builder:
                                                    //         (_) => MyFavourites(
                                                    //           favouriteMovies:
                                                    //               favouriteMovies,
                                                    //         ),
                                                    //   ),
                                                    // );
                                                  }
                                                });
                                              },
                                              icon: Icon(
                                                favouriteMovieIds.contains(
                                                      model.id,
                                                    )
                                                    ? Icons.favorite
                                                    : Icons
                                                        .favorite_border_outlined,
                                                color: color,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
