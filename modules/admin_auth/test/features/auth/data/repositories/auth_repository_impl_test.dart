import 'package:admin_auth/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:admin_auth/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late _MockAuthRemoteDataSource remoteDataSource;
  late _MockTokenStorage tokenStorage;
  late AuthRepositoryImpl repository;

  setUp(() {
    remoteDataSource = _MockAuthRemoteDataSource();
    tokenStorage = _MockTokenStorage();
    when(() => remoteDataSource.logOut()).thenAnswer((_) async {});
    when(() => tokenStorage.clearTokens()).thenAnswer((_) async {});
    repository = AuthRepositoryImpl(remoteDataSource, tokenStorage);
  });

  test('logout clears local tokens after a successful remote logout', () async {
    final result = await repository.logOut();

    expect(result.isRight(), isTrue);
    verify(() => remoteDataSource.logOut()).called(1);
    verify(() => tokenStorage.clearTokens()).called(1);
  });

  test('logout still clears local tokens when remote logout fails', () async {
    when(
      () => remoteDataSource.logOut(),
    ).thenThrow(Exception('network unavailable'));

    final result = await repository.logOut();

    expect(result.isLeft(), isTrue);
    verify(() => remoteDataSource.logOut()).called(1);
    verify(() => tokenStorage.clearTokens()).called(1);
  });
}

class _MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class _MockTokenStorage extends Mock implements TokenStorage {}
