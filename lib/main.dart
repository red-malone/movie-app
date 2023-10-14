import 'package:flutter/material.dart';
import 'package:movies/screens/home.dart';
import 'package:movies/utils/providers.dart';
import 'package:provider/provider.dart';// Import your MovieProvider

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: MaterialApp(
        home: MovieListWidget(),
      ),
    );
  }
}
