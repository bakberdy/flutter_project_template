import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UsersRepositoryRequestHandler {
  const UsersRepositoryRequestHandler();

  FutureEither<T> execute<T>(
    Future<T> Function() request, {
    required String source,
  }) async {
    try {
      return Right(await request());
    } on Exception catch (exception) {
      if (exception is ApiException &&
          exception.type == ApiExceptionType.cancel) {
        return Left(Failure.requestCancelled(source));
      }
      return Left(await exception.toFailure(source: source));
    }
  }
}
