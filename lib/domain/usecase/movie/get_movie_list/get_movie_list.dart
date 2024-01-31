import 'package:flix_id/data/repository/movie/movie_repository.dart';
import 'package:flix_id/domain/entity/movie/movie.dart';
import 'package:flix_id/domain/usecase/base_usecase.dart';
import 'package:flix_id/domain/usecase/movie/get_movie_list/get_movie_list_params.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';

class GetMovieList
    implements BaseUseCase<ResultWrapper<List<Movie>>, GetMovieListParams> {
  final MovieRepository _movieRepository;

  GetMovieList({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<ResultWrapper<List<Movie>>> call(GetMovieListParams params) async {
    var movieResult = switch (params.category) {
      MovieListCategories.nowPlaying =>
        await _movieRepository.getNowPlaying(page: params.page),
      MovieListCategories.upComing =>
        await _movieRepository.geUpcoming(page: params.page),
    };

    return switch (movieResult) {
      ResultSuccess(value: final movies) => ResultWrapper.success(movies),
      ResultFailed(:final message) => ResultWrapper.failed(message),
    };
  }
}
