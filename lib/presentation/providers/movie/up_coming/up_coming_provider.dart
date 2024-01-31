import 'package:flix_id/domain/entity/movie/movie.dart';
import 'package:flix_id/domain/usecase/movie/get_movie_list/get_movie_list.dart';
import 'package:flix_id/domain/usecase/movie/get_movie_list/get_movie_list_params.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../usecase/movie/get_movie_list/get_movie_list_provider.dart';

part 'up_coming_provider.g.dart';

@Riverpod(keepAlive: true)
class UpComing extends _$UpComing {
  @override
  FutureOr<List<Movie>> build() => const [];

  Future<void> getMovies({int page = 1}) async {
    state = const AsyncLoading();

    GetMovieList getMovieList = ref.read(getMovieListProvider);
    var result = await getMovieList(
      GetMovieListParams(category: MovieListCategories.upComing, page: page),
    );

    switch (result) {
      case ResultSuccess(value: final movies):
        state = AsyncData(movies);
      case ResultFailed(message: _):
        state = const AsyncData([]);
    }
  }
}