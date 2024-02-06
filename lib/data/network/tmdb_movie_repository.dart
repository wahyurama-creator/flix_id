import 'package:dio/dio.dart';
import 'package:flix_id/data/repository/movie/movie_repository.dart';
import 'package:flix_id/domain/entity/actor/actor.dart';
import 'package:flix_id/domain/entity/movie/movie.dart';
import 'package:flix_id/domain/entity/movie/movie_detail.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TmdbMovieRepository implements MovieRepository {
  final Dio? _dio;

  TmdbMovieRepository({Dio? dio}) : _dio = dio ?? Dio();

  late final Options _options = Options(
    headers: {
      'Authorization': 'Bearer ${dotenv.env['TMDB_ACCESS_TOKEN']}',
      'accept': 'application/json',
    },
  );

  @override
  Future<ResultWrapper<List<Movie>>> getNowPlaying({int page = 1}) async =>
      _getMovies(_MovieCategory.nowPlaying.toString(), page: page);

  @override
  Future<ResultWrapper<List<Movie>>> geUpcoming({int page = 1}) =>
      _getMovies(_MovieCategory.upcoming.toString(), page: page);

  @override
  Future<ResultWrapper<List<Actor>>> getActors({required int id}) async {
    try {
      final response = await _dio!.get(
        '${dotenv.env['TMDB_BASE_URL']}/movie/$id/credits',
        queryParameters: {
          'language': 'en-US',
        },
        options: _options,
      );

      final results = List<Map<String, dynamic>>.from(response.data['cast']);

      return ResultWrapper.success(
          results.map((e) => Actor.fromMap(e)).toList());
    } on DioException catch (e) {
      return ResultWrapper.failed(e.message.toString());
    }
  }

  @override
  Future<ResultWrapper<MovieDetail>> getDetail({required int id}) async {
    try {
      final response = _dio!.get(
        '${dotenv.env['TMDB_BASE_URL']}/movie/$id',
        queryParameters: {
          'language': 'en-US',
        },
        options: _options,
      );
      final result =
          await response.then((value) => MovieDetail.fromMap(value.data));
      return ResultWrapper.success(result);
    } on DioException catch (e) {
      return ResultWrapper.failed(e.message.toString());
    }
  }

  Future<ResultWrapper<List<Movie>>> _getMovies(String category,
      {int page = 1}) async {
    try {
      final response = await _dio!.get(
        '${dotenv.env['TMDB_BASE_URL']}/movie/$category',
        queryParameters: {
          'language': 'en-US',
          'page': page,
        },
        options: _options,
      );

      final results = List<Map<String, dynamic>>.from(response.data['results']);
      return ResultWrapper.success(
        results
            .map(
              (e) => Movie.fromMap(e),
            )
            .toList(),
      );
    } on DioException catch (e) {
      return ResultWrapper.failed(e.message.toString());
    }
  }
}

enum _MovieCategory {
  nowPlaying('now_playing'),
  upcoming('upcoming');

  final String _value;

  const _MovieCategory(String value) : _value = value;

  @override
  String toString() => _value;
}
