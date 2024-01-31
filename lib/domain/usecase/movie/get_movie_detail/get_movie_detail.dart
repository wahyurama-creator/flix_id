import 'package:flix_id/data/repository/movie/movie_repository.dart';
import 'package:flix_id/domain/entity/movie/movie_detail.dart';
import 'package:flix_id/domain/usecase/base_usecase.dart';
import 'package:flix_id/domain/usecase/movie/get_movie_detail/get_movie_detail_params.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';

class GetMovieDetail
    implements BaseUseCase<ResultWrapper<MovieDetail>, GetMovieDetailParams> {
  final MovieRepository _movieRepository;

  GetMovieDetail({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<ResultWrapper<MovieDetail>> call(GetMovieDetailParams params) async {
    var result = await _movieRepository.getDetail(id: params.movie.id);

    return switch (result) {
      ResultSuccess(value: final movieDetail) =>
        ResultWrapper.success(movieDetail),
      ResultFailed(:final message) => ResultWrapper.failed(message),
    };
  }
}
