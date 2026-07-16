import 'package:admin_profile/src/features/profile/data/datasources/user_profile_remote_data_source.dart';
import 'package:admin_profile/src/features/profile/data/repositories/user_profile_repository_impl.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late _MockUserProfileRemoteDataSource remoteDataSource;
  late _MockTokenStorage tokenStorage;
  late UserProfileRepositoryImpl repository;

  setUp(() {
    remoteDataSource = _MockUserProfileRemoteDataSource();
    tokenStorage = _MockTokenStorage();
    when(() => remoteDataSource.logOut()).thenAnswer((_) async {});
    when(() => tokenStorage.clearTokens()).thenAnswer((_) async {});
    repository = UserProfileRepositoryImpl(remoteDataSource, tokenStorage);
  });

  test('logout clears local tokens after a successful API request', () async {
    final result = await repository.logOut();

    expect(result.isRight(), isTrue);
    verify(() => remoteDataSource.logOut()).called(1);
    verify(() => tokenStorage.clearTokens()).called(1);
  });

  test('logout clears local tokens when the API request fails', () async {
    when(() => remoteDataSource.logOut()).thenThrow(Exception('offline'));

    final result = await repository.logOut();

    expect(result.isLeft(), isTrue);
    verify(() => remoteDataSource.logOut()).called(1);
    verify(() => tokenStorage.clearTokens()).called(1);
  });
}

class _MockUserProfileRemoteDataSource extends Mock
    implements UserProfileRemoteDataSource {}

class _MockTokenStorage extends Mock implements TokenStorage {}
