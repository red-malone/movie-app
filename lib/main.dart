import 'package:flutter/material.dart';
import 'package:movies/screens/home.dart';
import 'package:movies/utils/providers.dart';
import 'package:provider/provider.dart'; // Import your MovieProvider

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: MaterialApp(
        theme: ThemeData.light(
          useMaterial3: true,

        ),
        home:const MovieListWidget(),
      ),
    );
  }
}
