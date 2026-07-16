import 'package:client_auth/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:client_auth/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late _MockAuthRemoteDataSource remoteDataSource;
  late _MockTokenStorage tokenStorage;
  late _MockDeviceInfoService deviceInfoService;
  late AuthRepositoryImpl repository;

  setUp(() {
    remoteDataSource = _MockAuthRemoteDataSource();
    tokenStorage = _MockTokenStorage();
    deviceInfoService = _MockDeviceInfoService();
    when(() => remoteDataSource.logOut()).thenAnswer((_) async {});
    when(() => tokenStorage.clearTokens()).thenAnswer((_) async {});
    repository = AuthRepositoryImpl(
      remoteDataSource,
      tokenStorage,
      deviceInfoService,
    );
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

class _MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class _MockTokenStorage extends Mock implements TokenStorage {}

class _MockDeviceInfoService extends Mock implements DeviceInfoService {}
