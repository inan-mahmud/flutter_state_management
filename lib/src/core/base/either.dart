sealed class Either<L, R> {
  B fold<B>(B Function(L) left, B Function(R) right) {
    if (this is Left<L, R>) {
      return left((this as Left<L, R>).value);
    } else {
      return right((this as Right<L, R>).value);
    }
  }
}

class Left<L, R> extends Either<L, R> {
  final L value;

  Left(this.value);
}

class Right<L, R> extends Either<L, R> {
  final R value;

  Right(this.value);
}

Either<L, R> left<L, R>(L value) => Left(value);

Either<L, R> right<L, R>(R value) => Right(value);
