sealed class ResultWrapper<T> {
  const ResultWrapper();

  const factory ResultWrapper.success(T value) = ResultSuccess;

  const factory ResultWrapper.failed(String message) = ResultFailed;

  bool get isSuccess => this is ResultSuccess<T>;

  bool get isFailed => this is ResultFailed<T>;

  T? get resultValue => isSuccess ? (this as ResultSuccess<T>).value : null;

  String? get errorMessage =>
      isFailed ? (this as ResultFailed<T>).message : null;
}

class ResultSuccess<T> extends ResultWrapper<T> {
  final T value;

  const ResultSuccess(this.value);
}

class ResultFailed<T> extends ResultWrapper<T> {
  final String message;

  const ResultFailed(this.message);
}
