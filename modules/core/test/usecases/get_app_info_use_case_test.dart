import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late _MockAnalyticsProvider analyticsProvider;
  late _MockDeviceInfoRepository repository;

  setUpAll(() {
    registerFallbackValue(const AnalyticsEvent(name: 'fallback'));
  });

  setUp(() {
    analyticsProvider = _MockAnalyticsProvider();
    repository = _MockDeviceInfoRepository();
    when(() => analyticsProvider.track(any())).thenAnswer((_) async {});
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
    when(
      () => repository.getAppInfo(),
    ).thenAnswer((_) async => const Right(appInfo));
    final useCase = GetAppInfoUseCase(repository);

    await useCase(const NoParams());

    final event =
        verify(() => analyticsProvider.track(captureAny())).captured.single
            as AnalyticsEvent;
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
    when(
      () => repository.getAppInfo(),
    ).thenAnswer((_) async => const Left(failure));
    final useCase = GetAppInfoUseCase(repository);

    await useCase(const NoParams());

    final event =
        verify(() => analyticsProvider.track(captureAny())).captured.single
            as AnalyticsEvent;
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

class _MockDeviceInfoRepository extends Mock implements DeviceInfoRepository {}

class _MockAnalyticsProvider extends Mock implements AnalyticsProvider {}
