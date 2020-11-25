import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(

      padding: EdgeInsets.only(top:15.0),

      child: Swiper(
          itemBuilder: (BuildContext context,int index){

            movies[index].uniqueId = '${movies[index].id}--movies_now_playing';
             
            return Hero(
                tag: movies[index].uniqueId,
                child: ClipRRect(
                borderRadius:BorderRadius.circular(20.0) ,
                child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'details' , arguments: movies[index]),
                    child: FadeInImage(
                      image: NetworkImage( movies[index].get_poster_img()),
                      placeholder: AssetImage('assets/img/loading.gif'),
                      fit: BoxFit.cover
                    
                  ),
                )
              ),
            );
          },
          itemCount: movies.length,

          layout: SwiperLayout.STACK,
          itemWidth: _screenSize.width * 0.6,
          itemHeight: _screenSize.height * 0.5 ,
      ),
    );
  }
}