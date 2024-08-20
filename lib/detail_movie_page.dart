import 'package:coba_testing_flutter/detail_movies_response.dart';
import 'package:coba_testing_flutter/api_service.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'detail_video_response.dart';

class DetailMoviePage extends StatefulWidget {
  final DetailMoviesResponse detailMovie;

  const DetailMoviePage({Key? key, required this.detailMovie}) : super(key: key);

  @override
  _DetailMoviePageState createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  String? _trailerKey;
  YoutubePlayerController? _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    _fetchTrailer();
  }

  Future<void> _fetchTrailer() async {
    try {
      final videoResponse = await ApiService.getDetailVideo(widget.detailMovie.id);
      final trailer = videoResponse.results.firstWhere(
            (video) => video.type == 'Trailer' && video.site == 'YouTube',
        orElse: () => VideoResult(
          iso6391: '',
          iso31661: '',
          name: '',
          key: '',
          site: '',
          size: 0,
          type: '',
          official: false,
          publishedAt: '',
          id: '',
        ),
      );
      if (trailer.key.isNotEmpty) {
        setState(() {
          _trailerKey = trailer.key;
          _youtubePlayerController = YoutubePlayerController(
            initialVideoId: _trailerKey!,
            flags: YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
            ),
          );
        });
      }
    } catch (e) {
      print('Error fetching trailer: $e');
    }
  }

  @override
  void dispose() {
    _youtubePlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.detailMovie.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (widget.detailMovie.posterPath != null)
              Image.network(
                'https://image.tmdb.org/t/p/w500${widget.detailMovie.posterPath}',
                width: 200,
                height: 300,
              ),
            SizedBox(height: 16),
            Text(
              'Title: ${widget.detailMovie.title}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Release Date: ${widget.detailMovie.releaseDate}'),
            SizedBox(height: 8),
            Text('Vote Average: ${widget.detailMovie.voteAverage}'),
            SizedBox(height: 8),
            Text('Overview: ${widget.detailMovie.overview}'),
            SizedBox(height: 16),
            if (_trailerKey != null)
              Column(
                children: [
                  Text(
                    'Watch Trailer',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  YoutubePlayer(
                    controller: _youtubePlayerController!,
                    showVideoProgressIndicator: true,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
