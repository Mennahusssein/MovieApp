import 'package:flutter/material.dart';
//import 'package:flutter_application_1/view_model/app_brain.dart';
import 'package:flutter_application_1/models/movie_model.dart';

class Details extends StatelessWidget {
  static final ValueNotifier<bool> isDarkMode = ValueNotifier(true);
  final MovieModel model;
  const Details({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.sizeOf(context);
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, isDark, child) {
        return Theme(
          data: isDark ? ThemeData.dark() : ThemeData.light(),
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios),
              ),
              actions: [
                IconButton(
                  icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                  onPressed: () => isDarkMode.value = !isDarkMode.value,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Hero(tag: model.id.toString(),
                          child: Image.network(
                            "https://image.tmdb.org/t/p/w500${model.posterPath}",
                            height: 300,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "War of the worlds",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        const SizedBox(width: 5),
                        Text(model.voteAverage.toString()),
                        const SizedBox(width: 150),
                        Text(model.releaseDate),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        Chip(label: Text("Action")),
                        SizedBox(width: 8),
                        Chip(label: Text("Suspense")),
                      ],
                    ),
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
