class GetAllMoviesResponse {
  final List<Result> results;

  GetAllMoviesResponse({required this.results});

  factory GetAllMoviesResponse.fromJson(Map<String, dynamic> json) {
    List<Result> results = [];
    for (var item in json['results']) {
      results.add(Result.fromJson(item));
    }
    return GetAllMoviesResponse(results: results);
  }
}

class Result {
  final int id;
  final String title;
  final String releaseDate;
  final double voteAverage;
  final String posterPath;

  Result({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
    required this.posterPath,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['id'],
      title: json['title'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average']?.toDouble() ?? 0.0,
      posterPath: json['poster_path'] ?? '',
    );
  }
}
