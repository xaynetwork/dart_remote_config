import 'package:dart_remote_config/fetcher/cache_strategy.dart';
import 'package:dart_remote_config/fetcher/remote_config_fetcher.dart';
import 'package:dart_remote_config/model/known_experiment_variant.dart';
import 'package:dart_remote_config/model/promo_code.dart';
import 'package:dart_remote_config/model/remote_config.dart';
import 'package:dart_remote_config/model/remote_config_response.dart';
import 'package:dart_remote_config/repository/remote_config_repository.dart';
import 'package:pub_semver/pub_semver.dart';
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

    expect(res.remoteConfigs.findConfig(Version.parse('3.34.0')),
        isA<RemoteConfig>());
  });

  test('A valid promo code will be returned when using the correct code.',
      () async {
    final res = await FileRemoteConfigFetcher('test/valid_rconfig.yaml').fetch()
        as RemoteConfigResponseSuccess;

    final config = res.remoteConfigs.findConfig(Version.parse('3.34.0'))!;
    expect(config.findValidPromoCode("WE NEED MORE CODES"), isA<PromoCode>());
  });

  test('A valid promo will not be returned when promo code is invalid.',
      () async {
    final res = await FileRemoteConfigFetcher('test/valid_rconfig.yaml').fetch()
        as RemoteConfigResponseSuccess;

    final config = res.remoteConfigs.findConfig(Version.parse('3.34.0'))!;
    expect(config.findValidPromoCode("TEST"), null);
  });

  test('A valid promo will not be returned when promo code is expired!.',
      () async {
    final res = await FileRemoteConfigFetcher('test/valid_rconfig.yaml').fetch()
        as RemoteConfigResponseSuccess;

    final config = res.remoteConfigs.findConfig(Version.parse('3.34.0'))!;
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

  test('Cache Strategy should return first the default file', () async {
    const fallbackFile = """
- appVersion: ">3.33.0 <4.0.0"
  features:
    - feature:
      id: fallback
    """;

    const serverFile = """
- appVersion: ">3.33.0 <4.0.0"
  features:
    - feature:
      id: server
    """;
    final repository = InMemoryRepository();
    final cache = CacheOnlyUpdateUnawaited(
      repository,
      () async => fallbackFile,
    );

    final returnedFile = await cache.fetch(() async => serverFile);

    expect(returnedFile, fallbackFile);
    await cache.fetchFuture;
    expect(await repository.readRemoteConfig(), serverFile);
  });

  test('Cache should return the repository content on the second try',
      () async {
    const fallbackFile = """
- appVersion: ">3.33.0 <4.0.0"
  features:
    - feature:
      id: fallback
    """;

    const serverFile = """
- appVersion: ">3.33.0 <4.0.0"
  features:
    - feature:
      id: server
    """;

    const repositoryFile = """
- appVersion: ">3.33.0 <4.0.0"
  features:
    - feature:
      id: repository
    """;
    final repo = InMemoryRepository();
    await repo.saveRemoteConfig(repositoryFile);
    final cache = CacheOnlyUpdateUnawaited(
      repo,
      () async => fallbackFile,
    );

    final returnedFile = await cache.fetch(() async => serverFile);

    expect(returnedFile, repositoryFile);
  });
}

class InMemoryRepository extends RemoteConfigRepository {
  String? _rconfig;
  Set<KnownVariantId> _variants = {};

  @override
  Future<String?> readRemoteConfig() async => _rconfig;

  @override
  Future<Set<KnownVariantId>> readSubscribedVariantIds() async => _variants;

  @override
  Future<void> saveRemoteConfig(String remoteConfig) async {
    _rconfig = remoteConfig;
  }

  @override
  Future<void> saveSubscribedVariantsIds(
      Set<KnownVariantId> subscribedVariantIds) async {
    _variants = subscribedVariantIds;
  }
}
