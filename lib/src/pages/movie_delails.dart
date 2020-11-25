
import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actors_model.dart';
import 'package:peliculas/src/models/movie_model.dart';
import 'package:peliculas/src/providers/movie_provider.dart';

class MovieDetails extends StatelessWidget {


  MovieDetails();

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(

      body: CustomScrollView(

        slivers: <Widget> [
          _appbar_create(movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0),
                _create_poster_tittle(movie , context),
                _movie_description(movie),                
                _casting_create(movie.id.toString() , context),
              ]
            ),
          ),
        ],   
      ),
    );
  }

  Widget _appbar_create(Movie movie) {

    return SliverAppBar(
      
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: FadeInImage(
          image: NetworkImage(movie.get_backgound_img()),
          fit: BoxFit.cover,
          placeholder: AssetImage('assets/img/loading.gif'),
          //fadeInDuration: Duration(microseconds: 150),
        ),
      ),
    );
  }

  Widget _create_poster_tittle(Movie movie , BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget> [

          Hero(
            
            tag: movie.uniqueId,
            child:ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(movie.get_poster_img()),
                fit: BoxFit.cover,
                height: 150.0,
              ) 
            ), 
          ), 
            
          SizedBox(width: 20.0,),
          Flexible(
            child: Column(
              children: [
                Text(movie.title , style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis,),
                Text(movie.originalTitle , style: Theme.of(context).textTheme.subtitle1,overflow: TextOverflow.ellipsis,),
                Row(
                  children: <Widget> [
                    Icon(Icons.star_border),
                    Text(movie.voteAverage.toString() , style: Theme.of(context).textTheme.subtitle1)
                  ],
                ),
              ],
            )
          ) 
        ],
      ),
    );
  }

  Widget _movie_description(Movie movie) {

    return Container(

      padding: EdgeInsets.symmetric( horizontal: 10.0 , vertical: 20.0 ),

      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      )
    );
  }

  Widget _casting_create(String movie_id , BuildContext context) {

    final movie_provider = new MovieProvider();

    return FutureBuilder(

      future: movie_provider.get_cast(movie_id) ,
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if(snapshot.hasData) return _create_actors_page_view(snapshot.data , context);

        else return Center(

          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _create_actors_page_view(List<Actor> actors , BuildContext context) {

    return SizedBox(
      
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemBuilder: (context , i){

          return _actor_tarject(actors[i] , context);
        } ,
        itemCount: actors.length,
      )
    );   
  }

  Widget _actor_tarject(Actor actor , BuildContext context){

    final _screenSize = MediaQuery.of(context).size;


    return Container(

      child: Column(
        
        children:<Widget> [

          ClipRRect(
            
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(

              image: NetworkImage(actor.get_img()) ,
              placeholder: AssetImage('assets/img/loading.gif'),
              height: _screenSize.height * 0.21,
              fit: BoxFit.cover
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}