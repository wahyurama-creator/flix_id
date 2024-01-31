import 'package:flix_id/data/repository/movie/movie_repository.dart';
import 'package:flix_id/domain/entity/actor/actor.dart';
import 'package:flix_id/domain/usecase/base_usecase.dart';
import 'package:flix_id/domain/usecase/movie/get_actor/get_actor_params.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';

class GetActor
    implements BaseUseCase<ResultWrapper<List<Actor>>, GetActorParams> {
  final MovieRepository _movieRepository;

  GetActor({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  @override
  Future<ResultWrapper<List<Actor>>> call(GetActorParams params) async {
    var result = await _movieRepository.getActors(id: params.id);

    return switch (result) {
      ResultSuccess(value: final actors) => ResultWrapper.success(actors),
      ResultFailed(:final message) => ResultWrapper.failed(message),
    };
  }
}
