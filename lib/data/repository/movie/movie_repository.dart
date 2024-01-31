import 'package:flix_id/domain/entity/actor/actor.dart';
import 'package:flix_id/domain/entity/movie/movie.dart';
import 'package:flix_id/domain/entity/movie/movie_detail.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';

abstract interface class MovieRepository {
  Future<ResultWrapper<List<Movie>>> getNowPlaying({int page = 1});

  Future<ResultWrapper<List<Movie>>> geUpcoming({int page = 1});

  Future<ResultWrapper<MovieDetail>> getDetail({required int id});

  Future<ResultWrapper<List<Actor>>> getActors({required int id});
}
