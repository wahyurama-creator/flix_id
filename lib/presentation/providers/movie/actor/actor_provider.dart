import 'package:flix_id/domain/entity/actor/actor.dart';
import 'package:flix_id/domain/usecase/movie/get_actor/get_actor.dart';
import 'package:flix_id/domain/usecase/movie/get_actor/get_actor_params.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';
import 'package:flix_id/presentation/providers/usecase/movie/get_actor/get_actor_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'actor_provider.g.dart';

@riverpod
Future<List<Actor>> actor(ActorRef ref, {required int movieId}) async {
  GetActor getActor = ref.read(getActorProvider);
  var getActorResult = await getActor.call(GetActorParams(id: movieId));

  return switch (getActorResult) {
    ResultSuccess(value: final actor) => actor,
    ResultFailed() => []
  };
}
