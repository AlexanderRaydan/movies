import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/movie_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';


class HomePage extends StatelessWidget {

  final movie_provider = new MovieProvider();

  @override
  Widget build(BuildContext context) {

    movie_provider.get_popular_movies();

    return Scaffold(
      
      appBar: AppBar(

        title: Text('Movies in theaters'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget> [
          IconButton(icon: Icon(Icons.search), onPressed: (){

            showSearch(context: context, delegate: DataSearch());
          })
        ],
      ),
      body: Container(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget> [
            
            _swiperTarjects() ,
            _footer(context)
            
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjects(){

    return FutureBuilder(
      future: movie_provider.get_now_playing(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {

        if(snapshot.hasData)  

          return CardSwiper(movies:snapshot.data);

        else 

          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
          )
        );
      },  
    );    
  }

  Widget _footer( BuildContext context) {

      return Container(

        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Container(
              
              padding: EdgeInsets.only(left: 20.0),
              child :  Text('Populars', style: Theme.of(context).textTheme.subhead) ,
            ),

            SizedBox(height: 8.0,) ,

            StreamBuilder(
              stream: movie_provider.popularsStream,
              builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {

              if(snapshot.hasData)  

                return HorizontalMovie(

                  movies:snapshot.data ,
                  next_page: movie_provider.get_popular_movies,
                );

              else 

                return Container(
                  height: 400.0,
                  child: Center(
                    child: CircularProgressIndicator()
                )
              );
            },  
          )
        ],
      ),
    );
  }
}