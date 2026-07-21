//ignore_for_file: document_ignores, one_member_abstracts

import 'package:core/utils/typedef.dart';

abstract class UseCase<T, Params> {
  FutureEither<T> call(Params params);
}

abstract interface class StreamUseCase<T, Params> {
  StreamEither<T> connect(Params params);
  Future<void> disconnect();
}

class NoParams {
  const NoParams();
}
