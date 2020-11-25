import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie_model.dart';
import 'package:peliculas/src/providers/movie_provider.dart';

class DataSearch extends SearchDelegate{

  final movie_provider = new MovieProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
      // TODO: actions of appbar

      return [
        
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: (){
            //delete text in input
            query = '';
          }
        )
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // TODO: icons in the left 

      IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow ,
          progress: transitionAnimation ,
        ),
        onPressed: (){

          close(context, null);
        },
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // TODO: create search's result 
      return Center(
        
        child:  Container(
          child: Text('esele'),
        ),
      );
    }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    if(query.isEmpty)return Container();


    return FutureBuilder(
      future: movie_provider.search_movie(query) ,
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {

          if(snapshot.hasData){

            final movies = snapshot.data;

            return ListView(

              children: movies.map((movie){

                return ListTile(
                  leading: ClipRRect(

                      borderRadius: BorderRadius.circular(20.0),
                      child: FadeInImage(

                      image: NetworkImage(movie.get_poster_img()),
                      placeholder: AssetImage('assets/img/loading.gif'),
                      width: 50.0,
                      fit: BoxFit.contain
                    ),
                  ),
                  title: Text(movie.title),
                  subtitle: Text(movie.originalLanguage),
                  onTap: (){

                    close(context, null);
                    movie.uniqueId = '';
                    Navigator.pushNamed(context,'details' , arguments: movie );
                  },
                );
              }).toList(),
            );

          }else {  

            return Center(
            child: CircularProgressIndicator(),
          );
        } 
      },
    );
  }

  /*@override
    Widget buildSuggestions(BuildContext context) {

    final suggest_list = (query.isEmpty)

                          ? now_movies 
                          : movies.where((m) => m.startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggest_list.length,
      itemBuilder: (BuildContext context, int index) {

        return ListTile(

         leading: Icon(Icons.movie),
         title: Text(suggest_list[index]), 
        ) ;
      },
    );
  }*/
}