import 'package:client_auth/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:client_auth/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late _FakeAuthRemoteDataSource remoteDataSource;
  late _FakeTokenStorage tokenStorage;
  late AuthRepositoryImpl repository;

  setUp(() {
    remoteDataSource = _FakeAuthRemoteDataSource();
    tokenStorage = _FakeTokenStorage();
    repository = AuthRepositoryImpl(
      remoteDataSource,
      tokenStorage,
      _FakeDeviceInfoService(),
    );
  });

  test('logout clears local tokens after a successful API request', () async {
    final result = await repository.logOut();

    expect(result.isRight(), isTrue);
    expect(remoteDataSource.logoutCalls, 1);
    expect(tokenStorage.clearCalls, 1);
  });

  test('logout clears local tokens when the API request fails', () async {
    remoteDataSource.logoutError = Exception('offline');

    final result = await repository.logOut();

    expect(result.isLeft(), isTrue);
    expect(remoteDataSource.logoutCalls, 1);
    expect(tokenStorage.clearCalls, 1);
  });
}

class _FakeAuthRemoteDataSource implements AuthRemoteDataSource {
  int logoutCalls = 0;
  Exception? logoutError;

  @override
  Future<void> logOut() async {
    logoutCalls++;
    if (logoutError case final error?) {
      throw error;
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeTokenStorage implements TokenStorage {
  int clearCalls = 0;

  @override
  Future<void> clearTokens() async {
    clearCalls++;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeDeviceInfoService implements DeviceInfoService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
