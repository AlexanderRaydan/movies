import 'dart:convert';

class Movies {

  List<Movie> items = new List();

  Movies();

  Movies.fromJsonList(List<dynamic> jsonList){

    if (jsonList == null) return;

    for(var item in jsonList){

      final movie = new Movie.fromJsonMap(item);
      items.add(movie);
    }
  }
}


class Movie {

  String uniqueId;

  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Movie({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });


  Movie.fromJsonMap(Map <String , dynamic> json){

    popularity       = json ['popularity']/1;
    voteCount        = json ['vote_count'];
    video            = json ['video'];
    posterPath       = json ['poster_path'];
    id               = json ['id'];
    adult            = json ['adult'];
    backdropPath     = json ['backdrop_path'];
    originalLanguage = json ['original_language'];
    originalTitle    = json ['original_title'];
    genreIds         = json ['genre_ids'].cast<int>();
    title            = json ['title'];
    voteAverage      = json ['vote_average']/1;
    overview         = json ['overview'];
    releaseDate      = json ['release_date'];
  }

  get_poster_img(){

    if(posterPath == null)
      return 'https://cdn.iconscout.com/icon/free/png-512/data-not-found-1965034-1662569.png';

    return 'https://image.tmdb.org/t/p/w500/$posterPath';
  }


  get_backgound_img(){

    if(posterPath == null)
      return 'https://cdn.iconscout.com/icon/free/png-512/data-not-found-1965034-1662569.png';

    return 'https://image.tmdb.org/t/p/w500/$backdropPath';
  }
}

