import 'package:flix_id/domain/entity/movie/movie.dart';
import 'package:flix_id/domain/entity/movie/movie_detail.dart';
import 'package:flix_id/domain/usecase/movie/get_movie_detail/get_movie_detail.dart';
import 'package:flix_id/domain/usecase/movie/get_movie_detail/get_movie_detail_params.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';
import 'package:flix_id/presentation/providers/usecase/movie/get_movie_detail/get_movie_detail_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_detail_provider.g.dart';

@riverpod
Future<MovieDetail?> movieDetail(
  MovieDetailRef ref, {
  required Movie movie,
}) async {
  GetMovieDetail getMovieDetail = ref.read(getMovieDetailProvider);

  var movieDetailResult =
      await getMovieDetail.call(GetMovieDetailParams(movie: movie));

  return switch (movieDetailResult) {
    ResultSuccess(value: final movieDetail) => movieDetail,
    ResultFailed() => null
  };
}
