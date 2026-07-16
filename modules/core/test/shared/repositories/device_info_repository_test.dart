import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  const appInfo = AppInfo(
    appName: 'Template',
    packageName: 'com.example.template',
    version: '1.2.3',
    buildNumber: '42',
    buildSignature: 'signature',
    installerStore: 'store',
  );

  group('DeviceInfoRepository.getAppInfo', () {
    test('returns app info from the service', () async {
      final service = _MockDeviceInfoService();
      when(service.getAppInfo).thenAnswer((_) async => appInfo);
      final repository = DeviceInfoRepositoryImpl(service);

      final result = await repository.getAppInfo();

      expect(
        result.getOrElse(() => throw StateError('Expected app info')),
        appInfo,
      );
    });

    test('maps service errors to a failure', () async {
      final service = _MockDeviceInfoService();
      when(
        service.getAppInfo,
      ).thenThrow(Exception('package info unavailable'));
      final repository = DeviceInfoRepositoryImpl(service);

      final result = await repository.getAppInfo();

      expect(result.isLeft(), isTrue);
      result.fold((failure) {
        expect(failure.source, 'DeviceInfoRepository.getAppInfo');
        expect(failure.message, contains('package info unavailable'));
      }, (_) => fail('Expected a failure'));
    });
  });
}

class _MockDeviceInfoService extends Mock implements DeviceInfoService {}
