import 'package:dart_remote_config/fetcher/remote_config_fetcher.dart';
import 'package:dart_remote_config/model/promo_code.dart';
import 'package:dart_remote_config/model/remote_config.dart';
import 'package:dart_remote_config/model/remote_config_response.dart';
import 'package:test/test.dart';

void main() {
  test('Loading a valid remote config is successful.', () async {
    final config =
        await FileRemoteConfigFetcher('test/valid_rconfig.yaml').fetch();

    expect(config, isA<RemoteConfigResponseSuccess>());
  });

  test(
      'A remote config that satisfies a version will be returned when provided.',
      () async {
    final res = await FileRemoteConfigFetcher('test/valid_rconfig.yaml').fetch()
        as RemoteConfigResponseSuccess;

    expect(res.remoteConfigs.findConfig('3.34.0'), isA<RemoteConfig>());
  });

  test('A valid promo code will be returned when using the correct code.',
      () async {
    final res = await FileRemoteConfigFetcher('test/valid_rconfig.yaml').fetch()
        as RemoteConfigResponseSuccess;

    final config = res.remoteConfigs.findConfig('3.34.0')!;
    expect(config.findValidPromoCode("WE NEED MORE CODES"), isA<PromoCode>());
  });

  test('A valid promo will not be returned when promo code is invalid.',
      () async {
    final res = await FileRemoteConfigFetcher('test/valid_rconfig.yaml').fetch()
        as RemoteConfigResponseSuccess;

    final config = res.remoteConfigs.findConfig('3.34.0')!;
    expect(config.findValidPromoCode("TEST"), null);
  });

  test('A valid promo will not be returned when promo code is expired!.',
      () async {
    final res = await FileRemoteConfigFetcher('test/valid_rconfig.yaml').fetch()
        as RemoteConfigResponseSuccess;

    final config = res.remoteConfigs.findConfig('3.34.0')!;
    expect(config.findValidPromoCode("TEST2"), null);
  });

  test('A wrong type cast should be detected.', () async {
    final res = await FileRemoteConfigFetcher('test/wrong_type.yaml').fetch();

    expect(res, isA<RemoteConfigResponseFailure>());
    expect(
      (res as RemoteConfigResponseFailure).message,
      "type 'String' is not a subtype of type 'bool?' in type cast",
    );
  });

  test('No content in a remoteConfig should be detected.', () async {
    final res = await FileRemoteConfigFetcher('test/no_content.yaml').fetch();

    expect(res, isA<RemoteConfigResponseFailure>());
    expect(
      (res as RemoteConfigResponseFailure).message,
      'RemoteConfigParserException: Unknown type in fromJson: null',
    );
  });

  test('Wrong Date should be detected.', () async {
    final res = await FileRemoteConfigFetcher('test/wrong_date.yaml').fetch();

    expect(res, isA<RemoteConfigResponseFailure>());
    expect(
      (res as RemoteConfigResponseFailure).message,
      'FormatException: Invalid date format\n'
      '2025.06.16 20:20:39',
    );
  });

  test('Wrong Date should be detected.', () async {
    final res =
        await FileRemoteConfigFetcher('test/wrong_version.yaml').fetch();

    expect(res, isA<RemoteConfigResponseFailure>());
    expect(
      (res as RemoteConfigResponseFailure).message,
      'FormatException: Could not parse version "bla". Unknown text at "bla".',
    );
  });
}
