import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/movieProvider.dart';
import '../screen/movieList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => MovieProvider(),
      child: MaterialApp(
        title: 'Flutter Movie List Demo',
        home: MovieList(),
      ),
    );
  }
}
