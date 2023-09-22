sealed class Result<T> {}

class Init<T> extends Result<T> {}

class Loading<T> extends Result<T> {}

class Success<T> extends Result<T> {
  final T data;

  Success(this.data);
}

class Error<T> extends Result<T> {
  final String message;

  Error(this.message);
}

extension ResultExtensions<T> on Result<T> {
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(String message) failure,
  }) {
    if (this is Init<T>) {
      return initial.call();
    } else if (this is Loading<T>) {
      return loading.call();
    } else if (this is Success<T>) {
      return success.call((this as Success<T>).data);
    } else if (this is Error<T>) {
      return failure.call((this as Error<T>).message);
    } else {
      throw Exception('Unhandled state: $this');
    }
  }

  R? maybeWhen<R>({
    R? Function()? initial,
    R? Function()? loading,
    R? Function(T data)? success,
    R? Function(String message)? failure,
    R? Function()? orElse,
  }) {
    if (this is Init<T>) {
      return initial?.call();
    } else if (this is Loading<T>) {
      return loading?.call();
    } else if (this is Success<T>) {
      return success?.call((this as Success<T>).data);
    } else if (this is Error<T>) {
      return failure?.call((this as Error<T>).message);
    } else {
      return orElse?.call();
    }
  }
}