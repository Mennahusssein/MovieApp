import 'package:flutter/material.dart';
import 'package:flutter_application_1/movieScreen.dart';
import 'package:flutter_application_1/view_model/app_brain.dart';

final AppBrain appBrain = AppBrain();
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Movie App", home: MyWidget());
  }
}
