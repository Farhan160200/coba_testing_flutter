import 'package:flutter/material.dart';
import 'package:coba_testing_flutter/api_service.dart';
import 'package:coba_testing_flutter/detail_movie_page.dart';
import 'package:coba_testing_flutter/response_get_all_movies.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Film'),
      ),
      body: FutureBuilder<GetAllMoviesResponse>(
        future: ApiService.getAllMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.results.isEmpty) {
            return Center(child: Text('Tidak ada film yang ditemukan'));
          } else {
            final popularMovies = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMovieCategory(context, 'FILM TERPOPULER', popularMovies.results),
                  SizedBox(height: 20),
                  FutureBuilder<GetAllMoviesResponse>(
                    future: ApiService.getAllUpcomingMovies(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.data == null || snapshot.data!.results.isEmpty) {
                        return SizedBox.shrink();
                      } else {
                        final upcomingMovies = snapshot.data!;
                        return _buildMovieCategory(context, 'UPCOMING', upcomingMovies.results);
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  FutureBuilder<GetAllMoviesResponse>(
                    future: ApiService.getNowPlaying(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.data == null || snapshot.data!.results.isEmpty) {
                        return SizedBox.shrink();
                      } else {
                        final latestMovies = snapshot.data!;
                        return _buildMovieCategory(context, 'Now Playing', latestMovies.results);
                      }
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildMovieCategory(BuildContext context, String categoryTitle, List<Result> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8), // Padding start dan end 15px, top dan bottom 8px
          child: Text(
            categoryTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () async {
                  final detailMovie = await ApiService.getDetailMovie(movie.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailMoviePage(detailMovie: detailMovie),
                    ),
                  );
                },
                child: Container(
                  width: 160,
                  margin: EdgeInsets.symmetric(horizontal: 8), // Margin sejajar dengan gambarnya
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w185/${movie.posterPath}',
                          width: 160, // Lebar gambar
                          height: 176, // Tinggi gambar
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      SizedBox(height: 4), // Jarak antara gambar dan teks
                      Padding(
                        padding: const EdgeInsets.only(left: 4), // Padding teks dari kiri
                        child: Text(
                          movie.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

}
