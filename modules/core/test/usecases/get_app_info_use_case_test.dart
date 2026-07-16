import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late _RecordingAnalyticsProvider analyticsProvider;

  setUp(() {
    analyticsProvider = _RecordingAnalyticsProvider();
    Analytics.initialize([analyticsProvider]);
  });

  tearDown(() => Analytics.initialize([]));

  test('tracks app version and build number on success', () async {
    const appInfo = AppInfo(
      appName: 'Template',
      packageName: 'com.example.template',
      version: '1.2.3',
      buildNumber: '42',
      buildSignature: 'signature',
      installerStore: 'store',
    );
    final useCase = GetAppInfoUseCase(
      _FakeDeviceInfoRepository(result: const Right(appInfo)),
    );

    await useCase(const NoParams());

    final event = analyticsProvider.events.single;
    expect(event.name, 'get_app_info_usecase_success');
    expect(event.properties, {
      AnalyticsPropertyKeys.appVersion: '1.2.3',
      'build_number': '42',
    });
  });

  test('tracks failure metadata on failure', () async {
    const failure = Failure(
      message: 'Package info unavailable',
      source: 'DeviceInfoRepository.getAppInfo',
    );
    final useCase = GetAppInfoUseCase(
      _FakeDeviceInfoRepository(result: const Left(failure)),
    );

    await useCase(const NoParams());

    final event = analyticsProvider.events.single;
    expect(event.name, 'get_app_info_usecase_failure');
    expect(
      event.properties?[AnalyticsPropertyKeys.failureMessage],
      failure.message,
    );
    expect(
      event.properties?[AnalyticsPropertyKeys.failureSource],
      failure.source,
    );
  });
}

class _FakeDeviceInfoRepository implements DeviceInfoRepository {
  const _FakeDeviceInfoRepository({required this.result});

  final Either<Failure, AppInfo> result;

  @override
  FutureEither<AppInfo> getAppInfo() async => result;

  @override
  FutureEither<AppDeviceInfo> getDeviceInfo() => throw UnimplementedError();
}

class _RecordingAnalyticsProvider implements AnalyticsProvider {
  final events = <AnalyticsEvent>[];

  @override
  Future<void> track(AnalyticsEvent event) async => events.add(event);

  @override
  Future<void> setUserId(String? userId) async {}

  @override
  Future<void> setUserProperty(Map<String, dynamic> properties) async {}
}
