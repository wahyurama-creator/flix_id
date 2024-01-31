/// [R] is Return type and [P] is Parameter
abstract interface class BaseUseCase<R, P> {
  Future<R> call(P params);
}