import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie_app_task/provider/movieProvider.dart';
import 'package:provider/provider.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  TextEditingController editingController = TextEditingController();

  var imageUrl = 'https://image.tmdb.org/t/p/w500/';

  String query = "avenger";

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<MovieProvider>(context, listen: false).getMovieList(query);
    Provider.of<MovieProvider>(context, listen: false).getGenres();
  }

  void filterSearchResults(String query) {
    Provider.of<MovieProvider>(context, listen: false)
        .getMovieList(query)
        .then((value) => {setState(() {})});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Home",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20,bottom: 20),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: editingController,
              decoration: InputDecoration(
                  hintText: "Search for movies",
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)))),
            ),
          ),
          Expanded(
            child: Consumer<MovieProvider>(
              builder: (ctx, movie, _) => ListView.builder(
                shrinkWrap: true,
                itemCount: movie.listMovie.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 200,
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.black,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: new Container(
                              margin: const EdgeInsets.all(16.0),
//                                child: new Image.network(image_url+movies[i]['poster_path'],width: 100.0,height: 100.0),
                              child: new Container(
                                width: 120.0,
                              ),
                              decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(10.0),
                                color: Colors.grey,
                                image: new DecorationImage(
                                    image: new NetworkImage(imageUrl +
                                        movie.listMovie[index].posterPath),
                                    fit: BoxFit.cover),
                                boxShadow: [
                                  new BoxShadow(
                                      color: Color(0xff3C3261),
                                      blurRadius: 5.0,
                                      offset: new Offset(2.0, 5.0))
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(top: 60),
                                  width: 150,
                                  child: Text(
                                    movie.listMovie[index].title,
                                    style: TextStyle(fontSize: 15),
                                  )),
                              Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: 150,
                                  height: 10,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: movie
                                          .listMovie[index].genreIds.length,
                                      itemBuilder: (ctx, i) {
                                        return Text(
                                            i ==
                                                    movie.listMovie[index]
                                                            .genreIds.length -
                                                        1
                                                ? movie.genres
                                                    .firstWhere((element) =>
                                                        element.id ==
                                                        movie.listMovie[index]
                                                            .genreIds[i])
                                                    .name
                                                : movie.genres
                                                        .firstWhere((element) =>
                                                            element.id ==
                                                            movie
                                                                .listMovie[
                                                                    index]
                                                                .genreIds[i])
                                                        .name +
                                                    " | ",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: HexColor("#8e8f92")));
                                      })),
                              Container(
                                  margin: EdgeInsets.only(top: 10, right: 80),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color:
                                          movie.listMovie[index].voteAverage >=
                                                  7.0
                                              ? Colors.green
                                              : Colors.blue),
                                  width: 70,
                                  child: Center(
                                    child: Text(
                                      movie.listMovie[index].voteAverage
                                              .toString() +
                                          " IMDB",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    )));
  }
}
