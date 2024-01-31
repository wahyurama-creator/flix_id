enum MovieListCategories { nowPlaying, upComing }

class GetMovieListParams {
  final int page;
  final MovieListCategories category;

  GetMovieListParams({this.page = 1, required this.category});
}
