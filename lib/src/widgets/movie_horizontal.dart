import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie_model.dart';

class HorizontalMovie extends StatelessWidget {

  final List<Movie> movies;

  final Function next_page;

  final _pageController = new PageController(

    initialPage: 1 ,
    viewportFraction: 0.3,
  );

  HorizontalMovie({@required this.movies , @required this.next_page});

  @override
  Widget build(BuildContext context) {


    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() { 

      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent -200)

        next_page();      
    });

    return Container(

      height: _screenSize.height * 0.25,
      child: PageView.builder(
        controller: _pageController,
        pageSnapping: false,
        itemBuilder: (context , i){

          return tarject_create(_screenSize, context, movies[i]);
        },
        itemCount: movies.length,
      ),
    );
  }

  Widget tarject_create(_screenSize , BuildContext context, Movie movie ){

    movie.uniqueId = '${movie.id}--populars_movies';

    final movie_tarject = Container(

        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget> [

            Hero(
              tag: movie.id ,
              child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage( movie.get_poster_img()),
                placeholder: AssetImage('assets/img/loading.gif'),
                fit: BoxFit.cover ,
                height: _screenSize.height *0.2,
              ) ,
            ),
          ),

          SizedBox(height: 5.0),

          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ] 
      ) 
    );

      return GestureDetector(
        child: movie_tarject,
        onTap: (){

          Navigator.pushNamed(context, 'details' , arguments: movie);
      } 
    ); 
  }
}