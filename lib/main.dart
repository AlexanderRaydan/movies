import 'package:flutter/material.dart';

import 'package:peliculas/src/pages/home_page.dart';
import 'package:peliculas/src/pages/movie_delails.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: '/',
      routes: {

        '/'       : (BuildContext context) => HomePage() ,
        'details' : (BuildContext context) => MovieDetails()

      },
    );
  }
}